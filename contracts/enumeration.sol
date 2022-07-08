// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract exoEnum {

    enum etape {
        commande,
        expedie,
        livre
    }

    struct produit {
        uint _SKU;
        exoEnum.etape _etape;
    }

    mapping(address => produit) CommandesClient;

    function commander(address _client, uint _sku) public {
        produit memory p = produit(_sku, etape.commande);
        CommandesClient[_client] = p;
    }

    function expedier(address _client) public {
        CommandesClient[_client]._etape = etape.expedie;
    }

    function getSKU(address _client) public view returns(uint) {
        return CommandesClient[_client]._SKU;        
    }

    function getEtape(address _client) public view returns(etape) {
        return CommandesClient[_client]._etape;
    }
}