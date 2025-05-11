import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/singer_container/singer_page/singer_page.dart';
import '../../../../../../bloc/singer_bloc/bloc.dart';
import '../../../../../../bloc/singer_bloc/event.dart';
import '../../../../../../bloc/singer_bloc/state.dart';
import '../../../../../../const/shimmer_container/artist_shimmer_container.dart';
import '../../../../../../const/title.dart';
import '../../../../../../helpers/widgets/hoverable_item.dart';

class SingerContainer extends StatefulWidget {

  @override
  State<SingerContainer> createState() => _SingerContainerState();
}

class _SingerContainerState extends State<SingerContainer> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SingerBloc>(context).add(GetFamousSingerEvent());
    BlocProvider.of<SingerBloc>(context).add(GetAllSingerNameEvent());
    BlocProvider.of<SingerBloc>(context).add(GetAllSingerEvent());

    return BlocBuilder<SingerBloc, SingerState>(builder: (context, state) {

      List<SingerDataModel> artistList = state.famousSinger;
      List<SingerDataModel> allSinger = state.allSinger;
      List<String> allSingerName = state.allSingerName;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          TitleText(
            title: "Singer",
            haveSeeAll: true,
            allSinger: allSinger,
            allSingerName: allSingerName,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.15,
              width: 1200,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: AnimatedListView(
                  duration: 100,
                  scrollDirection: Axis.horizontal,
                  cacheExtent: 1000,
                  children: List.generate(artistList.length, (index) {
                    return InkWell(
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        context.push(
                          "/" + SingerPage.routeName,
                          extra: artistList[index],
                        );
                      },
                      child: HoverableItem(
                        imageUrl: artistList[index].imageSource,
                        name: artistList[index].name,
                        boxShape: BoxShape.circle,
                        size: 80,
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}


