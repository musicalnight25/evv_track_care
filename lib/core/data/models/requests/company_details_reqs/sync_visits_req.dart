import '../../response/z_response/z_visit_model.dart';

class SyncVisitsReq {
  final String companyId;
  final List<ZVisitModel> visits;

  SyncVisitsReq({required this.companyId, required this.visits});

  Map<String, dynamic> toJson() => {
        'companyId': companyId,
        'data': visits.map((e) => e.toJson(true)).toList(),
      };
}
