import 'dart:convert';

import '../dto/response_dto.dart';
import '../dto/signature_dto.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class AirdropService {
  Future<SignatureDto?> postRequest(
      String recaptchaToken, String address) async {
    var url = Uri.parse('${Constants.functionUri}requestAirdropPass');
    var response = await http
        .post(url, body: {'token': recaptchaToken, 'address': address});
    Map<String, dynamic> map = jsonDecode(response.body);
    var responseDto = ResponseDto.fromJson(map);
    if (responseDto.success) {
      return SignatureDto.fromJson(map["result"]);
    }
  }
}
