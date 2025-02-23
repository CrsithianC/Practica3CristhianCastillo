const HARDHAT_URL = "http://127.0.0.1:8545";
const DAO_ADDRESS_LOCALHOST = "0x5fbdb2315678afecb367f032d93f642f64180aa3"
const DAO_ADDRESS_TESTNET = ""
const SIGNER_PRIVATEKEY = "0xdf57089febbacf7ba0bc227dafbffa9fc08a93fdc68e1e42411a14efcf23656e"

const initializeContract = async () => {
    const response = await fetch('../../artifacts/contracts/DAO.sol/KeepCodingDAO.json')
    const data = await response.json()

    const provider = new ethers.providers.JsonRpcProvider(HARDHAT_URL);
    
    const readContract = new ethers.Contract(DAO_ADDRESS_LOCALHOST, data.abi, provider);
    
    const wallet = new ethers.Wallet(SIGNER_PRIVATEKEY, provider);
    
    const writeContract = new ethers.Contract(DAO_ADDRESS_LOCALHOST, data.abi, wallet);
    
    return { provider, wallet, writeContract, readContract };
    
}

const createProposal = async (title, desc, options) => {
    const { writeContract } = await initializeContract();
    const tx = await writeContract.createProposal(title, desc, options);
    await tx.wait();
    console.log("Has creado la propuesta correctamente");
}

const getProposalInfo = async (proposalId) => {
    const { readContract } = await initializeContract();
    const proposalInfo = await readContract.getProposalInfo(proposalId);
    return proposalInfo;
}

const voteProposal = async (proposalId, vote) => {
    const { writeContract } = await initializeContract();
    const tx = await writeContract.voteProposal(proposalId, vote);
    await tx.wait();
    console.log("Has votado correctamente");
}

const executeProposal = async (proposalId) => {
    const { writeContract } = await initializeContract();
    const tx = await writeContract.executeProposal(proposalId);
    await tx.wait();
    console.log("La propuesta ha sido ejecutada");
}


//Conexion con la interfaz
const createTitleInput = document.getElementById("createTitleInput")
const createDescInput = document.getElementById("createDescInput")
const createOptionsInput = document.getElementById("createOptionsInput")
const getInput = document.getElementById("getInput")
const voteIdInput = document.getElementById("voteIdInput")
const voteOptionInput = document.getElementById("voteOptionInput")
const executeInput = document.getElementById("executeInput")

const createButton = document.getElementById("createButton")
const getButton = document.getElementById("getButton")
const voteButton = document.getElementById("voteButton")
const executeButton = document.getElementById("executeButton")

createButton.addEventListener("click", async () => {
    await createProposal(
        createTitleInput.value,
        createDescInput.value,
        createOptionsInput.value.split(",")
    )
})

getButton.addEventListener("click", async () => {
    const response = await getProposalInfo(
        getInput.value
    )
    console.log(response)
})

voteButton.addEventListener("click", async () => {
    await voteProposal(
        voteIdInput.value,
        voteOptionInput.value
    )
})

executeButton.addEventListener("click", async () => {
    await executeProposal(
        executeInput.value
    )
})
