import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  final String url;

  LaunchUrl(this.url);

  urlLauncher() async {
    if (await canLaunch(this.url)) {
      await launch(this.url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
