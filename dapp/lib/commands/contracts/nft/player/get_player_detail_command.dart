import '../../../../dto/character_dto.dart';
import '../../../base_command.dart';

class GetPlayerDetailCommand extends BaseCommand {
  Future<CharacterDto> execute(String token) async {
    var character = await nftService.getCharacterRequest(token);
    return character;
  }
}
