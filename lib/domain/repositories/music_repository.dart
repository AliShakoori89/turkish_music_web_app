import 'dart:async';
import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../data/model/music_model.dart';
import '../../data/network/api_base_helper.dart';

class MusicRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getNewMusic() async {

    ApiBaseHelper api = ApiBaseHelper();

    final response =
    await api.get('/api/NewMusic/GetAll');
    final productJson = json.decode(response.body);

    return MusicModel.fromJson(productJson);
  }

  @override
  Future<dynamic> getFamousArtist() async {

    ApiBaseHelper api = ApiBaseHelper();
    List isBestArtist = [];

    print("22222222222222222222");

    final response =
    await api.get('/api/Singer/GetAll');

    final productJson = json.decode(response.body);

    print("33333333333333333333333");

    var artist = MusicModel.fromJson(productJson);

    print("4444444444444444444                "+artist.data!.length.toString());

    for(int i = 0 ; i < artist.data!.length -1 ; i++){
      print("5555555555555555555555555");
      print("6666666666666666666666666666666"+ artist.data![i].album!.singer.toString());
      if(artist.data![i].album!.singer!.isBest == true){
        print("77777777777777777777");
        print("888888888888888888888888             "+artist.data![i].album!.singer!.id.toString());
        isBestArtist.add(artist.data![i].album!.singer!.id);
      }else{
        print("false");
      }
    }

    print("8888888888888888888888888888");

    print(isBestArtist.toString());

    return Singer.fromJson(productJson);
  }
}