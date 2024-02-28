import 'package:flutter/material.dart';

import '../../const/custom_divider.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        return showAlertDialog(context);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 8,
                    bottom: 10
                ),
                child: Row(
                  children: [
                    Image.asset("assets/custom_icons/about.png",width: 20,
                        color: Colors.white),
                    const SizedBox(width: 10),
                    const Text("About"),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                size: 20,)
            ],
          ),
          const CustomDivider(
              dividerColor : Colors.grey
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Text("app license is 1.0.0 \n\ndirect by : "
              "\n                           A.Shakoori"
              "\n                           P.Pourhakim "),
        );
      },
    );
  }
}
