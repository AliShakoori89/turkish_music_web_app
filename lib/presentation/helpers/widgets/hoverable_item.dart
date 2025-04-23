import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';

class HoverableItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final BoxShape boxShape;
  final double size;

  const HoverableItem({super.key, required this.imageUrl, required this.name, required this.boxShape, required this.size});

  @override
  State<HoverableItem> createState() => _HoverableItemState();
}

class _HoverableItemState extends State<HoverableItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isHovered ? widget.size : widget.size - 10,
            height: isHovered ? widget.size : widget.size - 10,
            decoration: BoxDecoration(
              shape: widget.boxShape,
              border: Border.all(
                width: 2,
                color: isHovered ? Colors.purpleAccent : Colors.purple.withOpacity(0.5),
              ),
              boxShadow: isHovered
                  ? [BoxShadow(color: Colors.black26, blurRadius: 10)]
                  : [],
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        UnderImageSingerAndSongName(
          singerName: widget.name,
          isArtist: false,
        ),
      ],
    );
  }
}