import 'package:dapp/services/airdrop_service.dart';
import 'package:get_it/get_it.dart';
import '../models/app_model.dart';

class BaseCommand {
  AppModel appModel = GetIt.I.get<AppModel>();
  AirdropService airdropService = GetIt.I.get<AirdropService>();
}
