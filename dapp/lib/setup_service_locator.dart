import 'package:get_it/get_it.dart';

import 'models/app_model.dart';
import 'services/airdrop_service.dart';
import 'services/nft_service.dart';
import 'storage/shared_preferences_store.dart';
import 'storage/storage.dart';

void initServiceLocator() {
  GetIt.I.registerLazySingleton<AppModel>(() => AppModel());
  GetIt.I.registerLazySingleton<AirdropService>(() => AirdropService());
  GetIt.I.registerLazySingleton<Storage>(() => SharedPreferencesStore());
  GetIt.I.registerLazySingleton<NftService>(() => NftService());
}
