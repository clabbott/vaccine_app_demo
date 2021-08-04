pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Vaccine {
    string public message;
    
    struct User {
        string name;
        uint birthday;
        string vaccine_type;
        uint first_dose_date;
        uint second_dose_date;
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


        /*for(uint i = 0; i<vaxtypes.length; i++){
            string[] memory temp_vaxtypes[newUser.vaxtypes.length];
            for(uint j = 0; j < newUser.vaxtypes.length; j++){
                temp_vaxtypes[j] = newUser.vaxtypes[j];
            }
            newUser.vaxtypes = new string[](temp_vaxtypes.length+1);
            for(uint j = 0; j < temp_vaxtypes.length; j++){
                newUser.vaxtypes[j] = temp_vaxtypes[j];
            }
            newUser.vaxtypes[newUser.vaxtypes.length-1] = vaxtypes[i];
        }*/
        records.push(newUser);
    }
    
    function addUser(string memory name, uint birthday, string memory vaccine_type, uint first_dose_date, uint second_dose_date) public {
        User memory newUser;
        newUser.name = name;
        newUser.birthday = birthday;
        newUser.vaccine_type = vaccine_type;
        newUser.first_dose_date = first_dose_date;
        newUser.second_dose_date = second_dose_date;
        records.push(newUser);
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

     function findUserIndex(string memory name, uint birthday) public view returns (bool, uint){
        for (uint i=0; i<records.length; i++){
            if (keccak256(abi.encodePacked((name))) == keccak256(abi.encodePacked(records[i].name)) && 
                keccak256(abi.encodePacked((birthday))) == keccak256(abi.encodePacked(records[i].birthday))){
                return (true, i);
            }
        }
        return (false, 0);
    }
    
}