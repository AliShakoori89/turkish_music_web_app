import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/singer_model.dart';
import '../../helpers/widgets/custom_app_bar.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key, required this.artistDetail});

  final SingerDataModel artistDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Singer Page",
              singerName: artistDetail.name,
              haveMenuButton: false,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                    artistDetail.imageSource
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
