import 'package:url_launcher/url_launcher.dart';

import '../../config/error/exceptions.dart';
import 'devlog.dart';

launchNewUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!(await launchUrl(uri))) {
    devlogError("ERROR LAUNCHURL : url -< $url");
    throw const ServerException("Unexpected error occured while launching url.!");
  }
}
