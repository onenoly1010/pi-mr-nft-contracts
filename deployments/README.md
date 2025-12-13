# OINIO Deployment

## Prerequisites

Set environment variables:

```bash
export DEPLOYER_ADDRESS="0xd41691b61a2f85CBf3915BFE65C8D01772c18460"
export PRIVATE_KEY="your_private_key_here"
export PI_RPC_URL="https://rpc.mainnet.pi.network"
```

## Deploy Contracts

```bash
./scripts/deploy.sh
```

## Extract Contract Addresses

After deployment completes:

```bash
grep "deployed to:" deployments/deployment.log
```

This will show:
- CatalystPool address
- ModelRoyaltyNFT address

## Verify Deployment

```bash
# Check ModelRoyaltyNFT
cast call <MODEL_ROYALTY_NFT_ADDRESS> "name()(string)" --rpc-url $PI_RPC_URL
cast call <MODEL_ROYALTY_NFT_ADDRESS> "symbol()(string)" --rpc-url $PI_RPC_URL
cast call <MODEL_ROYALTY_NFT_ADDRESS> "catalystPool()(address)" --rpc-url $PI_RPC_URL

# Verify CatalystPool address (currently set to deployer address)
# Note: CatalystPool is initially set to the deployer address
# This can be updated later when a dedicated CatalystPool contract is deployed
```

## Post-Deployment Steps

1. **Save Contract Addresses**: Record the deployed addresses in a safe location
2. **Verify on Explorer**: Check contracts on Pi Network block explorer
3. **Test Basic Functions**: Ensure contracts are working as expected
4. **Update Frontend**: Update frontend configuration with new contract addresses

## Troubleshooting

### Deployment Fails

- Check that you have sufficient Pi balance for gas
- Verify RPC URL is correct and accessible
- Ensure private key is valid and properly formatted

### Transaction Pending

- Pi Network may have longer block times
- Wait patiently and check transaction status
- Use `--legacy` flag if you encounter gas estimation issues

## Security Notes

- **Never commit your private key** to version control
- Use environment variables or a secure key management system
- Always test on testnet before mainnet deployment
- Verify contract addresses after deployment
