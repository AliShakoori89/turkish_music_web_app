import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

import '../const/title.dart';

class MustListenContainer extends StatelessWidget {
  const MustListenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleText(title: "Must Listen", haveSeeAll: true),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.0052,
              vertical: MediaQuery.of(context).size.height * 0.03),
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          child: AnimatedListView(
            duration: 100,
            scrollDirection: Axis.horizontal,
            children: List.generate(
                10,
                    (index) => Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.030,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                        image: const DecorationImage(
                            image: AssetImage("assets/images/tarkan.png"),
                            fit: BoxFit.fill
                        )
                    ),
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
