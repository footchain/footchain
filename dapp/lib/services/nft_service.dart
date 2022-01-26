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

  Future<String> postCharacterGenerateMetadata(
    BigInt tokenId,
    String signature,
  ) async {
    var url = Uri.parse('${Constants.functionUri}generateMetadata');
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };
    var body = jsonEncode(
        <String, String>{"tokenId": "$tokenId", "signature": signature});
    var response = await http.post(url, body: body, headers: headers);
    return response.body;
  }
}
