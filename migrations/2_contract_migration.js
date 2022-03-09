const RoundXToken = artifacts.require('./RoundXToken.sol');
const fs = require("fs");

const relativePath = "../../../config/smart-contracts/PetToken";
const writeFile = (fileName, content) => {
  fs.writeFile(`${__dirname}/${relativePath}/${fileName}`, content, (error) => {
    if (error) {
      console.log("writeFile error", error);
    }
  });
};

module.exports = function(deployer) {
  deployer.deploy(RoundXToken).then(() => {
    if (RoundXToken._json) {
      // 1. Record recently deployed contract's abi file to 'deployedABI'
      writeFile(
        "deployedABI",
        JSON.stringify(RoundXToken._json.abi, 2),
        (error) => {
          if (error) throw error;
          console.log(
            `The abi of ${RoundXToken._json.contractName} is recorded on deployedABI file`
          );
        }
      );
    }

    // 2. Record recently deployed contract's address to 'deployedAddress'
    writeFile("deployedAddress", RoundXToken.address, (error) => {
      if (error) throw error;
      console.log(
        `The deployed contract address * ${RoundXToken.address} * is recorded on deployedAddress file`
      );
    });
  });
};
};
