import 'package:dapp/services/airdrop_service.dart';
import 'package:get_it/get_it.dart';
import 'models/app_model.dart';

void initServiceLocator() {
  GetIt.I.registerLazySingleton<AppModel>(() => AppModel());
  GetIt.I.registerLazySingleton<AirdropService>(() => AirdropService());
}
