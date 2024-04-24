// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract PatientInfo {
    struct UserData {
        string encryptedPrivateKey; // Encrypted private key
        string encryptedCPABESecretKey; // Encrypted CP-ABE secret key
        string status; // Status associated with the user
    }

    mapping(string => UserData) private userInfo; // Maps username to user data

    // Function to set user data
    function setUserData(
        string memory _username,
        string memory _encryptedPrivateKey,
        string memory _encryptedCPABESecretKey
    ) public {
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(bytes(_encryptedPrivateKey).length > 0, "Encrypted private key cannot be empty");
        require(bytes(_encryptedCPABESecretKey).length > 0, "Encrypted CP-ABE secret key cannot be empty");

        userInfo[_username] = UserData({
            encryptedPrivateKey: _encryptedPrivateKey,
            encryptedCPABESecretKey: _encryptedCPABESecretKey,
            status: "unverified"
        });
    }

    // Function to get user data
function getUserData(string memory _username)
    public
    view
    returns (
        string memory,
        string memory,
        string memory
    )
{
    UserData memory data = userInfo[_username];
    if (keccak256(bytes(data.status)) == keccak256(bytes("blacklisted"))) {
        revert("Blacklisted");
    } else {
        return (data.encryptedPrivateKey, data.encryptedCPABESecretKey, data.status);
    }
}

    // Function to update user status
    function updateUserStatus(string memory _username, string memory _status) public {
        require(bytes(userInfo[_username].status).length != 0, "User does not exist");
        userInfo[_username].status = _status;
    }
}
