enum UrlLink { isLive, isDev, isLocalServer }

enum ApiUrl { base, baseImage, products, login, me }

extension ApiUrlExtention on ApiUrl {
  static String _baseUrl = '';
  static String _baseImageUrl = '';

  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = '';
        _baseImageUrl = '';

        break;

      case UrlLink.isDev:
        _baseUrl = 'https://dummyjson.com/';
        _baseImageUrl = '';

        break;
      case UrlLink.isLocalServer:
        // set up your local server ip address.
        _baseUrl = '';
        break;
    }
  }

  String get url {
    switch (this) {
      case ApiUrl.base:
        return _baseUrl;
      case ApiUrl.baseImage:
        return _baseImageUrl;
      case ApiUrl.products:
        return 'products';
      case ApiUrl.login:
        return 'auth/login';
      case ApiUrl.me:
        return 'auth/me';
    }
  }
}
