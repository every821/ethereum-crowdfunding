// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public addressToAmountFunded;
    uint256 public TotalBal;
    uint256 public TotalBalUsd;
    uint256 public value_convert;
    address public owner;

    constructor() public{
            
        owner = msg.sender;
    }

    function fund() public payable {
        require(convertEthPrice(msg.value)   > 4  ,"Value is less then 4$");
        addressToAmountFunded[msg.sender] += msg.value;
        TotalBal+=msg.value;
        TotalBalUsd+=value_convert;
    }

    function convertEthPrice(uint256 donation) public returns (uint256){
            uint256 current_price =  getPrice();
            uint256 GweiToEthar = uint256(donation) * current_price;
            value_convert = GweiToEthar /10**18;
            return value_convert;

    }
    
    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceEth = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (
                uint80 roundId,
                int256 answer,
                uint256 startedAt,
                uint256 updatedAt,
                uint80 answeredInRound
                )   =      priceEth.latestRoundData();

        return uint256(answer)/10**8;

    }
    
    modifier onlyOwner {
        require(msg.sender == owner,"Only owner can withdraw");
        _;
    }
    function withdraw() payable onlyOwner public {
        msg.sender.transfer(address(this).balance);
        TotalBal = 0;
        TotalBalUsd = 0;
    }


}