abstract class BaseApiService {

  final String baseUrl = "https://mocki.io/v1/";

  Future<dynamic> getResponse(String url);

}