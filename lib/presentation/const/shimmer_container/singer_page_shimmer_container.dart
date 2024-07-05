import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:shimmer/shimmer.dart';

class SingerPageShimmerContainer extends StatelessWidget {
  const SingerPageShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4.2,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
              ),
              child: Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Colors.grey[400]!,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5.0)),
                  )
              ),
              margin: EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 40,
                  bottom: 10
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: AnimatedGridView(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisExtent: MediaQuery.of(context).size.width / 3,
                    crossAxisSpacing: MediaQuery.of(context).size.width / 9,
                    children: List.generate(
                        8,
                            (index) =>
                            Shimmer.fromColors(
                                baseColor: Colors.black12,
                                highlightColor: Colors.grey[400]!,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(5.0)),
                                )
                            )))
            ),
          ],
        ),
      ),
    );
  }
}
