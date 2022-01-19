import '../dto/character_dto.dart';
import 'constants.dart';

String getCharacterImage(CharacterDto character) {
  try {
    return '${Constants.nftUrl}${character.image!.split('//')[1]}';
  } catch (e) {
    return 'default-image';
  }
}
