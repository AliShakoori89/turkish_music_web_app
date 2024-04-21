import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/audio_control/bloc/audio_control_bloc.dart';

class SongSlider extends StatefulWidget {

  final AudioPlayer audioPlayer;
  final String songFile;
  const SongSlider({super.key, required this.audioPlayer, required this.songFile});

  @override
  State<SongSlider> createState() => _SongSliderState();
}

class _SongSliderState extends State<SongSlider> {

  double songSecond = 0;
  int songEndMinute = 0 ;
  String songEndSecond = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<AudioControlBloc>(context).positionStream,
        builder: ((context, snapshot) {

          widget.audioPlayer.setSourceUrl(widget.songFile);

          widget.audioPlayer.onDurationChanged.listen((Duration d) {
            songSecond = double.parse(d.inSeconds.toString());
            songEndMinute = d.inSeconds~/ 60;
            songEndSecond = ((d.inSeconds) % 60).toString().padLeft(2, '0');
          });

          if (snapshot.hasData) {
            Duration? duration = snapshot.data;

            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text((duration!.inMinutes ).toString().padLeft(2, '0')),
                            const Text(":"),
                            Text((calculateSecondTimer(duration)).toString().padLeft(2, '0'))
                          ],
                        ),
                        Row(
                          children: [
                            Text(songEndMinute.toString()),
                            const Text(":"),
                            Text(songEndSecond)
                          ],
                        )
                      ],
                    )),
                SliderTheme(
                  data: SliderTheme.of(context)
                      .copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Slider(
                        activeColor: Colors.purple,
                        inactiveColor: Colors.black,
                        value: (snapshot.data?.inSeconds)?.toDouble() ?? 0,
                        max: songSecond,
                        min: 0,
                        // activeColor: Theme.of(context).colorScheme.background,
                        onChangeEnd: (value) {},
                        onChanged: (val) {
                          BlocProvider.of<AudioControlBloc>(context).seekTo(Duration(seconds: val.toInt()));
                        }),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }

  int calculateSecondTimer(Duration duration){
    int secondTime = 0;
    if(duration.inSeconds < 60){
      secondTime = duration.inSeconds;
    }else if(duration.inSeconds < 120){
      secondTime = duration.inSeconds-60;
    }else if(duration.inSeconds < 180){
      secondTime = duration.inSeconds-120;
    }else if(duration.inSeconds < 240){
      secondTime = duration.inSeconds-180;
    }else if(duration.inSeconds < 300){
      secondTime = duration.inSeconds-240;
    }else if(duration.inSeconds < 360){
      secondTime = duration.inSeconds-300;
    }else if(duration.inSeconds < 420){
      secondTime = duration.inSeconds-360;
    }else if(duration.inSeconds < 480){
      secondTime = duration.inSeconds-420;
    }else if(duration.inSeconds < 540){
      secondTime = duration.inSeconds-480;
    }else if(duration.inSeconds < 600){
      secondTime = duration.inSeconds-540;
    }
    return secondTime;
  }
}
