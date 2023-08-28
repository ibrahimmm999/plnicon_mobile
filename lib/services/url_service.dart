class UrlService {
  String baseUrl = 'https://jakban.iconpln.co.id/backend-plnicon/public/api/';
  Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
