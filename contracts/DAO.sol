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
     modifier doesProposalExist(uint256 _proposalId){
        if(){
            revert ;
        }
        _;
     }

    /**
        Comprueba si la propuesta esta activa.
        Si no esta activa lanza el error ProposalDeadlineExceeded.
     */
     modifier isProposalActive(uint256 _proposalId){
        if(){
            revert;
        }
        _;
    }

    /**
        Comprueba si la propuesta ha superado su deadline y puede ser ejecutada.
        Si no lo ha superado lanza el error ProposalCannotBeExecuted.
     */
    modifier canProposalBeExecuted(uint256 _proposalId){
        if(){
            revert ;
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
        //obtener el id
        
        //crear el objeto proposal
        
        //rellenar el id
        
        //rellenar el titulo
        
        //rellenar la descriocion
        
        //rellenar el creador
        
        //proposal.voters no hay que hacer nada en creacion
        //rellenar el deadline - 30 minutos
        
        //inicializar el executed
        
        //iterar sobre el array de opciones para rellenar los mappings. Pista usar _options.length
        for(uint8 i = 0; i < _options.length; i++){
            //inicializar las opciones
            
            //inicializar los votos
            
        }
        //inicializar el numero de opciones de la propuesta
        
        //emitir evento ProposalCreated
        
    }

    
    /**
        Obtiene informacion de la propuesta relativa a las opciones y sus votos.
        Rellena y devuelve un objeto MultipleChoiceProposalInfo.
        La propuesta debe existir.
     */
    function getProposalInfo(uint256 _proposalId) doesProposalExist(_proposalId) public view returns(MultipleChoiceProposalInfo memory){
        //obtener la propuesta cuyo id es el parametro recibido
        
        //inicializar el objeto MultipleChoiceProposalInfo. Pista no es necesario usar storage, mejor usar memory
        MultipleChoiceProposalInfo memory proposalInfo;
        //inicializar el array optionsText dentro del struct
        
        //inicializar el array optionsVotes dentro del struct
        

        //iterar sobre las opciones. Pista usar el campo optionsNumber como tope del bucle
        for(uint8 i = 0; i < proposals[_proposalId].optionsNumber; i++){
            //coger el optionsText
        
            //coger el optionsVotes
        
        }
        //devolver el objeto MultipleChoiceProposalInfo
        return proposalInfo;
    }



    /**
        Funcion que permite emitir un voto sobre una propuesta.
        Recibe el id de la propuesta y el codigo de la opcion.
        La propuesta debe existir y estar activa.
     */
    function voteProposal(uint256 _proposalId, uint8 _optionCode) public doesProposalExist(_proposalId) isProposalActive(_proposalId){
        //sumar el voto a su opcion
        
        //incluir el address como que ya voto
        
        //emitir el evento ProposalVoted
        
    } 

    /**
        Comrpueba si una address concreta ha votado en una propuesta concreta.
        Recibe el id de la propuesta y el address que va a ser comprobado.
        La propuesta debe existir.
     */
    function hasAddressVoted(uint256 _proposalId, address _address) public view doesProposalExist(_proposalId) returns (bool){
        
    }

    /**
        Funcion que ejecuta una propuesta.
        Para que una funcion pueda ser ejecutada tiene que haberse superado el deadline.
        La propuesta debe existir y la deadline haberse superado.
     */
    function executeProposal(uint256 _proposalId) public doesProposalExist(_proposalId) canProposalBeExecuted(_proposalId){
        //establecer la propuesta como ejecutada
        
        //emitir el evento ProposalExecuted
        
    }       

}