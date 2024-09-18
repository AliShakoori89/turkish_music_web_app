import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/model/singer_model.dart';
import '../ui/main_page/navigation_bar_page/home_page/home_page_component/singer_container/singer_page/all_singer_page.dart';

class TitleText extends StatelessWidget {

  final String title;
  final bool haveSeeAll;
  List<SingerDataModel>? allSinger;
  List<String>? allSingerName;

  TitleText({super.key, required this.title, required this.haveSeeAll,
    this.allSinger, this.allSingerName});

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

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

            if(title == "Singer"){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              //     AllSingerPage(allSinger: allSinger!, allSingerName: allSingerName!)));

              context.push("/"+AllSingerPage.routeName, extra: {
                'allSinger': allSinger,
                'allSingerName': allSingerName,
              },);
            }
          },
          child: Padding(
            padding: orientation != Orientation.portrait
                ? const EdgeInsets.only(
              right: 50
            )
                : EdgeInsets.all(0),
            child: 
            const Text(
                "see all >>",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey
            )),
          ),
            )
            : const Text("")
      ],
    );
  }
}
