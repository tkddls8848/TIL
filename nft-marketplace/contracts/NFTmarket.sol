// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTMarket is ReentrancyGuard {
    using Counters for Counters.Counter;
    //카운터 객체를 통한 아이템 번호 및 팔린 아이템 수량
    Counters.Counter private _itemIds;
    Counters.Counter private _itemSold;
    //마켓소유자 주소
    address payable owner;
    //등록비
    uint256 listingPrice = 0.025 ether;

    constructor() {
        owner = payable(msg.sender);
    }

    //마켓아이템 객체
    struct MarketItem {
        uint itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    //MarketItemCreated 이벤트
    event MarketItemCreated (
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );
    //리스트[_itemId] = 아이템
    mapping(uint256 => MarketItem) private idToMarketItem;

    function getListingPrice() public view returns (uint256){
        return listingPrice;
    }

    //아이템 만들기
    function createMarketItem(
        address nftcontract,
        uint256 tokenId,
        uint256 price
    //nonReentrant modifier 이전 블록 진입 방지
    ) public payable nonReentrant {
        require(price > 0, "price must be at least 1 wei");
        require(msg.value == listingPrice, "fee must be equal to listingPrice");

        _itemIds.increment();
        uint itemId = _itemIds.current();

        //리스트에 아이템 추가
        idToMarketItem[itemId] = MarketItem(
            itemId,
            nftcontract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );

        //nft 권한 sender에서 마켓으로 이관
        IERC721(nftcontract).transferFrom(msg.sender, address(this), tokenId);

        //MarketItemCreated 이벤트 실행
        emit MarketItemCreated (
            itemId,
            nftcontract,
            tokenId,
            msg.sender,
            address(0),
            price,
            false
        );

    }

    //아이템 판매
    function createMarketSale (address nftContract ,uint256 itemId) public payable nonReentrant {
        uint price = idToMarketItem[itemId].price;
        uint tokenId = idToMarketItem[itemId].tokenId;

        require(msg.value == price, "price must be ready");

        idToMarketItem[itemId].seller.transfer(msg.value);
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        idToMarketItem[itemId].owner = payable(msg.sender);
        idToMarketItem[itemId].sold = true;

        _itemSold.increment();
        payable(owner).transfer(listingPrice);
    }

    //팔리지 않은 아이템 가져오기
    function fetchMarketItem() public view returns (MarketItem[] memory) {
        uint itemCount = _itemIds.current();
        uint unSoldItemCount = itemCount - _itemSold.current();
        uint count = 0;
        MarketItem[] memory unSoldList = new MarketItem[](unSoldItemCount);

        for (uint i = 0; i < itemCount ; i++) {
            if (idToMarketItem[i+1].owner == address(0)) {
                MarketItem storage currentItem = idToMarketItem[i+1];
                unSoldList[count+1] = currentItem;
                count += 1;
            }
        }
        return unSoldList;
    }

    //현재 내가 보유한 NFT가져오기
    function fetchMyNFTs() public view returns(MarketItem[] memory) {
        uint myCount = 0;
        uint totalCount = _itemIds.current();
        uint index = 0;
        for (uint i = 0 ; i < totalCount ; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                myCount += 1;
            }
        }
        MarketItem[] memory myNFTList = new MarketItem[](myCount);

        for (uint i = 0 ; i < totalCount ; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                uint currentItemId = idToMarketItem[i + 1].itemId;
                MarketItem storage currentItem = idToMarketItem[currentItemId];
                myNFTList[index] = currentItem;
                index += 1;
            }
        }
        return myNFTList;
    }

    //내가 만들었던 모든 NFT가져오기
    function fetchItemCreated() public view returns(MarketItem[] memory) {
        uint count = 0;
        uint currentCount = 0;
        uint totalCount = _itemIds.current();
        for (uint i = 0 ; i < totalCount ; i++) {
            if(idToMarketItem[i + 1].seller == msg.sender) {
                count += 1;                
            }
        }
        MarketItem[] memory createdNFTList = new MarketItem[](count);

        for (uint i = 0 ; i < totalCount ; i++) {
            if(idToMarketItem[i + 1].seller == msg.sender) {
                // uint currentCount = idToMarketItem[i + 1].itemId;
                // MarketItem storage currentItem = idToMarketItem[currentCount];
                MarketItem storage currentItem = idToMarketItem[i + 1];
                createdNFTList[currentCount] = currentItem;
                currentCount += 1;
            }
        }
        return createdNFTList;
    }
}
