class VisitsRequest {
  final int clientId;
  final int page;
  final int size;
  final String search;
  final String date;

  VisitsRequest({
    required this.clientId,
    this.page = 1,
    this.size = 10,
    this.search = "",
    this.date = "",
  });

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
        'client_id': clientId,
        'page': page,
        'size': size,
        'search': search,
        'date': date
      };
}
