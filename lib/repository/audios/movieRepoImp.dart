import 'package:peace_pulse/data/remote/network/ApiEndPoints.dart';
import 'package:peace_pulse/data/remote/network/BaseApiService.dart';
import 'package:peace_pulse/data/remote/network/NetworkApiService.dart';
import 'package:peace_pulse/models/AudioModel.dart';
import 'package:peace_pulse/repository/audios/audiosRepo.dart';

class AudiosRepoImp implements AudiosRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<List<MyAudio>?> getAudiosList() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().getAudios);
      print("MARAJ $response");
      final jsonData = AudiosMain.sampleFromJson(response as List);
      return jsonData;
    } catch (e) {
      print("MARAJ-E $e}");
      throw e;
    }
  }
}
