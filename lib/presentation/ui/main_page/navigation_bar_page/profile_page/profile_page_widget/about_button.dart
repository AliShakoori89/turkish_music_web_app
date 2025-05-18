import 'package:flutter/material.dart';

import '../../../../../const/custom_divider.dart';
import '../../../../../helpers/widgets/custom_card.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        return showAlertDialog(context);
      },
      child: const CustomCard(
          title: "About",
          customIcon: Icons.help_center_outlined,
          customColor: Colors.grey),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SizedBox(
            height: 100,
            child: Row(
              children: [
                Text('direct by : '),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('A.Shakoori'),
                    SizedBox(
                      height: 5,
                    ),
                    Text('P.Pourhakim'),
                  ],
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
