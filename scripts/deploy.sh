#!/bin/bash
set -e

echo "=========================================="
echo "🎭 OINIO MAINNET DEPLOYMENT"
echo "=========================================="
echo ""

# Validate environment variables
if [ -z "$DEPLOYER_ADDRESS" ]; then
    echo "❌ Error: DEPLOYER_ADDRESS not set"
    exit 1
fi

if [ -z "$PRIVATE_KEY" ]; then
    echo "❌ Error: PRIVATE_KEY not set"
    exit 1
fi

if [ -z "$PI_RPC_URL" ]; then
    echo "❌ Error: PI_RPC_URL not set"
    exit 1
fi

echo "✅ Deployer: $DEPLOYER_ADDRESS"
echo "✅ RPC URL: $PI_RPC_URL"
echo ""

# Ensure deployments directory exists
mkdir -p deployments

# Deploy contracts
echo "Deploying OINIO contracts to Pi Network..."
forge script script/Deploy.s.sol:Deploy \
  --rpc-url $PI_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --legacy \
  -vvvv | tee deployments/deployment.log

echo ""
echo "=========================================="
echo "✅ DEPLOYMENT COMPLETE!"
echo "=========================================="
echo ""
echo "📋 Check deployments/deployment.log for contract addresses"
echo ""
echo "Extract addresses with:"
echo "  grep 'deployed to:' deployments/deployment.log"
