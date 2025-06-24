class ComanyDetailsReqs {
  final String companyId;
  final int page;
  final int size;
  final String search;

  ComanyDetailsReqs(
      {required this.companyId,
      this.page = 1,
      this.size = 10,
      this.search = ""});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() =>
      {'company': companyId, 'page': page, 'size': size, 'search': search};
}
