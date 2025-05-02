import 'dart:developer' as dev;

List<String> msgList = [];

void devlog(String msg, {String? name}) {
  // if(msgList.contains(msg)) return;
  dev.log("--> --> -->  $msg", name: name ?? " LOG ");
  msgList.add(msg);
}

void devlogError(String error) {
  dev.log("==> ==> ==> * $error", name: " ERROR ");
}

void devlogApi(String msg) {
  dev.log(" == == == >>> $msg", name: "[ API LOG ]");
}