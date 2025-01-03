import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

Future<void> launchMyURL(String url) async {
  final Uri uri = Uri.parse(url); // Parse the URL string into a Uri object
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // Opens in an external browser
    );
  } else {
    throw 'Could not launch $url';
  }
}

bool isVideo(String? url) {
  if (url == null) return false;
  final extension = path.extension(url).toLowerCase();
  return ['.mp4', '.mov', '.avi', '.wmv', '.flv', '.mkv'].contains(extension);
}
