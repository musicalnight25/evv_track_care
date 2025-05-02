class LoginReq {
  final String email;
  final String password;

  LoginReq({required this.email, required this.password});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  /// CREATE toFormData() METHOD HERE IF YOUR REQUEST CONTAINS FILE
  /// AND IT HAVE TO CONVERT TO MULTIPART FILE TO PASS DATA IN API
  /// FOR THAT HERE IS DEMO
  ///
  //  Future<FormData> toFormData() async {
  //     final imagee = await MultipartFile.fromFile(image?.path ?? "", contentType: MediaType.parse(getMimeType(filePath: image?.path ?? "")));
  //     return FormData.fromMap({
  //       'name': name,
  //       'image': imagee,
  //       'status': status ? 1 : 0,
  //     });
  //   }
}
