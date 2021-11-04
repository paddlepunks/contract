pragma solidity ^0.8.3;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PS is ERC721URIStorage {
    uint16 public counter=0;
    address payable[] public team;
    address payable public owner;
    uint256[] public shares;
    string public contractURI = "";
    uint256 basePrice=1000000000000000;
    mapping(uint16=>string) oi;
       constructor(address payable[] memory bosiiLaBani, uint256[] memory procente)ERC721("Project Snooze", "SHP") {
        team=bosiiLaBani;
        owner=payable(msg.sender);
        shares=procente;
       }
       
    function dividends()public payable{
        uint256 total = address(this).balance;
        for (uint256 i = 0; i < team.length; i++) {
            team[i].transfer((total * (shares[i] * 100)) / 10000);
        }
    }
    
    function createToken(string memory tokenURI) public payable returns (uint) {
        require(counter<7778);
        if (counter>7){
            require(msg.value>=basePrice);
        }
        counter+=1;
        _mint(msg.sender, counter);
        _setTokenURI(counter, tokenURI);
        return counter;
    }
}