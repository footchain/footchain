import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class AppModel extends ChangeNotifier {
  Contract? _tokenContract;
  Contract? get tokenContract => _tokenContract;
  set tokenContract(Contract? contract) {
    _tokenContract = contract;
    notifyListeners();
  }

  Contract? _nftContract;
  Contract? get nftContract => _nftContract;
  set nftContract(Contract? contract) {
    _nftContract = contract;
    notifyListeners();
  }

  Contract? _airdropContract;
  Contract? get airdropContract => _airdropContract;
  set airdropContract(Contract? contract) {
    _airdropContract = contract;
    notifyListeners();
  }

  Contract? _marketplaceContract;
  Contract? get marketplaceContract => _marketplaceContract;
  set marketplaceContract(Contract? contract) {
    _marketplaceContract = contract;
    notifyListeners();
  }

  Contract? _treinoContract;
  Contract? get treinoContract => _treinoContract;
  set treinoContract(Contract? contract) {
    _treinoContract = contract;
    notifyListeners();
  }

  String? _currentAccount;
  String? get currentAccount => _currentAccount;
  set currentAccount(String? account) {
    _currentAccount = account;
    notifyListeners();
  }
}
