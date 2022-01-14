class SignatureDto {
  int v;
  String r;
  String s;
  SignatureDto(this.v, this.r, this.s);

  SignatureDto.fromJson(Map<String, dynamic> json)
      : v = json['v'],
        r = json['r'],
        s = json['s'];
}
