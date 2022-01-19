import 'package:get_it/get_it.dart';

import '../models/app_model.dart';
import '../services/airdrop_service.dart';
import '../services/nft_service.dart';

class BaseCommand {
  AppModel appModel = GetIt.I.get<AppModel>();
  AirdropService airdropService = GetIt.I.get<AirdropService>();
  NftService nftService = GetIt.I.get<NftService>();
}
