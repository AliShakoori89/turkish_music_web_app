import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title,
  required this.singerName, required this.haveMenuButton});

  final String title;
  final String singerName;
  final bool haveMenuButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  singerName,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        haveMenuButton
            ? IconButton(
          onPressed: () {

          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        )
            : SizedBox(
          width: MediaQuery.of(context).size.width * 0.09,
        )
      ],
    );
  }
}
