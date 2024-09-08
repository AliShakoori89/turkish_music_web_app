import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../bloc/song_control_bloc/audio_control_bloc.dart';
import '../../../const/no_image.dart';

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
    return StreamBuilder(
        stream: BlocProvider.of<AudioControlBloc>(context).positionStream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final currentDurationSecond = (snapshot.data?.inSeconds ?? 0);
            final currentDurationMinute = (snapshot.data?.inMinutes ?? 0).toString().padLeft(2 , "0");
            return Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      baseColor: Colors.black12,
                                      highlightColor: Colors.grey[400]!,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.black12,
                                              shape: BoxShape.circle),
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.width * 0.2
                                      ),
                                    ),
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width / 10
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Row(
                          children: [
                            Text(currentDurationMinute,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height / 60
                              ),),
                            Text(":",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height / 60
                                )),
                            Text((currentDurationSecond % 60).toString().padLeft(2 , "0"),
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height / 60
                                )),
                          ],
                        ), Row(
                          children: [
                            Text("${widget.minute}".padLeft(2 , "0"),
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height / 60
                                )),
                            Text(":",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height / 60
                                )),
                            Text("${widget.second}".padLeft(2 , "0"),
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height / 60
                                )),
                          ],
                        )],
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
