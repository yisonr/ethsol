// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ControlFlow{
	
	// if else
	function ifElseTest(uint256 _number) public pure returns(bool){
		if(_number == 0){
			return(true);
		}else{
			return(false);
		}
	}

	// for loop
	function forLoopTest() public pure returns(uint256){
		uint sum = 0;
		for(uint i = 0; i < 10; i++){
			sum += i;
		}
		return(sum);
	}

	// while 
	function whileTest() public pure returns(uint256){
		uint sum = 0;
		uint i = 0;
		while(i < 10){
			sum += i;
			i++;
		}
		return(sum);
	}

	// 三元运算符
	function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
		// return the max of x and y
		return x >= y ? x: y;
	}

	// continue 和 break 的用法与其他语言一样
}
