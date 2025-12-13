# OINIO Quick Start Guide

Get OINIO deployed on Pi Network in under 5 minutes! This fast-track guide assumes you have basic command-line experience.

## ⚡ Prerequisites Check

Before starting, ensure you have:
- ✅ Foundry installed (`forge --version`)
- ✅ Pi wallet with ~1 Pi for gas
- ✅ Your private key ready
- ✅ Internet connection

**Don't have Foundry?** Install it in 30 seconds:
```bash
curl -L https://foundry.paradigm.xyz | bash && foundryup
```

## 🚀 5-Minute Setup

### Step 1: Clone and Install (1 minute)

```bash
# Clone repository
git clone https://github.com/onenoly1010/pi-mr-nft-contracts.git
cd pi-mr-nft-contracts

# Install dependencies
forge install
```

### Step 2: Set Environment Variables (1 minute)

```bash
# Set your deployer address (OINIO official deployer)
export DEPLOYER_ADDRESS="0xd41691b61a2f85CBf3915BFE65C8D01772c18460"

# Set your private key (replace with your actual key, NO 0x prefix)
export PRIVATE_KEY="your_private_key_here"

# Set Pi Network RPC URL
export PI_RPC_URL="https://rpc.mainnet.pi.network"
```

**⚠️ Security Note:** Never commit your private key! The `.env` file is already gitignored.

### Step 3: Build and Test (1 minute)

```bash
# Build contracts
forge build

# Run tests (optional but recommended)
forge test
```

### Step 4: Deploy to Pi Network (2 minutes)

```bash
# Make deploy script executable
chmod +x scripts/deploy.sh

# Deploy!
./scripts/deploy.sh
```

**Wait for confirmation...** ☕

### Step 5: Get Your Contract Address (30 seconds)

```bash
# Extract contract address from deployment log
grep "deployed to:" deployments/deployment.log
```

**Copy this address** - you'll need it for frontend integration!

## 🎯 Deploy in 3 Commands

If you're already set up with Foundry and environment variables:

```bash
# 1. Clone and install
git clone https://github.com/onenoly1010/pi-mr-nft-contracts.git && cd pi-mr-nft-contracts && forge install

# 2. Set environment (replace with your values)
export DEPLOYER_ADDRESS="0xd41691b61a2f85CBf3915BFE65C8D01772c18460" && export PRIVATE_KEY="your_key" && export PI_RPC_URL="https://rpc.mainnet.pi.network"

# 3. Deploy
chmod +x scripts/deploy.sh && ./scripts/deploy.sh
```

## ✅ Verify Deployment

### Quick Verification

```bash
# Set your deployed contract address
export MODEL_NFT="0x..." # Replace with address from deployment log

# Check contract name (should return "Pi Model Royalty NFT")
cast call $MODEL_NFT "name()(string)" --rpc-url $PI_RPC_URL

# Check symbol (should return "MR-NFT")
cast call $MODEL_NFT "symbol()(string)" --rpc-url $PI_RPC_URL

# Check owner (should return your deployer address)
cast call $MODEL_NFT "owner()(address)" --rpc-url $PI_RPC_URL
```

### Expected Output

```
✅ name: "Pi Model Royalty NFT"
✅ symbol: "MR-NFT"
✅ owner: "0xd41691b61a2f85CBf3915BFE65C8D01772c18460"
```

## 🎨 Mint Your First NFT

Ready to mint your first AI model NFT?

```bash
# Mint parameters
CREATOR_ADDRESS="0xYourAddress"
MODEL_HASH="0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"  # Replace with your model's 32-byte unique identifier (e.g., SHA256 hash)
ROYALTY_BPS="1500"  # 15% inference royalty rate (must be between 1000-3000 = 10-30%)
TOKEN_URI="ipfs://QmYourModelMetadata"  # IPFS URI for model metadata

# Mint NFT
cast send $MODEL_NFT \
  "mint(address,bytes32,uint16,string)" \
  $CREATOR_ADDRESS \
  $MODEL_HASH \
  $ROYALTY_BPS \
  $TOKEN_URI \
  --rpc-url $PI_RPC_URL \
  --private-key $PRIVATE_KEY \
  --legacy
```

**Note:** Royalty must be between 1000 (10%) and 3000 (30%)

### Verify Your Mint

```bash
# Check next token ID (should be 1 after first mint)
cast call $MODEL_NFT "nextTokenId()(uint256)" --rpc-url $PI_RPC_URL

# Get model details for token 0 (returns: creator, modelHash, royaltyBps, benchmarkScore, mintedAt)
cast call $MODEL_NFT "models(uint256)" 0 --rpc-url $PI_RPC_URL
```

## 🐛 Quick Troubleshooting

### Problem: "forge: command not found"

```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup
# Restart your terminal
```

### Problem: "insufficient funds for gas"

```bash
# Check your balance
cast balance $DEPLOYER_ADDRESS --rpc-url $PI_RPC_URL

# You need at least ~0.1 Pi for deployment
```

### Problem: "transaction reverted"

```bash
# Add more verbose logging
forge script script/Deploy.s.sol:Deploy \
  --rpc-url $PI_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --legacy \
  -vvvvv
```

### Problem: "nonce too low/high"

```bash
# Check current nonce
cast nonce $DEPLOYER_ADDRESS --rpc-url $PI_RPC_URL

# Wait a few blocks and retry
```

### Problem: "RPC connection failed"

```bash
# Test RPC connection
cast block latest --rpc-url $PI_RPC_URL

# Verify your internet connection
ping rpc.mainnet.pi.network
```

## 📊 Deployment Checklist

Use this checklist to ensure successful deployment:

- [ ] Foundry installed (`forge --version` works)
- [ ] Repository cloned and dependencies installed
- [ ] Environment variables set (DEPLOYER_ADDRESS, PRIVATE_KEY, PI_RPC_URL)
- [ ] Sufficient Pi balance (~1 Pi) for gas
- [ ] Contracts compiled successfully (`forge build`)
- [ ] Tests passing (`forge test`)
- [ ] Deploy script executed (`./scripts/deploy.sh`)
- [ ] Contract address extracted from logs
- [ ] Deployment verified with `cast call` commands
- [ ] Contract address saved for frontend integration

## 🎯 Next Steps

### Immediate Actions

1. **Save Your Contract Address**
   ```bash
   echo "ModelRoyaltyNFT: $MODEL_NFT" > my-deployment.txt
   ```

2. **Verify on Block Explorer**
   ```
   https://piscan.io/address/$MODEL_NFT
   ```

3. **Test Minting** (see "Mint Your First NFT" section above)

### Integration

Update your frontend configuration:

```javascript
// config.js
export const CONTRACTS = {
  modelRoyaltyNFT: "0x...", // Your deployed address
  catalystPool: "0xd41691b61a2f85CBf3915BFE65C8D01772c18460", // Initially deployer address (update when CatalystPool contract deployed)
  chainId: 314159,
  rpcUrl: "https://rpc.mainnet.pi.network"
};
```

### Advanced Setup

For production deployments and advanced features:

1. **Complete Installation Guide**: See [INSTALLATION.md](INSTALLATION.md)
2. **Main Documentation**: See [README.md](../README.md)
3. **Deployment Details**: See [deployments/README.md](../deployments/README.md)

## 🔗 Quick Links

- **Website**: [quantumpiforge.com](https://quantumpiforge.com)
- **Contracts Repository**: [github.com/onenoly1010/pi-mr-nft-contracts](https://github.com/onenoly1010/pi-mr-nft-contracts)
- **AI Agents**: [github.com/onenoly1010/pi-mr-nft-agent](https://github.com/onenoly1010/pi-mr-nft-agent)
- **Documentation**: [github.com/onenoly1010/pi-forge-quantum-genesis](https://github.com/onenoly1010/pi-forge-quantum-genesis)
- **Twitter**: [@Onenoly11](https://twitter.com/Onenoly11)

## 💡 Pro Tips

### Speed Up Builds

```bash
# Use cached builds
forge build --use-cache

# Skip tests when you're confident
forge build --skip-test
```

### Monitor Gas Usage

```bash
# Get gas report during tests
forge test --gas-report

# Check transaction gas usage
cast tx <TX_HASH> --rpc-url $PI_RPC_URL
```

### Environment File (Optional)

Create a `.env` file for persistent configuration:

```bash
# .env file (never commit this!)
PI_RPC_URL=https://rpc.mainnet.pi.network
DEPLOYER_ADDRESS=0xd41691b61a2f85CBf3915BFE65C8D01772c18460
PRIVATE_KEY=your_private_key_here
```

Load it with:
```bash
source .env  # or: export $(cat .env | xargs)
```

## 🆘 Need Help?

**Stuck?** Try these resources:

1. **Detailed Guide**: [INSTALLATION.md](INSTALLATION.md)
2. **GitHub Issues**: [Report a problem](https://github.com/onenoly1010/pi-mr-nft-contracts/issues)
3. **Community**: [@Onenoly11 on Twitter](https://twitter.com/Onenoly11)

## 📝 Command Reference

### Essential Commands

```bash
# Build
forge build

# Test
forge test
forge test -vv          # verbose
forge test -vvv         # very verbose

# Deploy
./scripts/deploy.sh

# Cast (interact with contracts)
cast call <ADDRESS> "function()(returnType)" --rpc-url $PI_RPC_URL
cast send <ADDRESS> "function(args)" <VALUES> --rpc-url $PI_RPC_URL --private-key $PRIVATE_KEY

# Utilities
cast balance <ADDRESS> --rpc-url $PI_RPC_URL
cast nonce <ADDRESS> --rpc-url $PI_RPC_URL
cast block latest --rpc-url $PI_RPC_URL
cast tx <TX_HASH> --rpc-url $PI_RPC_URL
```

---

## 🎉 Success!

**Congratulations!** You've deployed OINIO to Pi Network. You're now part of the first sovereign AI economy!

**Share your success:**
- Tweet your contract address with [@Onenoly11](https://twitter.com/Onenoly11)
- Add your deployment to the community showcase
- Start building on top of OINIO

**Welcome to the future of AI model ownership!** 🎭✨

---

**Questions or feedback?** Visit [quantumpiforge.com](https://quantumpiforge.com) or reach out on Twitter [@Onenoly11](https://twitter.com/Onenoly11)
