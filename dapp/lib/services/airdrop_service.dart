import 'dart:convert';

import 'package:dapp/dto/response_dto.dart';
import 'package:dapp/dto/signature_dto.dart';
import 'package:http/http.dart' as http;

class AirdropService {
  Future<SignatureDto?> postRequest(
      String recaptchaToken, String address) async {
    var url = Uri.parse(
        'https://us-central1-footchain2022.cloudfunctions.net/requestAirdropPass');
    var response = await http
        .post(url, body: {'token': recaptchaToken, 'address': address});
    Map<String, dynamic> map = jsonDecode(response.body);
    var responseDto = ResponseDto.fromJson(map);
    if (responseDto.success) {
      return SignatureDto.fromJson(map["result"]);
    }
  }
}
