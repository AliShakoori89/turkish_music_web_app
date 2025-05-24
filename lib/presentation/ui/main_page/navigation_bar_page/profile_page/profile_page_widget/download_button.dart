import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../helpers/widgets/custom_card.dart';

class ShareButton extends StatelessWidget {

  final Uri _apkUrl = Uri.parse('https://turkishsongs.ir/app/Tmusic.apk');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(_apkUrl)) {
          await launchUrl(_apkUrl, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch download link')),
          );
        }
      },
      child: const CustomCard(
          title: "Download App",
          customIcon: Icons.download_outlined,
          customColor: Colors.grey),
    );
  }
}
