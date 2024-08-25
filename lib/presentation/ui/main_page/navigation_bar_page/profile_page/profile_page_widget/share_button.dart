import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../../../helpers/widgets/custom_card.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        const String appLink = 'https://play.google.com/store/apps/details?id=com.example.myapp';
        const String message = 'Check out my new app: $appLink';

        // Share the app link and message using the share dialog
        await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);
      },
      child: const CustomCard(
          title: "Share",
          customIcon: Icons.share,
          customColor: Colors.grey),
    );
  }
}
