import 'dart:convert';
import '../../data/model/new_album_model.dart';
import '../../data/network/api_base_helper.dart';

class AlbumRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getNewAlbum() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Album/GetNewAlbums');
    final productJson = json.decode(response.body);
    var newDongData = NewAlbumModel.fromJson(productJson);

    return newDongData.data;
  }
}