// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract SupplyChainNFT is ERC721 {
    uint256 private tokenIdCounter;
    struct NFT_data{
        string name;
        string description;
    }
    mapping(uint256 => NFT_data) public nfts;
    mapping(uint256 => address[]) public ownernft;

    constructor() ERC721("SupplyChainNFT", "SCNFT") {
        tokenIdCounter = 0;
    }
    // creates nft as name suggest
    function createNFT(string memory name, string memory description) external {
        require(bytes(name).length > 0, "Name cannot be null");
        require(bytes(description).length > 0, "Description cannot be null");
        uint256 newTokenId = tokenIdCounter;
        _mint(msg.sender, newTokenId);
        nfts[newTokenId] = NFT_data(name, description);
        ownernft[newTokenId].push(msg.sender);
        tokenIdCounter++;
    }
    // give total number of account that have owned nft
    function totalowner(uint256 tokenid) external view returns (uint256){
        return ownernft[tokenid].length;
    }
    // get name and description of nft as name suggest
    function getNftData(uint256 tokenId) external view returns (NFT_data memory) {
        return nfts[tokenId];
    }
    // returns previous owners or current depends upon index you pass 
    function ownerofnft(uint256 tokenid, uint256 addressid)public view returns(address){
        return ownernft[tokenid][addressid];
    }
    // transfer ownership as name suggest
    function transfernft( address to, uint256 tokenid) public returns(uint8){
        safeTransferFrom(msg.sender, to, tokenid);
        ownernft[tokenid].push(to);
        return 1;
    }

    


}