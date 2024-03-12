import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo/tMusic.png",
            width: 40,
            height: 40,),
          const SizedBox(width: 15,),
          const Text("Turkish Music",
          style: TextStyle(
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.purple,
                ),
              ],
            fontFamily: "Dancing Script",
            fontSize: 35
          )),
        ],
      ),
    );
  }
}
