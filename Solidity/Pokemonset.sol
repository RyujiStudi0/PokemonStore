pragma solidity >=0.4.22 <0.6.0;

contract POKEMONCharacter {
    
    struct MONCharacter{
        uint id;
        string name;
        uint256 priceTag;
        address owner;
        string imagePath;
        bool haveOwner;
    }
    
    uint P_ID = 0;
    
    uint[] collectionMonCharaterId;
    mapping (uint => MONCharacter) monCharacter;
    event PurchaseCharacterErrorLog(address indexed buyer,string reason);
    event SoldCharacter(address indexed buyer,uint id);

    
    function addCharacter(string memory name,uint256 priceTag ,string memory imagePath) public returns(uint id){
        uint Id = P_ID++;
        
        monCharacter[Id] = MONCharacter(Id,name, priceTag, address(0x0000000000000000000000000000000000000000), imagePath,false);
        collectionMonCharaterId.push(Id);
        
        return Id;
    }
    
    function sellCharacter(uint id) public payable returns(bool){
        if(msg.value != monCharacter[id].priceTag){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, invalid value !!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        if(monCharacter[id].haveOwner){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, this character is have owner!!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        monCharacter[id].owner = msg.sender;
        monCharacter[id].haveOwner = true;
        emit SoldCharacter(msg.sender,id);
        
        return true;
    }
    
    function getChracterById(uint Id) public view returns(uint,string memory,uint256,address,string memory,bool){
        return (monCharacter[Id].id,monCharacter[Id].name,monCharacter[Id].priceTag,monCharacter[Id].owner,monCharacter[Id].imagePath,monCharacter[Id].haveOwner);
    }
    
    function getAllCharacter() public view returns(uint[] memory){
        return collectionMonCharaterId;
    }
    
    function getNextValId() public view returns(uint){
        return P_ID;
    }
    
}






