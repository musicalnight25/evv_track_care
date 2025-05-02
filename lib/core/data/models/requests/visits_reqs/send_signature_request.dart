import 'dart:io';

class SendSignatureRequest {
  final String visitId;
  final File signatureFile;


  SendSignatureRequest({required this.visitId,required this.signatureFile});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'visit_id': visitId,
    'signature_file': signatureFile,
  };

}