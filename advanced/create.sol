
/*
	在合约中创建新合约
	在以太坊链上, 用户(外部账户, EOA)可以创建智能合约, 智能合约同样也可以创建
	新的智能合约; 去中心化交易所 uniswap(TODO) 就是利用工厂合约(Factory)创建
	了无数个币对合约(Pair);
	
	有两种方法可以在合约中创建新合约, create 和 create2
	create 的用法很简单, new 一个合约并传入新合约构造函数所需的参数:
		Contract x = new Contract{value: _value}(params)
	

	其中Contract是要创建的合约名, x是合约对象(地址), 如果构造函数是payable, 
	可以创建时转入_value数量的ETH, params是新合约构造函数的参数

	极简 Uniswap(TODO: 熟悉)
	Uniswap V2核心合约中包含两个合约: https://github.com/Uniswap/v2-core/tree/master/contracts
	1. UniswapV2Pair: 币对合约, 用于管理币对地址、流动性、买卖(TODO: 币对)
	2. UniswapV2Factory: 工厂合约, 用于创建新的币对, 并管理币对地址


	用create方法实现一个极简版的Uniswap:
	Pair币对合约负责管理币对地址
	PairFactory工厂合约用于创建新的币对, 并管理币对地址

	Pair 合约
	contract Pair{
		address public factory; // 工厂合约地址
		address public token0; // 代币1
		address public token1; // 代币2

		constructor() payable {
			factory = msg.sender;
		}

		// called once by the factory at time of deployment
		function initialize(address _token0, address _token1) external {
			require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
			token0 = _token0;
			token1 = _token1;
		}
	}

	为什么uniswap不在constructor中将token0和token1地址更新好?
	因为uniswap使用的是create2创建合约, 限制构造函数不能有参数; 当使用create时, 
	Pair合约允许构造函数有参数, 可以在constructor中将token0和token1地址更新好

	PairFactory合约(TODO)
	contract PairFactory{
		mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
		address[] public allPairs; // 保存所有Pair地址

		function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
			// 创建新合约
			Pair pair = new Pair();
			// 调用新合约的initialize方法
			pair.initialize(tokenA, tokenB);
			// 更新地址map
			pairAddr = address(pair);
			allPairs.push(pairAddr);
			getPair[tokenA][tokenB] = pairAddr;
			getPair[tokenB][tokenA] = pairAddr;
		}
	}

	工厂合约(PairFactory)有两个状态变量, getPair是两个代币地址到币对地址的map, 
	方便根据代币找到币对地址; allPairs是币对地址的数组, 存储了所有代币地址

*/
