pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Vaccine {
    string public message;
    
    struct User {
        string name;
        uint birthday;
        string vaccine_type;
        string[] vaxtypes;
        uint[] vaxdates;
    }
    
    User[] records;

    function addVaxxedUser(string memory name, uint birthday, string[] memory vaxtypes, uint[] memory vaxdates) public {
        User memory newUser;
        newUser.name = name;
        newUser.birthday = birthday;
        newUser.vaxtypes = new string[](vaxtypes.length);
        for(uint i = 0; i< vaxtypes.length;i++){
            newUser.vaxtypes[i] = vaxtypes[i];
        }
        newUser.vaxdates = new uint[](vaxdates.length);
        for(uint i = 0; i< vaxdates.length;i++){
            newUser.vaxdates[i] = vaxdates[i];
        }
        records.push(newUser);
    }

    function addVaxToUser(string memory name, uint birthday, string memory vaxtype, uint vaxdate) public {
        uint i = findUserIndex(name, birthday);
        
        string[] memory temp_vaxtypes = new string[](records[i].vaxtypes.length);
        for(uint j = 0; j < records[i].vaxtypes.length; j++){
            temp_vaxtypes[j] = records[i].vaxtypes[j];
        }
        records[i].vaxtypes = new string[](temp_vaxtypes.length+1);
        for(uint j = 0; j < temp_vaxtypes.length; j++){
            records[i].vaxtypes[j] = temp_vaxtypes[j];
        }
        records[i].vaxtypes[records[i].vaxtypes.length-1] = vaxtype;

        uint[] memory temp_vaxdates = new uint[](records[i].vaxdates.length);
        for(uint j = 0; j < records[i].vaxdates.length; j++){
            temp_vaxdates[j] = records[i].vaxdates[j];
        }
        records[i].vaxdates = new uint[](temp_vaxdates.length+1);
        for(uint j = 0; j < temp_vaxdates.length; j++){
            records[i].vaxdates[j] = temp_vaxdates[j];
        }
        records[i].vaxdates[records[i].vaxdates.length-1] = vaxdate;

    }
    
    // Add first vaccine date?
    // If multiple matches, return all matches?
    function findUser(string memory name, uint birthday) public view returns (User memory){
        User memory ret;
        for (uint i=0; i<records.length; i++){
            if (keccak256(abi.encodePacked((name))) == keccak256(abi.encodePacked(records[i].name)) && 
                keccak256(abi.encodePacked((birthday))) == keccak256(abi.encodePacked(records[i].birthday))){
                return records[i];
            }
        }
        return ret;
    }

     function findUserIndex(string memory name, uint birthday) public view returns (uint){
        for (uint i=0; i<records.length; i++){
            if (keccak256(abi.encodePacked((name))) == keccak256(abi.encodePacked(records[i].name)) && 
                keccak256(abi.encodePacked((birthday))) == keccak256(abi.encodePacked(records[i].birthday))){
                return (i);
            }
        }
        return (0);
    }
    
}