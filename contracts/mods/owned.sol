pragma solidity ^0.4.11;


// owned
// allow for owner
// @authors:
// Cody Burns <dontpanic@codywburns.com>
// license: Apache 2.0

// usage:
// assigns owner and only allows them to call the function 

contract owned{
  address owner;
  function owned () public {owner = msg.sender;}
  modifier onlyOwner {
          reqiure(msg.sender == owner)
          _;
          }
  }
