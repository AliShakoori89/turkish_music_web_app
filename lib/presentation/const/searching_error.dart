import 'package:flutter/material.dart';

class SearchingError extends StatelessWidget {
  const SearchingError({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.search),
        Text("Searching Error")
      ],
    );;
  }
}
