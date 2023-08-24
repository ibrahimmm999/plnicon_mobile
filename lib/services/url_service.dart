class UrlService {
  String baseUrl =
      'https://e52e-36-85-230-18.ngrok-free.app/backend-plnicon/public/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
