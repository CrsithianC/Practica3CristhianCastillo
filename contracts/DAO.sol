// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

//Imports
import {Proposal} from  "./Proposal.sol";
import {Counter} from "./Counter.sol";
import "hardhat/console.sol";

/**
 * @title 
 * @author 
 * @notice 
 * @dev 
 */
contract KeepCodingDAO is Proposal, Counter {



    /**
     * -----------------------------------------------------------------------------------------------------
     *                                      ATRIBUTOS
     * -----------------------------------------------------------------------------------------------------
     */

     mapping(uint256 => MultipleChoiceProposal) public proposals;

    /**
     * -----------------------------------------------------------------------------------------------------
     *                                      CONSTRUCTOR
     * -----------------------------------------------------------------------------------------------------
     */

     constructor() Counter(0){

     }

    /**
     * -----------------------------------------------------------------------------------------------------
     *                                      ERRORS
     * -----------------------------------------------------------------------------------------------------
     */

     error ProposalDoesNotExist(uint256 _proposalIdConsultado);
     error ProposalDeadlineExceeded(uint256 _proposalId);
     error ProposalCannotBeExecuted(uint256 _proposalId);


    /**
     * -----------------------------------------------------------------------------------------------------
     *                                      MODIFIERS
     * -----------------------------------------------------------------------------------------------------
     */

    /**
        Comprueba si la propuesta existe.
        Si no existe lanza el error ProposalDoesNotExist.
     */
     modifier doesProposalExist(uint256 _proposalId) {
        if (proposals[_proposalId].creator == address(0)) {
            revert ProposalDoesNotExist(_proposalId);
        }
        _;
    }

    /**
        Comprueba si la propuesta esta activa.
        Si no esta activa lanza el error ProposalDeadlineExceeded.
     */
     modifier isProposalActive(uint256 _proposalId) {
        if (block.timestamp > proposals[_proposalId].deadline) {
            revert ProposalDeadlineExceeded(_proposalId);
        }
        _;
    }

    /**
        Comprueba si la propuesta ha superado su deadline y puede ser ejecutada.
        Si no lo ha superado lanza el error ProposalCannotBeExecuted.
     */
    modifier canProposalBeExecuted(uint256 _proposalId) {
        if (block.timestamp <= proposals[_proposalId].deadline) {
            revert ProposalCannotBeExecuted(_proposalId);
        }
        _;
    }

    /**
     * -----------------------------------------------------------------------------------------------------
     *                                      EVENTS
     * -----------------------------------------------------------------------------------------------------
     */

     event ProposalCreated(uint256 _proposalId, address indexed _creator);
     event ProposalVoted(uint256 indexed _proposalId, address indexed _voter);
     event ProposalExecuted(uint256 _proposalId);
     

    /**
     * -----------------------------------------------------------------------------------------------------
     *                                      FUNCIONES
     * -----------------------------------------------------------------------------------------------------
     */

    /**
        Crea una propuesta e inicializa sus datos
     */
    function createProposal(string memory _title, string memory _description, string[] memory _options) public{
        uint256 proposalId = current();

        MultipleChoiceProposal storage proposal = proposals[proposalId];
        proposal.id = proposalId;
        proposal.title = _title;
        proposal.description = _description;
        proposal.creator = msg.sender;
        proposal.deadline = block.timestamp + 30 minutes;
        proposal.executed = false;
        proposal.optionsNumber = uint8(_options.length);

        for (uint8 i = 0; i < _options.length; i++) {
            proposal.optionsText[i] = _options[i];
            proposal.optionsVotes[i] = 0;
        }
        
        increment();
        emit ProposalCreated(proposalId, msg.sender);
        
    }

    
    /**
        Obtiene informacion de la propuesta relativa a las opciones y sus votos.
        Rellena y devuelve un objeto MultipleChoiceProposalInfo.
        La propuesta debe existir.
     */
    function getProposalInfo(uint256 _proposalId) doesProposalExist(_proposalId) public view returns(MultipleChoiceProposalInfo memory){
        //obtener la propuesta cuyo id es el parametro recibido
        MultipleChoiceProposal storage proposal = proposals[_proposalId];

        //inicializar el objeto MultipleChoiceProposalInfo. Pista no es necesario usar storage, mejor usar memory
        MultipleChoiceProposalInfo memory proposalInfo;

        //inicializar el array optionsText dentro del struct
        proposalInfo.optionsText = new string[](proposal.optionsNumber);

        //inicializar el array optionsVotes dentro del struct
        proposalInfo.optionsVotes = new uint256[](proposal.optionsNumber);

        //iterar sobre las opciones. Pista usar el campo optionsNumber como tope del bucle
        for(uint8 i = 0; i < proposals[_proposalId].optionsNumber; i++){
            proposalInfo.optionsText[i] = proposal.optionsText[i];
            proposalInfo.optionsVotes[i] = proposal.optionsVotes[i];
        }
        //devolver el objeto MultipleChoiceProposalInfo
        return proposalInfo;
    }



    /**
        Funcion que permite emitir un voto sobre una propuesta.
        Recibe el id de la propuesta y el codigo de la opcion.
        La propuesta debe existir y estar activa.
     */
    function voteProposal(uint256 _proposalId, uint8 _optionCode) public doesProposalExist(_proposalId) isProposalActive(_proposalId) {
        proposals[_proposalId].optionsVotes[_optionCode]++;
        proposals[_proposalId].voters[msg.sender] = true;
        emit ProposalVoted(_proposalId, msg.sender);
    }

    /**
        Comrpueba si una address concreta ha votado en una propuesta concreta.
        Recibe el id de la propuesta y el address que va a ser comprobado.
        La propuesta debe existir.
     */
    function hasAddressVoted(uint256 _proposalId, address _address) public view doesProposalExist(_proposalId) returns (bool) {
        return proposals[_proposalId].voters[_address];
    }

    /**
        Funcion que ejecuta una propuesta.
        Para que una funcion pueda ser ejecutada tiene que haberse superado el deadline.
        La propuesta debe existir y la deadline haberse superado.
     */
    function executeProposal(uint256 _proposalId) public doesProposalExist(_proposalId) canProposalBeExecuted(_proposalId){
        proposals[_proposalId].executed = true;
        emit ProposalExecuted(_proposalId);     
    }       

}