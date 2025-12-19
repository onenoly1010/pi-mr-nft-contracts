# OINIO Installation Guide

Complete guide to installing, building, testing, and deploying OINIO smart contracts on Pi Network.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Steps](#installation-steps)
- [Environment Setup](#environment-setup)
- [Building Contracts](#building-contracts)
- [Running Tests](#running-tests)
- [Deployment](#deployment)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Next Steps](#next-steps)

## Prerequisites

Before you begin, ensure you have the following installed on your system:

### Required Tools

#### 1. Foundry

Foundry is a blazing fast toolkit for Ethereum application development.

**Install on macOS/Linux:**
```bash
# This command works on both macOS and Linux systems
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

**Install on Windows:**
```powershell
# Using WSL (recommended)
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

**Verify Installation:**
```bash
forge --version
cast --version
anvil --version
```

You should see version numbers for each tool (e.g., `forge 0.2.0`).

#### 2. Git

**macOS:**
```bash
# Using Homebrew
brew install git
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install git
```

**Windows:**
Download from [git-scm.com](https://git-scm.com/downloads)

**Verify Installation:**
```bash
git --version
```

#### 3. Node.js (Optional)

While not strictly required, Node.js is useful for additional tooling.

**Install Node.js 18+:**
```bash
# Using nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18
```

**Verify Installation:**
```bash
node --version
npm --version
```

### Pi Network Requirements

To deploy to Pi Network, you need:

1. **Pi Wallet Address**: Your deployer address (e.g., `0xd41691b61a2f85CBf3915BFE65C8D01772c18460`)
2. **Private Key**: The private key for your deployer address
3. **Pi Balance**: Sufficient Pi tokens for gas fees (~0.1-1 Pi for deployment)
4. **RPC Access**: Pi Network mainnet RPC URL: `https://rpc.mainnet.pi.network`

## Installation Steps

### Step 1: Clone the Repository

```bash
# Clone via HTTPS
git clone https://github.com/onenoly1010/pi-mr-nft-contracts.git

# Or clone via SSH (if you have SSH keys set up)
git clone git@github.com:onenoly1010/pi-mr-nft-contracts.git

# Navigate to the project directory
cd pi-mr-nft-contracts
```

### Step 2: Install Dependencies

Foundry automatically manages Solidity dependencies via git submodules.

```bash
# Install OpenZeppelin and other dependencies
forge install
```

This will install:
- OpenZeppelin Contracts (for ERC721, Ownable, ReentrancyGuard)
- Forge Standard Library (for testing and scripting)

**Expected Output:**
```
Installing openzeppelin-contracts...
Installing forge-std...
Dependencies installed successfully
```

### Step 3: Verify Installation

Check that all dependencies were installed correctly:

```bash
# List installed libraries
ls -la lib/

# Should show:
# - forge-std/
# - openzeppelin-contracts/
```

## Environment Setup

### Step 1: Create Environment File

Create a `.env` file for your environment variables (this file is already gitignored):

```bash
# Create .env file
touch .env
```

### Step 2: Configure Environment Variables

Edit `.env` with your preferred text editor:

```bash
# Pi Network Configuration
PI_RPC_URL=https://rpc.mainnet.pi.network
DEPLOYER_ADDRESS=0xd41691b61a2f85CBf3915BFE65C8D01772c18460
PRIVATE_KEY=your_private_key_here_without_0x_prefix

# Optional: Chain ID
CHAIN_ID=314159
```

**⚠️ Security Warning:**
- **NEVER** commit your `.env` file or private key to version control
- The `.env` file is already in `.gitignore`
- Consider using a hardware wallet or secure key management system for production

### Step 3: Load Environment Variables

Before deploying, load your environment variables:

```bash
# Load variables into current shell
export $(cat .env | xargs)

# Verify they're loaded
echo $DEPLOYER_ADDRESS
```

## Building Contracts

### Step 1: Compile Smart Contracts

```bash
# Build all contracts
forge build
```

**Expected Output:**
```
[⠊] Compiling...
[⠒] Compiling 1 files with 0.8.24
[⠑] Solc 0.8.24 finished in 2.5s
Compiler run successful!
```

### Step 2: Check Build Artifacts

```bash
# List compiled contracts
ls -la out/

# You should see:
# - ModelRoyaltyNFT.sol/
#   - ModelRoyaltyNFT.json (ABI and bytecode)
```

### Step 3: View Contract Size

```bash
# Check contract sizes
forge build --sizes

# Verify ModelRoyaltyNFT is within the 24KB limit
```

## Running Tests

### Run All Tests

```bash
# Run all tests with verbose output
forge test -vv
```

### Run Specific Tests

```bash
# Run tests matching a pattern
forge test --match-contract ModelRoyaltyNFTTest -vvv

# Run a specific test function
forge test --match-test testMint -vvvv
```

### Test with Gas Reports

```bash
# Generate gas usage report
forge test --gas-report
```

### Expected Test Output

```
Running 5 tests for test/ModelRoyaltyNFT.t.sol:ModelRoyaltyNFTTest
[PASS] testMint() (gas: 125432)
[PASS] testRoyaltyInfo() (gas: 89234)
[PASS] testPayRoyalty() (gas: 156789)
[PASS] testRoyaltyRange() (gas: 67234)
[PASS] testOwnership() (gas: 45123)
Test result: ok. 5 passed; 0 failed; finished in 1.23s
```

## Deployment

### Step 1: Pre-Deployment Checklist

Before deploying to Pi Network mainnet, verify:

- [ ] Contracts compile without errors (`forge build`)
- [ ] All tests pass (`forge test`)
- [ ] Environment variables are set correctly
- [ ] You have sufficient Pi balance for gas fees
- [ ] You have backed up your private key securely
- [ ] You have reviewed the deployment script

### Step 2: Deploy to Pi Network

```bash
# Make deploy script executable
chmod +x scripts/deploy.sh

# Run deployment
./scripts/deploy.sh
```

**Deployment Process:**
1. Validates environment variables
2. Deploys ModelRoyaltyNFT contract
3. Sets CatalystPool address (initially deployer address)
4. Logs all transaction details
5. Saves output to `deployments/deployment.log`

### Step 3: Monitor Deployment

The deployment script provides verbose output:

```
==========================================
🎭 OINIO MAINNET DEPLOYMENT
==========================================

✅ Deployer: 0xd41691b61a2f85CBf3915BFE65C8D01772c18460
✅ RPC URL: https://rpc.mainnet.pi.network

Deploying contracts...
Deployer address: 0xd41691b61a2f85CBf3915BFE65C8D01772c18460
CatalystPool address (temporary): 0xd41691b61a2f85CBf3915BFE65C8D01772c18460
ModelRoyaltyNFT deployed to: 0x...

==========================================
✅ DEPLOYMENT COMPLETE!
==========================================
```

### Step 4: Extract Contract Addresses

```bash
# Get deployed contract address
grep "deployed to:" deployments/deployment.log

# Example output:
# ModelRoyaltyNFT deployed to: 0x1234567890abcdef1234567890abcdef12345678
```

### Step 5: Save Deployment Information

```bash
# Create a deployment record
cat > deployments/mainnet-deployment.txt << EOF
Deployment Date: $(date)
Network: Pi Network (314159)
Deployer: $DEPLOYER_ADDRESS
ModelRoyaltyNFT: \$MODEL_ROYALTY_NFT_ADDRESS_FROM_LOG
CatalystPool: $DEPLOYER_ADDRESS (temporary)
Transaction Hash: \$TX_HASH_FROM_LOG
EOF
```

## Verification

### Step 1: Verify Contract Deployment

```bash
# Set contract address from deployment
export MODEL_ROYALTY_NFT=0x... # Replace with actual address

# Check contract name
cast call $MODEL_ROYALTY_NFT "name()(string)" --rpc-url $PI_RPC_URL

# Expected: "Pi Model Royalty NFT"
```

### Step 2: Verify Contract Symbol

```bash
# Check contract symbol
cast call $MODEL_ROYALTY_NFT "symbol()(string)" --rpc-url $PI_RPC_URL

# Expected: "MR-NFT"
```

### Step 3: Verify Contract Owner

```bash
# Check owner address
cast call $MODEL_ROYALTY_NFT "owner()(address)" --rpc-url $PI_RPC_URL

# Expected: Your deployer address
```

### Step 4: Verify CatalystPool

```bash
# Check CatalystPool address
cast call $MODEL_ROYALTY_NFT "catalystPool()(address)" --rpc-url $PI_RPC_URL

# Expected: Your deployer address (temporary)
```

### Step 5: Verify on Block Explorer

Visit the Pi Network block explorer to view your contract:
```
https://piscan.io/address/<YOUR_CONTRACT_ADDRESS>
```

## Troubleshooting

### Common Issues and Solutions

#### Issue: "forge: command not found"

**Solution:**
```bash
# Reinstall Foundry
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc  # or ~/.zshrc
foundryup
```

#### Issue: "Compilation failed"

**Solution:**
```bash
# Clear cache and rebuild
forge clean
forge build --force
```

#### Issue: "Insufficient funds for gas"

**Solution:**
- Ensure you have at least 1 Pi in your deployer wallet
- Check balance: `cast balance $DEPLOYER_ADDRESS --rpc-url $PI_RPC_URL`
- Acquire more Pi tokens from exchanges or bridges

#### Issue: "Transaction reverted"

**Solution:**
```bash
# Check deployment with more verbose output
forge script script/Deploy.s.sol:Deploy \
  --rpc-url $PI_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --legacy \
  -vvvvv
```

#### Issue: "RPC connection failed"

**Solution:**
```bash
# Test RPC connectivity
cast block latest --rpc-url $PI_RPC_URL

# Try alternative RPC endpoints if available
export PI_RPC_URL="https://rpc-testnet.minepi.com"  # For testnet
```

#### Issue: "Nonce too low/too high"

**Solution:**
```bash
# Check current nonce
cast nonce $DEPLOYER_ADDRESS --rpc-url $PI_RPC_URL

# Wait for pending transactions to confirm
# Then retry deployment
```

#### Issue: "Private key invalid"

**Solution:**
- Ensure private key is in hex format without "0x" prefix
- Verify the private key corresponds to your deployer address
- Never share or commit your private key

### Getting Help

If you encounter issues not covered here:

1. **Check Logs**: Review `deployments/deployment.log` for detailed error messages
2. **GitHub Issues**: [github.com/onenoly1010/pi-mr-nft-contracts/issues](https://github.com/onenoly1010/pi-mr-nft-contracts/issues)
3. **Documentation**: [github.com/onenoly1010/pi-forge-quantum-genesis](https://github.com/onenoly1010/pi-forge-quantum-genesis)
4. **Community**: Join discussions on Twitter [@Onenoly11](https://twitter.com/Onenoly11)

## Next Steps

After successful installation and deployment:

### 1. Test Your Contracts

```bash
# Test minting functionality
cast send $MODEL_ROYALTY_NFT \
  "mint(address,bytes32,uint16,string)" \
  $DEPLOYER_ADDRESS \
  0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef \
  1500 \
  "ipfs://QmTest..." \
  --rpc-url $PI_RPC_URL \
  --private-key $PRIVATE_KEY \
  --legacy
```

### 2. Integrate with Frontend

Update your frontend configuration with deployed contract addresses:
```javascript
const config = {
  modelRoyaltyNFT: "0x...",
  catalystPool: "0x...",
  chainId: 314159,
  rpcUrl: "https://rpc.mainnet.pi.network"
};
```

### 3. Set Up Monitoring

Monitor your contracts for:
- Mint events
- Royalty payments
- Transfer activities
- Gas usage

### 4. Deploy CatalystPool (Coming Soon)

Once the CatalystPool contract is ready:
1. Deploy CatalystPool with 12M Pi
2. Update ModelRoyaltyNFT's catalystPool address
3. Configure 8x multiplier and 90-day taper

### 5. Explore Documentation

- **Quick Start**: [QUICKSTART.md](QUICKSTART.md) for rapid deployment
- **Main README**: [README.md](../README.md) for project overview
- **API Reference**: Coming soon

### 6. Join the Community

- Website: [quantumpiforge.com](https://quantumpiforge.com)
- Twitter: [@Onenoly11](https://twitter.com/Onenoly11)
- GitHub: [github.com/onenoly1010](https://github.com/onenoly1010)

---

## Additional Resources

- [Foundry Book](https://book.getfoundry.sh/) - Complete Foundry documentation
- [Pi Network Documentation](https://minepi.com/developer) - Pi Network developer resources
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/) - Security best practices
- [Solidity Documentation](https://docs.soliditylang.org/) - Solidity language reference

---

**Congratulations!** 🎉 You've successfully installed and deployed OINIO. Welcome to the sovereign AI economy!
