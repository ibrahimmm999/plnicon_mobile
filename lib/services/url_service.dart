class UrlService {
  String baseUrl =
      'https://68f5-2001-448a-50e2-311b-b095-fe8f-6f6c-f234.ngrok-free.app/backend-plnicon/public/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
