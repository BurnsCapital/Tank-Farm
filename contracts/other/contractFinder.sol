// Contract Finder
//
// @authors:
// Cody Burns <dontpanic@codywburns.com>
// license: Apache 2.0
// version:
// deployed at: 0xda10E214AC0E07DE91c42143EC32e936a7629189
pragma solidity ^0.4.11;

// Intended use:
// for any public address and nonce, find out which contract it will make
// Status: functional
// still needs:
// submit pr and issues to https://github.com/realcodywburns/tank-Farm


contract contractGuesser {

////////////////
//Global VARS//////////////////////////////////////////////////////////////////////////
//////////////

/* Address */

  address cAddress;


///////////
//MAPPING/////////////////////////////////////////////////////////////////////////////
///////////


///////////
//EVENTS////////////////////////////////////////////////////////////////////////////
//////////

/////////////
//MODIFIERS////////////////////////////////////////////////////////////////////
////////////

//////////////
//Operations////////////////////////////////////////////////////////////////////////
//////////////

////////////
//OUTPUTS///////////////////////////////////////////////////////////////////////
//////////

/* public */

function addressForNonce(address _master, uint8 _nonce) constant returns (address) {

    // 0to127
    if (_nonce <= 127){
        cAddress = address(sha3(0xd6, 0x94, address(_master), _nonce));
    }

    // 128to255
    if (_nonce >= 128 && _nonce <= 256){
      cAddress =address(sha3(0xd7, 0x94, address(_master), 0x81, _nonce));
    }

    // 256to65535
    if (_nonce >= 256){
       cAddress =address(sha3(0xd8, 0x94, address(_master), 0x82, _nonce));
    }
    return cAddress;
  }


////////////
//SAFETY ////////////////////////////////////////////////////////////////////
//////////
//safety switches consider removing for production
//clean up after contract is no longer needed



/////////////////////////////////////////////////////////////////////////////
// 88888b   d888b  88b  88 8 888888         _.-----._
// 88   88 88   88 888b 88 P   88   \)|)_ ,'         `. _))|)
// 88   88 88   88 88`8b88     88    );-'/             \`-:(
// 88   88 88   88 88 `888     88   //  :               :  \\   .
// 88888P   T888P  88  `88     88  //_,'; ,.         ,. |___\\
//    .           __,...,--.       `---':(  `-.___.-'  );----'
//              ,' :    |   \            \`. `'-'-'' ,'/
//             :   |    ;   ::            `.`-.,-.-.','
//     |    ,-.|   :  _//`. ;|              ``---\` :
//   -(o)- (   \ .- \  `._// |    *               `.'       *
//     |   |\   :   : _ |.-  :              .        .
//     .   :\: -:  _|\_||  .-(    _..----..
//         :_:  _\\_`.--'  _  \,-'      __ \
//         .` \\_,)--'/ .'    (      ..'--`'          ,-.
//         |.- `-'.-               ,'                (///)
//         :  ,'     .            ;             *     `-'
//   *     :         :           /
//          \      ,'         _,'   88888b   888    88b  88 88  d888b  88
//           `._       `-  ,-'      88   88 88 88   888b 88 88 88   `  88
//            : `--..     :        *88888P 88   88  88`8b88 88 88      88
//        .   |           |	        88    d8888888b 88 `888 88 88   ,  `"	.
//            |           | 	      88    88     8b 88  `88 88  T888P  88
/////////////////////////////////////////////////////////////////////////
