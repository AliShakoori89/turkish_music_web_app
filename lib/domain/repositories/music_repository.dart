import 'package:turkish_music_app/data/model/music_model.dart';
import '../../data/network/api_base_helper.dart';

class MusicRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getMusic(int id) async {
    ApiBaseHelper api = ApiBaseHelper();
    final MusicModel response = await api.get('/api/Music/GetOneMusic/$id');
    return response.data;
  }
}