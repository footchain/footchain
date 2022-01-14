class ResponseDto<T> {
  bool success;
  T result;
  ResponseDto(this.success, this.result);

  ResponseDto.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        result = json['result'];
}
