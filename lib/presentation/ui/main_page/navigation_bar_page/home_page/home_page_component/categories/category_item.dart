import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/shimmer_container/category_shimmer_container.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/categories/category_item/category_songs_page.dart';
import '../../../../../../const/title.dart';

class CategoryItemContainer extends StatefulWidget {

  @override
  State<CategoryItemContainer> createState() => _CategoryItemContainerState();
}

class _CategoryItemContainerState extends State<CategoryItemContainer> {

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {

      return Column(
        children: [
          TitleText(title: "Category", haveSeeAll: false),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0052,
                vertical: MediaQuery.of(context).size.height * 0.03),
            height: orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: AnimatedListView(
              duration: 100,
              scrollDirection: Axis.horizontal,
              cacheExtent: 1000,
              children: List.generate(
                  state.allCategory.length,
                      (index){
                    return Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.030,
                      ),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onTap: (){
                          context.push(
                            "/"+CategorySongPage.routeName, // The path defined in GoRouter
                            extra: {
                              'imageSource': state.allCategory[index].imageSource,
                              'categoryName': state.allCategory[index].title,
                              'categoryID': state.allCategory[index].id
                            }, // Pass the artistDetail via extra
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: state.allCategory[index].imageSource!,
                          imageBuilder: (context, imageProvider) => Container(
                            width: orientation == Orientation.portrait
                                ? MediaQuery.of(context).size.width * 0.3
                                : MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.withValues(alpha: 0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(state.allCategory[index].imageSource!),
                                    fit: BoxFit.fill
                                )
                            ),
                          ),
                          placeholder: (context, url) => CategoryShimmerContainer(shimmerLength: 6,),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    );
                      }),
            ),
          ),
        ],
      );
    });

  }
}
