import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/song_control_bloc/bloc/audio_control_bloc.dart';

class Progressbar extends StatelessWidget {
  const Progressbar({super.key, required this.minute, required this.second});

  final String minute;
  final String second;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<AudioControlBloc>(context).positionStream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final currentDurationSecond = (snapshot.data?.inSeconds ?? 0);
            final currentDurationMinute = (snapshot.data?.inMinutes ?? 0).toString().padLeft(2 , "0");
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Row(
                        children: [
                          Text(currentDurationMinute),
                          Text(":"),
                          Text((currentDurationSecond % 60).toString().padLeft(2 , "0")),
                        ],
                      ), Row(
                        children: [
                          Text("${minute}".padLeft(2 , "0")),
                          Text(":"),
                          Text("${second}".padLeft(2 , "0")),
                        ],
                      )],
                    )),
                SliderTheme(
                  data: SliderTheme.of(context)
                      .copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
                  child: Slider(
                      activeColor: Colors.purple,
                      inactiveColor: Colors.black,
                      value: (snapshot.data?.inSeconds)?.toDouble() ?? 0,
                      max: double.parse(minute ?? "0") * 60 + double.parse(second ?? "0"),
                      min: 0,
                      // activeColor: Theme.of(context).colorScheme.background,
                      onChangeEnd: (value) {},
                      onChanged: (val) {
                        BlocProvider.of<AudioControlBloc>(context).seekTo(Duration(seconds: val.toInt()));
                      }),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}
