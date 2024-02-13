import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

import '../../../helpers/custom_app_bar.dart';

class MusicItem implements Comparable<MusicItem> {

  final String trackName, singerName;

  const MusicItem(this.trackName, this.singerName);

  @override
  int compareTo(MusicItem other) => trackName.compareTo(other.trackName);
}

class ItemSearchPage extends StatelessWidget {

  static const music = [
    MusicItem('Yine Sensiz', 'Tarkan'),
    MusicItem('Bu da Yeter', 'Mahsun'),
    MusicItem('Dön desem', 'Özcan Deniz'),
    MusicItem('Surpriz', 'Gülben Ergen'),
    MusicItem('Sevdim de Sevilmedim', 'Ibrahim Tatlıses'),
  ];

  const ItemSearchPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Expanded(
              flex: 1,
              child: Text('Search Page',
                style: TextStyle(
                  fontSize: 14,
                ),),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: music.length,
                itemBuilder: (context, index) {
                  final musicItem = music[index];
        
                  return ListTile(
                    title: Text(musicItem.trackName),
                    subtitle: Text(musicItem.singerName),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search people',
        backgroundColor: Colors.grey.withOpacity(0.2),
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage(
            onQueryUpdate: print,
            items: music,
            searchLabel: 'Search people',
            suggestion: const Center(
              child: Text('Filter track by track name or singer'),
            ),
            failure: const Center(
              child: Text('No person found :('),
            ),
            filter: (musicItem) => [
              musicItem.trackName,
              musicItem.singerName,
            ],
            sort: (a, b) => a.compareTo(b),
            builder: (musicItem) => ListTile(
              title: Text(musicItem.trackName),
              subtitle: Text(musicItem.singerName),
            ),
          ),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }
}

