import 'package:turkish_music_app/data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class SongRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getMusic(int id) async {
    ApiBaseHelper api = ApiBaseHelper();
    final SongModel response = await api.get('/api/Music/GetOneMusic/$id');
    return response.data;
  }
}