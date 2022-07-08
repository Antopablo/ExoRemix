// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import "hardhat/console.sol";

contract supermarche {

    struct clientData {
        address _address;
        uint index;
        string nom;
    }

    struct productData {
        uint id;
        string libelle;
        int16 price;
    }

    struct cartData {
        uint numberOfProduct;
    }

    uint numberOfProduct = 0;
    uint numberOfClient = 0;
    cartData[] carts;

    mapping(uint => productData) productsById; 
    mapping(string => productData) productsByName; 

    mapping(address => clientData) clientsByAddress;
    mapping(string => clientData) clientsByName;
    mapping(uint => clientData) clientsByIndex;

    mapping(address => cartData) cartsByClientAddress;



    constructor() {
        createProduit("banane", 10);
        createProduit("fraise", 15);
        createProduit("pomme", 8);

        createClient("Antony");
    }


    function createProduit(string memory _libelle, int16 _prix) public {
        uint id = numberOfProduct + 1;
        numberOfProduct++;
        productData memory p = productData(id, _libelle, _prix);

        //Sauvegarde pour mapping
        productsById[id] = p;
        productsByName[_libelle] = p;
    }

 
    function getProductInfoById(uint _id) public view returns(string memory, int16) {
        return (
            productsById[_id].libelle,
            productsById[_id].price
        );
    }

     function getProductInfoByName(string memory _name) public view returns(string memory, int16) {
        return (
            productsByName[_name].libelle,
            productsByName[_name].price
        );
    }

    function setProductInfoName(uint _id, string memory _libelle) public {
        productsById[_id].libelle = _libelle;
    }

    function setProductInfoPrice(uint _id, int16 _price) public {
        productsById[_id].price = _price;
    }

    function getAllProductInfo() public view returns(productData[] memory) {
        productData[] memory ret = new productData[](numberOfProduct);
        for (uint i = 0; i < numberOfProduct; i++) {
            ret[i] = productsById[i+1];
        }
        return ret;
    }

    function createClient(string memory _name) public {
        uint _index = numberOfClient + 1;
        clientData memory c = clientData(msg.sender, _index, _name);
        numberOfClient++;

        //Sauvegarde pour mapping
        clientsByAddress[msg.sender] = c;
        clientsByName[_name] = c;
        clientsByIndex[_index] = c;
    }

    function getClientByAddress(address _address) public view returns(clientData memory) {
        return clientsByAddress[_address];
    }

    function getClientByName(string memory _name) public view returns(clientData memory) {
        return clientsByName[_name];
    }

    function getClientByIndex(uint _index) public view returns(clientData memory) {
        return clientsByIndex[_index];
    }

    function getAllClients() public view returns(clientData[] memory) {
        clientData[] memory ret = new clientData[](numberOfClient);
        for (uint i = 0; i < numberOfClient; i++) {
            ret[i] = clientsByIndex[i+1];
        }
        return ret;
    }

    function createCart() public {
        cartData memory c;
        cartsByClientAddress[msg.sender] = c;
    }

    function getCart(address _client) public view returns(cartData memory) {
        return cartsByClientAddress[_client];
    }

    function getMyCart() public view returns(cartData memory) {
        return cartsByClientAddress[msg.sender];
    }

    function addInCart() public {
        cartsByClientAddress[msg.sender].numberOfProduct++;
    }

}