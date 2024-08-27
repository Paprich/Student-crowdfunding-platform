// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EducationCrowdfunding {
    struct Campaign {
        address payable student;  // Address of the student raising funds
        uint256 goal;             // Funding goal in wei
        uint256 deadline;         // Deadline for raising funds
        uint256 amountRaised;     // Total amount raised
        bool fundsWithdrawn;      // Track if funds have been withdrawn
        mapping(address => uint256) contributions; // Mapping of contributors to their contributed amounts
    }

    uint256 public campaignCount;  // Counter for campaign IDs
    mapping(uint256 => Campaign) public campaigns;  // Mapping of campaign IDs to Campaigns

    event CampaignCreated(uint256 campaignId, address student, uint256 goal, uint256 deadline);
    event ContributionMade(uint256 campaignId, address contributor, uint256 amount);
    event FundsWithdrawn(uint256 campaignId, uint256 amount);
    event RefundIssued(uint256 campaignId, address contributor, uint256 amount);

    /**
     * @notice Create a new crowdfunding campaign for education fees.
     * @param _goal The funding goal in wei.
     * @param _duration The duration of the campaign in seconds.
     */
    function createCampaign(uint256 _goal, uint256 _duration) external {
        require(_goal > 0, "Funding goal must be greater than 0");
        require(_duration > 0, "Campaign duration must be greater than 0");

        campaignCount++;
        Campaign storage newCampaign = campaigns[campaignCount];
        newCampaign.student = payable(msg.sender);
        newCampaign.goal = _goal;
        newCampaign.deadline = block.timestamp + _duration;
        newCampaign.amountRaised = 0;
        newCampaign.fundsWithdrawn = false;

        emit CampaignCreated(campaignCount, msg.sender, _goal, newCampaign.deadline);
    }

    /**
     * @notice Contribute to a specific campaign.
     * @param _campaignId The ID of the campaign to contribute to.
     */
    function contribute(uint256 _campaignId) external payable {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp < campaign.deadline, "Campaign has ended");
        require(msg.value > 0, "Contribution must be greater than 0");

        campaign.contributions[msg.sender] += msg.value;
        campaign.amountRaised += msg.value;

        emit ContributionMade(_campaignId, msg.sender, msg.value);
    }

    /**
     * @notice Withdraw funds if the campaign is successful.
     * @param _campaignId The ID of the campaign to withdraw funds from.
     */
    function withdrawFunds(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];
        require(msg.sender == campaign.student, "Only the student can withdraw funds");
        require(block.timestamp >= campaign.deadline, "Cannot withdraw before deadline");
        require(campaign.amountRaised >= campaign.goal, "Funding goal not reached");
        require(!campaign.fundsWithdrawn, "Funds have already been withdrawn");

        campaign.fundsWithdrawn = true;
        uint256 amount = campaign.amountRaised;
        campaign.amountRaised = 0;
        campaign.student.transfer(amount);

        emit FundsWithdrawn(_campaignId, amount);
    }

    /**
     * @notice Refund contributors if the campaign fails to meet its goal.
     * @param _campaignId The ID of the campaign for which to issue refunds.
     */
    function refund(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp >= campaign.deadline, "Campaign is still ongoing");
        require(campaign.amountRaised < campaign.goal, "Funding goal was reached");

        uint256 contributedAmount = campaign.contributions[msg.sender];
        require(contributedAmount > 0, "No contributions to refund");

        campaign.contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributedAmount);

        emit RefundIssued(_campaignId, msg.sender, contributedAmount);
    }

    /**
     * @notice Get details of a specific campaign.
     * @param _campaignId The ID of the campaign.
     * @return The student's address, goal, deadline, amount raised, and withdrawal status.
     */
    function getCampaignDetails(uint256 _campaignId) external view returns (address, uint256, uint256, uint256, bool) {
        Campaign storage campaign = campaigns[_campaignId];
        return (campaign.student, campaign.goal, campaign.deadline, campaign.amountRaised, campaign.fundsWithdrawn);
    }
}
