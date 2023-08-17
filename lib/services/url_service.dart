class UrlService {
  String baseUrl =
      'https://17c7-2001-448a-50e2-311b-90b2-dad6-b5f8-f380.ngrok-free.app/backend-plnicon/public/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
