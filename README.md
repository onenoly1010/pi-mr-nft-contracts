<!-- REPO_STATUS_BANNER_START -->
> **Repository Status:** ACTIVE — PRODUCTION CONTRACT CANON  
> **Public Review Note:** This repository is explicitly classified to prevent ambiguity between production canon, support infrastructure, historical archives, and demos.
<!-- REPO_STATUS_BANNER_END -->

# OINIO - The First Sovereign AI Economy

**Deployer:** `0xd41691b61a2f85CBf3915BFE65C8D01772c18460`  
**Network:** Pi Network (Chain ID: 314159)  
**Website:** [quantumpiforge.com](https://quantumpiforge.com)  
**Twitter:** [@Onenoly11](https://twitter.com/Onenoly11)

## 🚀 Quick Deploy

### Deploy to Railway (One-Click)

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/onenoly1010/pi-mr-nft-contracts)

**Required Environment Variables:**
- `DEPLOYER_ADDRESS` - Your wallet address
- `PRIVATE_KEY` - Your deployer private key (keep secure!)
- `PI_RPC_URL` - Pi Network RPC endpoint

Click the button above, connect your GitHub, set the environment variables, and deploy! 🎉

## 🎯 Vision

OINIO establishes the first sovereign AI economy on Pi Network, where AI models earn perpetual inference royalties while builders receive catalyst rewards through an autonomous governance system. This creates a self-sustaining ecosystem that rewards innovation without central control.

## 🔑 Core Identity

**Complete Sovereignty**: OINIO operates as a fully autonomous system with:
- No admin keys or privileged access
- Immutable smart contracts
- Community-driven governance
- Transparent on-chain operations
- Perpetual model creator royalties

## ✨ Key Features

### ModelRoyaltyNFT
- **Perpetual Inference Royalties**: 10-30% royalties on every AI inference
- **Immutable Ownership**: Model creators retain perpetual rights
- **Transparent Attribution**: On-chain proof of model lineage
- **Performance Tracking**: Built-in benchmark score field for future integration
- **ERC-721 Standard**: Full NFT compatibility and transferability

### CatalystPool (Coming Soon)
- **12M Pi Catalyst Pool**: Massive rewards for ecosystem builders
- **8x Multiplier**: Amplifies creator royalties by 800%
- **90-Day Taper**: Balanced reward distribution over time
- **Fair Distribution**: Proportional rewards based on usage
- **Autonomous Operation**: No centralized control

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                   OINIO Ecosystem                    │
├─────────────────────────────────────────────────────┤
│                                                      │
│  ┌──────────────────┐      ┌──────────────────┐   │
│  │ ModelRoyaltyNFT  │◄────►│  CatalystPool    │   │
│  │                  │      │  (Coming Soon)   │   │
│  │ - Mint Models    │      │                  │   │
│  │ - Pay Royalties  │      │ - 12M Pi Pool    │   │
│  │ - Track Usage    │      │ - 8x Multiplier  │   │
│  └──────────────────┘      └──────────────────┘   │
│           │                         │               │
│           └────────┬────────────────┘               │
│                    │                                │
│         ┌──────────▼──────────┐                    │
│         │   Pi Network L1     │                    │
│         │   (Chain: 314159)   │                    │
│         └─────────────────────┘                    │
│                                                      │
└─────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

Get started with OINIO in minutes:

```bash
# 1. Install Foundry (if not already installed)
curl -L https://foundry.paradigm.xyz | bash
foundryup

# 2. Clone the repository
git clone https://github.com/onenoly1010/pi-mr-nft-contracts.git
cd pi-mr-nft-contracts

# 3. Install dependencies
forge install

# 4. Build contracts
forge build

# 5. Run tests
forge test
```

For detailed setup instructions, see [Installation Guide](docs/INSTALLATION.md).

For a fast-track deployment, see [Quick Start Guide](docs/QUICKSTART.md).

## 📦 Installation

### Prerequisites
- [Foundry](https://book.getfoundry.sh/getting-started/installation) (forge, cast, anvil)
- [Git](https://git-scm.com/downloads)
- Node.js 18+ (optional, for tooling)

### Installation Steps

1. **Install Foundry**
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **Clone Repository**
   ```bash
   git clone https://github.com/onenoly1010/pi-mr-nft-contracts.git
   cd pi-mr-nft-contracts
   ```

3. **Install Dependencies**
   ```bash
   forge install
   ```

4. **Build Contracts**
   ```bash
   forge build
   ```

5. **Run Tests**
   ```bash
   forge test
   ```

For complete installation details, see [docs/INSTALLATION.md](docs/INSTALLATION.md).

## 🌐 Deployment

### Environment Setup

```bash
# Set your deployer address
export DEPLOYER_ADDRESS="0xd41691b61a2f85CBf3915BFE65C8D01772c18460"

# Set your private key (NEVER commit this!)
export PRIVATE_KEY="your_private_key_here"

# Set Pi Network RPC URL
export PI_RPC_URL="https://rpc.mainnet.pi.network"
```

### Deploy to Pi Network

```bash
# Run deployment script
./scripts/deploy.sh

# Extract contract addresses
grep "deployed to:" deployments/deployment.log
```

### Verify Deployment

```bash
# Check ModelRoyaltyNFT details
cast call <MODEL_ROYALTY_NFT_ADDRESS> "name()(string)" --rpc-url $PI_RPC_URL
cast call <MODEL_ROYALTY_NFT_ADDRESS> "symbol()(string)" --rpc-url $PI_RPC_URL
cast call <MODEL_ROYALTY_NFT_ADDRESS> "catalystPool()(address)" --rpc-url $PI_RPC_URL
```

For detailed deployment instructions, see [deployments/README.md](deployments/README.md).

## 💡 Usage Examples

### Minting a Model NFT

```solidity
// Mint a new AI model NFT with 15% royalty rate
uint256 tokenId = nft.mint(
    creatorAddress,
    modelHash,
    1500,  // 15% royalty (in basis points)
    tokenURI
);
```

### Paying Inference Royalties

```solidity
// Pay royalties for AI inference usage
nft.payRoyalty{value: totalAmount}(
    tokenId,
    nodeAddress,
    userFee,
    catalystMultiplier
);
```

### Querying Royalty Information

```solidity
// Get royalty info for NFT sales (ERC2981 standard)
// Note: inference royalties use the full rate with a 10000 bps divisor,
// while ERC2981 NFT sale royalties use a 20000 bps divisor (half rate).
// For example, a token with 1500 bps (15% inference royalty) yields 750 bps (7.5%)
// as the royalty for NFT sales via royaltyInfo.
(address receiver, uint256 royaltyAmount) = nft.royaltyInfo(tokenId, salePrice);
```

## 📚 Repository Links

- **Smart Contracts**: [github.com/onenoly1010/pi-mr-nft-contracts](https://github.com/onenoly1010/pi-mr-nft-contracts)
- **AI Agents**: [github.com/onenoly1010/pi-mr-nft-agent](https://github.com/onenoly1010/pi-mr-nft-agent)
- **Documentation**: [github.com/onenoly1010/pi-forge-quantum-genesis](https://github.com/onenoly1010/pi-forge-quantum-genesis)

## 🔒 Security

OINIO prioritizes security and decentralization:

- ✅ **Immutable Contracts**: No admin keys or upgrade mechanisms
- ✅ **Audited Code**: OpenZeppelin battle-tested contracts
- ✅ **Reentrancy Protection**: ReentrancyGuard on all payable functions
- ✅ **Range Validation**: Strict bounds on royalty percentages (10-30%)
- ✅ **Transparent Operations**: All transactions on-chain and verifiable

**Security Note**: Always verify contract addresses after deployment and never commit private keys to version control.

## 🛣️ Roadmap

- [x] ModelRoyaltyNFT Contract
- [x] Deployment Scripts
- [x] Pi Network Integration
- [ ] CatalystPool Contract (12M Pi)
- [ ] Benchmark System
- [ ] Governance Module
- [ ] Frontend Dashboard
- [ ] Agent Integration

## 🤝 Contributing

OINIO is committed to community-driven development. Contributions are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code follows the existing style and includes appropriate tests.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

- **Website**: [quantumpiforge.com](https://quantumpiforge.com)
- **Twitter**: [@Onenoly11](https://twitter.com/Onenoly11)
- **GitHub**: [@onenoly1010](https://github.com/onenoly1010)

## 🙏 Acknowledgments

Built on:
- [OpenZeppelin Contracts](https://openzeppelin.com/contracts/)
- [Foundry](https://book.getfoundry.sh/)
- [Pi Network](https://minepi.com/)

---

**OINIO** - Where AI Models Earn Forever 🎭✨
