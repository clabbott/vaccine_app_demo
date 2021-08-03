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
    }
    
    struct Vacciene{
        uint dose_dates;
        string vaccine_type;
    }
    
    User[] records;
    
     /*function addVaccine (User u, VaccineRecord v) public returns (bool) {
        User memory temp_user = u;
        VaccineRecord memory temp_v = v;
        bool found;
        uint index; 
        (found, index) = findUserIndex(temp_user.name, temp_user.birthday);
        if(found){
            User storage found_user = records[index];
            found_user.doses = temp_v;
            return true;
        }else{
            return false;
        }
    }*/
    
    
    function addUser(string memory name, uint birthday, string memory vaccine_type, uint first_dose_date, uint secord_dose_date) public {
        User memory newUser = User(name, birthday, vaccine_type, first_dose_date, secord_dose_date);
        records.push(newUser);
    }
    
    // Add first vaccine date?
    // If multiple matches, return all matches?
    function findUser(string memory name, uint birthday) public view returns (string memory){
        for (uint i=0; i<records.length; i++){
            if (keccak256(abi.encodePacked((name))) == keccak256(abi.encodePacked(records[i].name)) && 
                keccak256(abi.encodePacked((birthday))) == keccak256(abi.encodePacked(records[i].birthday))){
                return "found";
            }
        }
        
        return "not found";
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