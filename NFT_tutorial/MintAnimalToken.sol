// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MintAnimalToken is ERC721Enumerable {
    constructor() ERC721("PSIAnimalToken", "PAT") {}
    //동물타입 리스트
    mapping(uint256 => uint256) public animalTypes;

        function mintAnimalToken() public {
            //전체 발생 수량
            uint256 animalTokenId = totalSupply() + 1;
            //1~10 임의 수
            uint256 animalType = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, animalTokenId))) % 10 + 1;
            //리스트
            animalTypes[animalTokenId] = animalType;
            //토큰 생성
            _mint(msg.sender, animalTokenId);
        }
}