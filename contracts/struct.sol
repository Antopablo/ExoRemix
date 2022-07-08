// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract structureExo {
    struct Eleve {
        string nom;
        string prenom;
        uint[] notes;
    }

    mapping(address => Eleve) Eleves;

    function addNote(address _eleveAddress, uint _note) public {
        Eleves[_eleveAddress].notes.push(_note);
    }

    function getNotesPerEleve(address _eleveAddress) public view returns(uint[] memory){
        return Eleves[_eleveAddress].notes;
    }

    function setNom(address _eleveAddress, string memory _nom) public {
        Eleves[_eleveAddress].nom = _nom;
    }

    function getNom(address _eleveAddress) public view returns(string memory) {
        return Eleves[_eleveAddress].nom;
    }
}