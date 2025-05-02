class Apis {
  // static const baseUrl = "https://caretrack.i-mbu.app/";
  static const baseUrl = "https://prod.evv-caretrack.app/";


  static const name = "api";
  static const url = "$baseUrl/$name";

  static const login = "/auth/login";
  static const companyDetails = "/company/details";
  static const clientVisits = "/client/visits";
  static const clientDetails = "/clients/details";
  static const clientVisit = "/client/visit";
  static const clientVisitTaskAdd = "/client/visit/tasks/add";
  static const clientVisitsadd = "/client/visits/add";
  static const startVisit = "/client/visit/start";
  static const completeVisit = "/client/visit/complete";
  static const clients = "/clients";
  static const taskList =   "/client/services" ; //"/company/tasklist";
  static const sendSignature = "/client/visits/signature";
  static const sendAudio = "/client/visits/audio";
  static const visitsStatus = "/client/visits/status";
  static const listProvider = "/employee/list-provider";
  static const services = "/company/services";
  static const offline_fetch = "/fetch-offline";
  static const sync_offline = "/sync-offline";

}
