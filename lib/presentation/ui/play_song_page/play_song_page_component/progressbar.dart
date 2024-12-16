import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../bloc/song_control_bloc/audio_control_bloc.dart';
import '../../../const/no_image.dart';
import '../../../const/shimmer_container/playing_page_image_shimmer.dart';

class Progressbar extends StatefulWidget {
  const Progressbar({super.key, required this.minute, required this.second, required this.songImage});

  final String minute;
  final String second;
  final String songImage;

  @override
  State<Progressbar> createState() => _ProgressbarState();
}

class _ProgressbarState extends State<Progressbar> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      vsync: this, // vsync is set to this for performance reasons
      duration: Duration(seconds: 20), // Set the duration of the animation
    );

    // Create a Tween for the rotation angle
    _animation = Tween<double>(
      begin: 0, // Start rotation angle
      end: 2 * 3.141, // End rotation angle (2 * pi for a full circle)
    ).animate(_controller);

    // Repeat the animation indefinitely
    _controller.repeat();
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return StreamBuilder(
        stream: BlocProvider.of<AudioControlBloc>(context).positionStream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final currentDurationSecond = (snapshot.data?.inSeconds ?? 0);
            final currentDurationMinute = (snapshot.data?.inMinutes ?? 0).toString().padLeft(2 , "0");
            return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 450,
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(progressBarWidth: 10)),
                      min: 0,
                      max: double.parse(widget.minute ?? "0") * 60 + double.parse(widget.second ?? "0"),
                      initialValue: (snapshot.data?.inSeconds)?.toDouble() ?? 0,
                      onChange: (val) {
                        BlocProvider.of<AudioControlBloc>(context).seekTo(Duration(seconds: val.toInt()));
                      },
                      innerWidget: (double value) => Align(child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _animation.value,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.songImage,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    placeholder: (context, url) => PlayingPageImageShimmer(),
                                    errorWidget: (context, url, error) => NoImage(),
                                  ),
                                );
                              }
                          )
                      )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    // top: 300,
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(currentDurationMinute,
                                style: TextStyle(
                                    fontSize: orientation == Orientation.portrait
                                        ? MediaQuery.of(context).size.height / 60
                                        : MediaQuery.of(context).size.height / 50
                                ),),
                              Text(":",
                                  style: TextStyle(
                                      fontSize: orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.height / 60
                                          : MediaQuery.of(context).size.height / 50
                                  )),
                              Text((currentDurationSecond % 60).toString().padLeft(2 , "0"),
                                  style: TextStyle(
                                      fontSize: orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.height / 60
                                          : MediaQuery.of(context).size.height / 50
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text("${widget.minute}".padLeft(2 , "0"),
                                  style: TextStyle(
                                      fontSize: orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.height / 60
                                          : MediaQuery.of(context).size.height / 50
                                  )),
                              Text(":",
                                  style: TextStyle(
                                      fontSize: orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.height / 60
                                          : MediaQuery.of(context).size.height / 50
                                  )),
                              Text("${widget.second}".padLeft(2 , "0"),
                                  style: TextStyle(
                                      fontSize: orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.height / 60
                                          : MediaQuery.of(context).size.height / 50
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]);
          } else {
            return Container();
          }
        }));
  }
}
