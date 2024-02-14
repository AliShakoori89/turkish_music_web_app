import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/ui/detail_page.dart';

class TitleText extends StatelessWidget {

  final String title;
  final bool haveSeeAll;
  const TitleText({super.key, required this.title, required this.haveSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontFamily: 'Salsa'
            )),
        haveSeeAll == true
            ? InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                const DetailPage(
                    songName: "Şımarık",
                    singerName: "Tarkan",
                    singerImage: "assets/images/tarkan.png",)));
          },
          child: const Text(
              "see all >>",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey
          )),
            )
            : const Text("")
      ],
    );
  }
}
