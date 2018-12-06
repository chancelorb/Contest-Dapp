var ContestApp = artifacts.require("./ContestApp.sol");


module.exports = function(deployer) {
  deployer.deploy(ContestApp);
};
