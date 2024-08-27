

# Education Crowdfunding Platform
![crowdfund](https://github.com/user-attachments/assets/57c3dff9-7e77-49c8-b805-781edf328127)


## Vision

The Education Crowdfunding Platform is designed to empower students by providing a decentralized, transparent, and secure way to crowdfund their education fees using blockchain technology. Our vision is to create a community-driven platform where students can raise funds for their educational needs, and donors can contribute with confidence, knowing their contributions are securely managed and efficiently utilized.

## How It Works

1. **Campaign Creation**: Students create a campaign by specifying their funding goal and deadline.
2. **Contribute Funds**: Donors contribute ETH to support a student's campaign before the deadline.
3. **Withdraw Funds**: If the campaign reaches its funding goal by the deadline, the student can withdraw the funds.
4. **Refunds**: If the campaign does not meet the funding goal by the deadline, donors can withdraw their contributions.

## Flowchart

```plaintext
+-----------------+
|  Student        |
|  Creates        |
|  Campaign       |
+-------+---------+
        |
        v
+-------+---------+
|  Donor          |
|  Contributes    |
|  Funds          |
+-------+---------+
        |
        v
+-------+---------+
|  Deadline       |
|  Reached?       |
+-------+---------+
        |
     +--+---+
     | Yes  |
     v      |
+----+----+ | No
|  Goal    | |
|  Reached?| |
+----+----+ |
     |       v
  +--+---+  +--------------------+
  | Yes   |  | Refund Donors     |
  v       |  +--------------------+
+---------+
| Withdraw |
|  Funds   |
+---------+
```

## Contract Address

The smart contract is deployed on the Ethereum network. You can interact with the contract at the following address:

**Contract Address**: 0x46f2D555ce157fA86ed58784E819766e720f96f5

> _Please ensure you are interacting with the correct contract address to avoid any loss of funds._

## Functions Overview

- **createCampaign(uint256 _goal, uint256 _duration)**: Allows a student to create a new crowdfunding campaign by setting a funding goal and duration.
- **contribute(uint256 _campaignId)**: Enables donors to contribute ETH to a specific campaign.
- **withdrawFunds(uint256 _campaignId)**: Allows students to withdraw funds if the campaign reaches its funding goal by the deadline.
- **refund(uint256 _campaignId)**: Provides a refund to donors if the campaign does not meet its funding goal by the deadline.
- **getCampaignDetails(uint256 _campaignId)**: Returns the details of a specific campaign, including the student's address, goal, deadline, amount raised, and withdrawal status.

## Future Scope

- **Multi-Currency Support**: Enable contributions in multiple cryptocurrencies.
- **Milestone-Based Withdrawals**: Implement milestone-based fund releases for better fund management.
- **Enhanced Security**: Integrate more robust security measures and smart contract audits.
- **Reputation System**: Develop a reputation system for students and donors to encourage trust and transparency.
- **Mobile App Integration**: Launch a mobile app for easier access and management of campaigns and contributions.

## Contact

For more information or to get involved, please contact:

- **Name**: Papri Chakraborty
- **Email**: paprichakraborty38@gmail.com
- **LinkedIn**: https://www.linkedin.com/in/papri-chakraborty-153344287/
- **GitHub**: https://github.com/Paprich

---

Feel free to modify the README to better fit your specific project details and contact information.
