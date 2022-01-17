import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

import '../dto/user_dto.dart';
import '../utils/constants/constants.dart';

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

  UserDto? _userDto;
  UserDto? get user => _userDto;
  set user(UserDto? user) {
    _userDto = user;
    notifyListeners();
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  bool get networkEnabled => Ethereum.isSupported && ethereum != null;
  bool get connected =>
      networkEnabled &&
      user != null &&
      user!.address != null &&
      user!.address!.isNotEmpty;
  String _currentRoute = airdropRoute;
  String get currentRoute => _currentRoute;
  set currentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }

  final List<String> _gameRoutes = [playersRoute];
  bool get gameModeActive => _gameRoutes.contains(currentRoute);
}
