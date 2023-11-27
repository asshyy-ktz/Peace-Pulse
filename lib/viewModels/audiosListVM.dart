import 'package:flutter/material.dart';
import 'package:peace_pulse/data/remote/response/ApiResponse.dart';
import 'package:peace_pulse/models/AudioModel.dart';
import 'package:peace_pulse/repository/audios/MovieRepoImp.dart';

class AudiosListVM extends ChangeNotifier {
  final _myRepo = AudiosRepoImp();

  ApiResponse<List<MyAudio>?> audiosMain = ApiResponse.loading();

  void _setAudioMain(ApiResponse<List<MyAudio>?> response) {
    print("MARAJ :: $response");
    audiosMain = response;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    _setAudioMain(ApiResponse.loading());
    _myRepo
        .getAudiosList()
        .then((value) => _setAudioMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setAudioMain(ApiResponse.error(error.toString())));
  }
}
