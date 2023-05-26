// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const student = await hre.ethers.getContractFactory('MarkSheetContract');
  const contract = await student.deploy();

  await contract.deployed();
  console.log('Contract Address ',contract.address);


  // await contract.addMarksheet({name:"as",rollno: "df", fatherName:"fga",universityName:"fga", collegeName:"fgd",degree: "fga", 
  // branch:"fg",status: "fga"},"pass",7, 1, 2, 
  // [{code: "sub1", name: "Subject 1", totalTheoryMarks: 100, 
  // obtainedTheoryMarks: 80, totalPracticalMarks: 50, obtainedPracticalMarks: 40,result:"pass",grade:"b+"}, 
  // {code: "sub2", name: "Subject 2", totalTheoryMarks: 100, obtainedTheoryMarks: 75, totalPracticalMarks: 50, 
  // obtainedPracticalMarks: 35,result:"pass",grade:"b+"}]
  // );


  // const res = await contract.getMarksheetByRollNo("df");
  // console.log(res);

  // const res1 = await contract.verifyMarksheet(res.hashes[0]);
  // console.log(res1);


  // const res2 = await contract.verifyMarksheet('0xe523e7204d6d2ec0cf976bcfa8234eb3639afcca4e584efa9f1e668e50e11274');
  // console.log(res2);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
