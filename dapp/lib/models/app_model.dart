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

  String? _currentAccount;
  String? get currentAccount => _currentAccount;
  set currentAccount(String? account) {
    _currentAccount = account;
    notifyListeners();
  }
}
