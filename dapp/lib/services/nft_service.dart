import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/character_dto.dart';
import '../dto/response_dto.dart';
import '../utils/constants.dart';

class NftService {
  Future<CharacterDto> getCharacterRequest(String token) async {
    var url = Uri.parse('${Constants.nftUrl}$token');
    var response = await http.get(url);
    Map<String, dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
    return CharacterDto.fromJson(map);
  }

  Future<String> postCharacterGenerateMetadata(
    BigInt tokenId,
    String signature,
  ) async {
    var url = Uri.parse('${Constants.functionUri}generateMetadata');

    var response = await http
        .post(url, body: {"tokenId": "$tokenId", "signature": signature});
    Map<String, dynamic> map = jsonDecode(response.body);
    var responseDto = ResponseDto.fromJson(map);
    if (responseDto.success) {
      return map['hash'];
    }
    return '';
  }
}
