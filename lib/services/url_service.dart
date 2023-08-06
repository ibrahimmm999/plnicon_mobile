class UrlService {
  // String baseUrl = 'http://10.0.2.2/backend-plnicon/public/api/';
  String baseUrl =
      "https://5192-2001-448a-3051-113b-e497-e925-396f-b01a.ngrok-free.app/backend-plnicon/public/api/";
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
