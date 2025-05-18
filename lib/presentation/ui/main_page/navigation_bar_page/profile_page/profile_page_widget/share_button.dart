import 'package:flutter/material.dart';
import '../../../../../helpers/widgets/custom_card.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

      },
      child: const CustomCard(
          title: "Download App",
          customIcon: Icons.download_outlined,
          customColor: Colors.grey),
    );
  }
}
