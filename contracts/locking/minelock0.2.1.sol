pragma solidity ^0.4.19;
// Mining forward contract
// Timelocked transferable mining contract, to be filled over time and payout to current owner
// @authors:
// Cody Burns <dontpanic@codywburns.com>
// license: Apache 2.0

// usage:
// A miner deploys the contract and updates the pool information(a url to the pool account) and a list price
// A buyer pays the list price and becomes owner
// the owner can relist or wait until maturity and withdraw

contract minelock {

////////////////
//Global VARS//////////////////////////////////////////////////////////////////////////
//////////////

    uint public deliveryDate;                    // stores the unix encoded timestamp of release
    uint public termOfTrade;                     // final contract goal
    bool public metToT;                          // did contract close
    uint public listPrice;                       // allow for dynamic pricing
    address public owner = msg.sender;           // person who is currently able to withdraw
    address public sponsor = msg.sender;         // person who is putting reputation on the line
    string public pool;                          // pool url the contract can be viewed at
    string public version = "v0.2.2";            // version

///////////
//MAPPING/////////////////////////////////////////////////////////////////////////////
///////////


///////////
//EVENTS////////////////////////////////////////////////////////////////////////////
//////////
    event Funded(address indexed locker, uint indexed amount);      // announce when new funds arrive
    event Released(address indexed locker, uint indexed amount);    // announce when minelock pays out
    event Priced(uint latestPrice);                                 // announce when the price changes
    event Pooled(string newPoolLink);                               // announce when the sponsor changes pools

/////////////
//MODIFIERS////////////////////////////////////////////////////////////////////
////////////

    modifier onlyOwner { require(msg.sender == owner); _; }        // things only the current owner can do
    modifier onlySponsor { require(msg.sender == sponsor);  _; }    // things only the sponsor can do

//////////////
//Operations////////////////////////////////////////////////////////////////////////
//////////////

/* init */
  function minelock(uint _deliveryDate, uint _termsOfTrade, uint _listPrice, string _pool) internal {
   deliveryDate = _deliveryDate;
   termOfTrade = _termsOfTrade;
   listPrice = _listPrice;
   pool = _pool;
  }


/* public */

    //payable
    function() payable public{                                            // allow for funding
      assert(this.balance + msg.value > termOfTrade);
      Funded(msg.sender, msg.value);
    }

    function trade() payable public returns(bool){                                       //allow the contract to be owner traded
        assert(msg.value > listPrice);
        uint value = msg.value;
        uint returned = value - listPrice;
         //assign a new owner
        owner.transfer(value);                                      //buy out the previous owner
        value = 0;
        msg.sender.transfer(returned);                              //returns any excess funds to sender
        owner = msg.sender;
        return true;
    }

/* only owner */
    function withdraw() onlyOwner public{                                  // owner (person who paid the list price last) can withdraw after maturity
      assert(block.timestamp > deliveryDate);
      if(this.balance>= termOfTrade){metToT = true;}
      msg.sender.transfer(this.balance);
    }

        //allows for dynamic pricing
    function setPrice(uint _newPrice) onlyOwner public{                    // owner can change list price to find a buyer
        listPrice = _newPrice;
        Priced(listPrice);
    }

/* admin/group functions */

//allow sponsor to update the pool website. This is a string that represents the url to view the current hashrate of the mining contract. A "blind" forward is possible if this is blank
    function newPool(string _newPool) onlySponsor public{
        pool = _newPool;
        Pooled(pool);
    }

  }
 
