import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../data/model/singer_model.dart';

class AllSingerPage extends StatefulWidget {
  const AllSingerPage({super.key, required this.allSinger});

  final List<SingerDataModel> allSinger;


  @override
  State<AllSingerPage> createState() => _AllSingerPageState();
}

class _AllSingerPageState extends State<AllSingerPage> {

  final alphabets =
  List.generate(26, (index) => String.fromCharCode(index + 65));
  int _searchIndex = 0;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
  ItemPositionsListener.create();

  void setSearchIndex(String searchLetter) {
    setState(() {
      _searchIndex = widget.allSinger.indexWhere((element) => element[0] == searchLetter);
      if (_searchIndex > 0) _itemScrollController.jumpTo(index: _searchIndex);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.allSinger.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ScrollablePositionedList.builder(
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionsListener,
                itemCount: widget.allSinger.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.allSinger[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.allSinger[index][0],
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                )),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: alphabets
                  .map((alphabet) => InkWell(
                onTap: () {
                  setSearchIndex(alphabet);
                },
                child: Text(
                  alphabet,
                  style: const TextStyle(fontSize: 16),
                ),
              ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}