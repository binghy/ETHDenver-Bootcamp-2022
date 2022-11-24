// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "./Ownable.sol";

contract GasContractOptimized is Ownable {
    uint256 public tradeFlag = 1;
    uint256 public dividendFlag = 1;
    uint256 public totalSupply = 0;                     // cannot be updated
    uint256 public paymentCounter = 0;
    address public contractOwner;
    address[5] public administrators;
    mapping(address => uint256) balances;
    mapping(address => uint256) public whitelist;

    struct ImportantStruct {
        uint256 valueA;                                 // max 3 digits
        uint256 bigValue;
        uint256 valueB;                                 // max 3 digits
    }
    mapping(address => ImportantStruct) public whiteListStruct;

    enum PaymentType {
        Unknown,
        BasicPayment,
        Refund,
        Dividend,
        GroupPayment
    }
    PaymentType constant defaultPayment = PaymentType.Unknown;

    struct Payment {
        PaymentType paymentType;
        uint256 paymentID;
        address recipient;
        string recipientName;                           // max 8 characters
        bool adminUpdated;
        address admin;
        uint256 amount;
    }
    mapping(address => Payment[]) payments;

    struct History {
        uint256 lastUpdate;
        address updatedBy;
        uint256 blockNumber;
        bool trade;
    }
    History[] public paymentHistory;                    // when a payment was updated

    event supplyChanged(address indexed, uint256 indexed);
    event Transfer(address recipient, uint256 amount);   
    event PaymentUpdated(address admin, uint256 ID, uint256 amount, string recipient);
    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    error NotEnoughFunds(uint requested, uint available);
    error RecipientNameLong();
    error NotValidAddress();
    error NotSender();
    error NotValidId();
    error NotWhitelisted();
    error NotValidTier();

    modifier checkIfWhiteListed(address sender) {
        if (sender != msg.sender)
            revert NotSender();
        uint256 usersTier = whitelist[msg.sender];
        if (usersTier == 0)
            revert NotWhitelisted();
        if (usersTier >= 4)
            revert NotValidTier();
        _;
    }

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        totalSupply = _totalSupply;

        for (uint256 ii = 0; ii < administrators.length; ii++) {
            if (_admins[ii] != address(0)) {
                administrators[ii] = _admins[ii];
                if (_admins[ii] == contractOwner) {
                    balances[contractOwner] = totalSupply;
                    emit supplyChanged(_admins[ii], totalSupply);
                } else {
                    balances[_admins[ii]] = 0;
                    emit supplyChanged(_admins[ii], 0);
                }
            }
        }
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        bool admin = false;
        for (uint256 ii = 0; ii < administrators.length; ii++) {
            if (administrators[ii] == _user) {
                admin = true;
                break;
            }
        }
        return admin;
    }

    function balanceOf(address _user) public view returns (uint256 balance) {
        balance = balances[_user];
        return balance;
    }

    function getTradingMode() public view returns (bool _mode) {
        bool mode = false;
        if (tradeFlag == 1 || dividendFlag == 1) {
            mode = true;
        } else {
            mode = false;
        }
        return mode;
    }

    function addHistory(address _updateAddress, bool _tradeMode) public {
        History memory history;
        history.blockNumber = block.number;
        history.lastUpdate = block.timestamp;
        history.updatedBy = _updateAddress;
        history.trade = _tradeMode;
        paymentHistory.push(history);
    }

    function getPayments(address _user) public view returns (Payment[] memory payments_)
    {
        if (_user == address(0))
            revert NotValidAddress();
        return payments[_user];
    }

    function transfer(address _recipient, uint256 _amount, string calldata _name) public {
        uint balance = balances[msg.sender];
        if (balance < _amount)
            revert NotEnoughFunds(_amount,balance);
        if (bytes(_name).length >= 9)
            revert RecipientNameLong();
        balance -= _amount;
        balances[_recipient] += _amount;
        emit Transfer(_recipient, _amount);
        Payment memory payment;
        payment.paymentType = PaymentType.BasicPayment;
        payment.recipient = _recipient;
        payment.recipientName = _name;
        payment.amount = _amount;
        payment.paymentID = ++paymentCounter;
        payments[msg.sender].push(payment);
    }

    function updatePayment(address _user, uint256 _ID, uint256 _amount, PaymentType _type) public onlyOwner {
        if (_ID == 0)
            revert NotValidId();
        if (_user == address(0))
            revert NotValidAddress();

        for (uint256 ii = 0; ii < payments[_user].length; ii++) {
            if (payments[_user][ii].paymentID == _ID) {
                payments[_user][ii].adminUpdated = true;
                payments[_user][ii].admin = _user;
                payments[_user][ii].paymentType = _type;
                payments[_user][ii].amount = _amount;
                bool tradingMode = getTradingMode();
                addHistory(_user, tradingMode);
                emit PaymentUpdated(msg.sender,_ID,_amount,payments[_user][ii].recipientName);
            }
        }
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public onlyOwner {
        if (_tier >= 4 || _tier == 0)
            revert NotValidTier();
        whitelist[_userAddrs] = _tier;
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(address _recipient, uint256 _amount, ImportantStruct memory _struct) public checkIfWhiteListed(msg.sender) {
        if (balances[msg.sender] < _amount)
            revert NotEnoughFunds(_amount,balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _amount + whitelist[msg.sender];
        balances[_recipient] = balances[_recipient] + _amount - whitelist[msg.sender];
        ImportantStruct memory newImportantStruct = whiteListStruct[msg.sender];
        newImportantStruct.valueA = _struct.valueA;
        newImportantStruct.bigValue = _struct.bigValue;
        newImportantStruct.valueB = _struct.valueB;
        emit WhiteListTransfer(_recipient);
    }
    
}
