class UrlService {
  // String baseUrl = 'http://10.0.2.2/backend-plnicon/public/api/';
  String baseUrl =
      'https://4277-2001-448a-3051-113b-4819-87d2-585a-d79b.ngrok-free.app/backend-plnicon/public/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
