import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/character_dto.dart';
import '../utils/constants.dart';

class NftService {
  Future<CharacterDto> getCharacterRequest(String token) async {
    var url = Uri.parse('${Constants.nftUrl}$token');
    var response = await http.get(url);
    Map<String, dynamic> map = jsonDecode(response.body);
    return CharacterDto.fromJson(map);
  }
}
