enum Routes {
  splash,
  appScaffold,
  home,
  login,
  agency,
  patient,
  demo,
  demo2,
  task,
  profile,
  map,
  thanks,
  sign;

  @override
  String toString() => "/$name";

  String get path => "/$name";

  const Routes();
}



