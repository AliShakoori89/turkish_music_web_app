import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';

class TopSongPage extends StatefulWidget {

  static String routeName = "TopSongPage";
  final String imageSource;

  const TopSongPage({super.key, required this.imageSource});

  @override
  State<TopSongPage> createState() => _TopSongPageState();
}

class _TopSongPageState extends State<TopSongPage> {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: height / 3.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: NetworkImage(widget.imageSource),
                        fit: BoxFit.fill,
                        scale: 0.5)
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // BlocBuilder<CategoryBloc, CategoryState>(
              //
              //   builder: (context, state) {
              //     return ListView.builder(
              //       itemCount: state.category.length,
              //       itemBuilder: ,
              //     );
              //   })
          ],
          ),
        ),
      )
    );
  }
}
