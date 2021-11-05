pragma solidity ^0.8.3;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract PDP is ERC721URIStorage {
    uint16 public counter=0;
    address payable public owner;
    string public baseURI = "";
    uint256 basePrice=0.001 ether;
    function _baseURI() internal pure override returns (string memory) {
        return "https://metapunks.s3.eu-west-2.amazonaws.com/";
    }
       constructor()ERC721("Paddle Punks", "PDP") {
        owner=payable(msg.sender);
    }
    
    modifier onlyOwner() {
        require(
            msg.sender == owner
        );
        _;
    }
    
    function withdraw()public payable{
        owner.transfer(address(this).balance);
    }
    
    function changeBasePrice(uint256 amount)public onlyOwner{
        basePrice=amount;
    }

    function mintOwner(uint8 howmany) public onlyOwner{
        for (uint8 i=0;i<howmany;i++){
            counter+=1;
            _mint(msg.sender, counter);
            _setTokenURI(counter, concat());
        }
    }

    function mint(uint8 howmany) public payable returns (uint) {
        require(counter<10000);
        require(msg.value>=basePrice*howmany);
        require(howmany<6);
        for (uint8 i=0;i<howmany;i++){
            counter+=1;
            _mint(msg.sender, counter);
            _setTokenURI(counter, concat());
        }
        return counter;
        
    }
      function uint2str(uint256 _i)internal pure returns (string memory str){
          if (_i == 0){return "0";}
          uint256 j = _i;
          uint256 length;
          while (j != 0){
            length++;
            j /= 10;
          }
          bytes memory bstr = new bytes(length);
          uint256 k = length;
          j = _i;
          while (j != 0)
          {
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
          }
          str = string(bstr);
    }
    
    function concat() internal returns(string memory) {
       string memory ceva= string(abi.encodePacked(
               uint2str(counter),".json"
            ));
        return ceva;
    }
    
}