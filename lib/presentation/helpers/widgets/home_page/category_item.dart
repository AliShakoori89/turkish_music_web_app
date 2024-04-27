import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

import '../../../const/title.dart';

class CategoryItemContainer extends StatelessWidget {
  CategoryItemContainer({super.key});

  var categories_item = [
    'assets/category_images/top song.png',
    'assets/category_images/happy song.png',
    'assets/category_images/nostalgia.png',
    'assets/category_images/sad song.png',
    'assets/category_images/songs on the road.png',
    'assets/category_images/turkce rap.png',
    'assets/category_images/remix.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleText(title: "Category", haveSeeAll: false),
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
                categories_item.length,
                    (index) => Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.030,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage(categories_item[index]),
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
