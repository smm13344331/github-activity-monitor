class Network {

  static final Network _network = Network._internal();

  late final String cacheMaxAge;
  late final String cacheMaxStale;

  /// Github Services
  late final String githubBaseUrl;

  factory Network() {
    return _network;
  }

  Network._internal(){
    githubBaseUrl = 'https://api.github.com';
    cacheMaxAge = '31536000';
    cacheMaxStale = '0';
  }
}
