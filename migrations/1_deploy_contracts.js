const MasterList = artifacts.require("MasterList");
const UserInfo = artifacts.require("UserInfo");

module.exports = function (deployer) {
  //deployer.deploy(IterableMapping);
  //deployer.link(IterableMapping, Registration);
  deployer.deploy(MasterList);
  deployer.deploy(UserInfo);
};
