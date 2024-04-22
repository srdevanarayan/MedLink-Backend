//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract MasterList {
    mapping(string => string) private userToRegion; // Maps username to region

    // Function to check if a username exists
    function usernameExists(string memory _username) public view returns (bool) {
        return bytes(userToRegion[_username]).length > 0;
    }

    // Function to add a username-region pair
    function addUsernameRegion(string memory _username, string memory _region) public {
        require(bytes(_username).length > 0, "Username is required"); // Check if username is provided
        require(bytes(_region).length > 0, "Region is required"); // Check if region is provided
        require(!usernameExists(_username), "Username already exists"); // Ensure username doesn't already exist
        userToRegion[_username] = _region;
    }

    // Function to get the region associated with a username
    function getRegion(string memory _username) public view returns (string memory) {
        require(usernameExists(_username), "Username does not exist");
        return userToRegion[_username];
    }
}
