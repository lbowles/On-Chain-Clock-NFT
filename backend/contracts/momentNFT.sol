
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "base64-sol/base64.sol";

contract momentNFT is ERC721URIStorage {
  using SafeMath for uint256;

  uint public tokenCounter; 
  event CreatedMomentNFT(uint256 indexed tokenId, string tokenURI);

  constructor() ERC721 ("Moment NFT", "momentNFT") {
    tokenCounter = 0 ;
  }

  function create(string memory _svg) public {
    _safeMint(msg.sender, tokenCounter);
    string memory imageURI = svgToImageURI(_svg);
    string memory tokenURI = formatTokenURI(imageURI); 
    _setTokenURI(tokenCounter, tokenURI);
    emit CreatedMomentNFT(tokenCounter, tokenURI);
    tokenCounter = tokenCounter.add(1) ; 
  }

  function svgToImageURI(string memory _svg) public pure returns (string memory){
    string memory baseURI = "data:image/svg+xml;base64,";
    string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg))))  ; 
    string memory imageURI = string(abi.encodePacked(baseURI,svgBase64Encoded));
    return imageURI;
  }

  function formatTokenURI(string memory _imageURI)public pure returns(string memory){

    string memory baseURL = "data:application/json;base64";
    return string(abi.encodePacked(
      baseURL,
      Base64.encode(
        bytes(abi.encodePacked(
          '{"name":"Moment NFT"',
          '"description": "Fully on-chain clock NFT that shows you the current time"',
          '"time-zone":""',
          '"image":"',_imageURI,'"}')
        )
      )
    ));
  }
  
}