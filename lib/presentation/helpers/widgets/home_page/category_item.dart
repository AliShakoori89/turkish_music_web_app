import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/shimmer_container/category_shimmer_container.dart';

import '../../../const/title.dart';

class CategoryItemContainer extends StatefulWidget {
  CategoryItemContainer({super.key});

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
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if(state.status.isLoading){
        return CategoryShimmerContainer(shimmerLength: 8);
      }else if(state.status.isSuccess){
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
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
                      state.category.length,
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
                              image: DecorationImage(
                                  image: NetworkImage(state.category[index].imageSource),
                                  fit: BoxFit.fill
                              )
                          ),
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                      )),
                ),
              ),
            ],
          ),
        );
      }else if(state.status.isError){
        return CategoryShimmerContainer(shimmerLength: 8);
      }
      return CategoryShimmerContainer(shimmerLength: 8);
    });

  }
}
