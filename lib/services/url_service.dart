class UrlService {
  String baseUrl = 'http://10.0.2.2/backend-plnicon/public/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
