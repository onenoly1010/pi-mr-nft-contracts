// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract ModelRoyaltyNFT is ERC721URIStorage, Ownable, ReentrancyGuard {
    uint256 public nextTokenId;
    address public catalystPool;
    struct Model { address creator; bytes32 modelHash; uint16 royaltyBps; uint32 benchmarkScore; uint64 mintedAt; }
    mapping(uint256 => Model) public models;
    event ModelMinted(uint256 indexed tokenId, address indexed creator, bytes32 modelHash, uint16 royaltyBps);
    event InferenceRoyaltyPaid(uint256 indexed tokenId, address indexed user, address indexed node, uint256 userFee, uint256 royaltyAmount, uint256 catalystBonus);
    constructor(address _catalystPool) ERC721("Pi Model Royalty NFT", "MR-NFT") Ownable(msg.sender) { catalystPool = _catalystPool; }
    function mint(address to, bytes32 modelHash, uint16 royaltyBps, string memory tokenURI) external onlyOwner returns (uint256) {
        require(royaltyBps >= 1000 && royaltyBps <= 3000, "Royalty out of range");
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        models[tokenId] = Model({creator: to, modelHash: modelHash, royaltyBps: royaltyBps, benchmarkScore: 0, mintedAt: uint64(block.timestamp)});
        emit ModelMinted(tokenId, to, modelHash, royaltyBps);
        return tokenId;
    }
    function royaltyInfo(uint256 tokenId, uint256 salePrice) external view returns (address receiver, uint256 royaltyAmount) {
        return (models[tokenId].creator, (salePrice * models[tokenId].royaltyBps) / 20000);
    }
    function payRoyalty(uint256 tokenId, address node, uint256 userFee, uint256 catalystMultiplier) external payable nonReentrant {
        Model memory m = models[tokenId];
        require(m.creator != address(0), "Invalid token");
        uint256 royalty = (userFee * m.royaltyBps) / 10000;
        uint256 bonus = (royalty * catalystMultiplier) / 100;
        payable(m.creator).transfer(royalty);
        payable(catalystPool).transfer(bonus);
        emit InferenceRoyaltyPaid(tokenId, msg.sender, node, userFee, royalty, bonus);
    }
}