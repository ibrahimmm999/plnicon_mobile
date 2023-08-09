class UrlService {
  // String baseUrl = 'http://10.0.2.2/backend-plnicon/public/api/';
  String baseUrl =
      "https://3d01-2001-448a-50e0-180-9466-5a09-a388-f492.ngrok-free.app/backend-plnicon/public/api/";
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
