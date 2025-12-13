// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../contracts/ModelRoyaltyNFT.sol";

contract Deploy is Script {
    function run() external {
        // Load private key securely from environment
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);

        // NOTE: Using deployer address as initial CatalystPool address
        // This is a temporary measure for initial deployment
        // The CatalystPool should be updated to a proper contract address later
        // via the owner functions if/when a dedicated pool contract is deployed
        address catalystPool = deployer;
        
        console.log("Deploying contracts...");
        console.log("Deployer address:", deployer);
        console.log("CatalystPool address (temporary):", catalystPool);
        
        // Deploy ModelRoyaltyNFT
        ModelRoyaltyNFT nft = new ModelRoyaltyNFT(catalystPool);
        
        console.log("ModelRoyaltyNFT deployed to:", address(nft));
        
        vm.stopBroadcast();
        
        console.log("");
        console.log("Deployment Summary:");
        console.log("===================");
        console.log("CatalystPool:", catalystPool);
        console.log("ModelRoyaltyNFT:", address(nft));
    }
}
