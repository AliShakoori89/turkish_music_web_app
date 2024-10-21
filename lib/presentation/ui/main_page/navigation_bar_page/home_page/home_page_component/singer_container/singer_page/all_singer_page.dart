import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../../../../../data/model/singer_model.dart';
import 'singer_page.dart';

class AllSingerPage extends StatefulWidget {

  static String routeName = "AllSingerPage";

  @override
  State<AllSingerPage> createState() => _AllSingerPageState();
}

class _AllSingerPageState extends State<AllSingerPage>{

  final alphabets = List.generate(26, (index) => String.fromCharCode(index + 65));
  int _searchIndex = 0;
  String selectedAlphabet = '';
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  void setSearchIndex(String searchLetter) {
    setState(() {
      final Map<String, dynamic> data = GoRouterState.of(context).extra as Map<String, dynamic>;
      List<SingerDataModel> allSinger = data['allSinger'] as List<SingerDataModel>;
      _searchIndex = allSinger.indexWhere((element) => element.name[0] == searchLetter);
      if (_searchIndex > 0) _itemScrollController.jumpTo(index: _searchIndex);
      selectedAlphabet = searchLetter;
    });
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> data = GoRouterState.of(context).extra as Map<String, dynamic>;
      List<String> allSingerName = data['allSingerName'] as List<String>;
      allSingerName.sort((a, b) => a.toUpperCase().compareTo(b.toUpperCase()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> data = GoRouterState.of(context).extra as Map<String, dynamic>;
    List<SingerDataModel> allSinger = data['allSinger'] as List<SingerDataModel>;


    return Scaffold(
      appBar: AppBar(
        title: const Text('All Singer'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ScrollablePositionedList.builder(
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionsListener,
                itemCount: allSinger.length,
                minCacheExtent: 2000,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    context.push("/"+SingerPage.routeName, // The path defined in GoRouter
                        extra: allSinger[index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: allSinger[index].imageSource,
                              imageBuilder: (context, imageProvider) => Container(
                                height: MediaQuery.of(context).size.width / 8,
                                width: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(allSinger[index].imageSource),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              allSinger[index].name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 8
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: alphabets
                    .map((alphabet) => InkWell(
                  onTap: () {
                    print(alphabet);
                    setSearchIndex(alphabet);
                  },
                  child: Text(
                    alphabet,
                    style: TextStyle(
                      fontSize: selectedAlphabet  == alphabet ? 30 : 20,
                      color: selectedAlphabet  == alphabet ? Colors.purple : Colors.white,),
                  ),
                ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}