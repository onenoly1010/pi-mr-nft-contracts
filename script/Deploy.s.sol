// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../contracts/ModelRoyaltyNFT.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy CatalystPool (simple address for now - can be a contract later)
        // For initial deployment, we'll use the deployer address as the catalyst pool
        address catalystPool = vm.addr(deployerPrivateKey);
        
        console.log("Deploying contracts...");
        console.log("Deployer address:", vm.addr(deployerPrivateKey));
        console.log("CatalystPool address:", catalystPool);
        
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
