

class Network {
  String? baseUrl;
  String? baseStorageUrl;
  String? cacheMaxAge;
  String? cacheMaxStale;

  /// Users Services
  late String usersServiceUrl;
  late String refreshJwtUrl;
  late String refreshTokenUrl;
  String? currentUserUrl;
  late String signInUrl;
  late String signUpUrl;
  late String requestOtpUrl;
  late String me;
  late String updateUser;
  late String setUserRoles;

  /// Places Services
  late String placesServiceUrl;
  late String savePlaceUrl;
  late String updatePlaceUrl;
  late String findPlaceUrl;
  late String findPlacesByOwnerUrl;
  late String findPlaceByShortIdUrl;
  late String findEagerPlaceByShortIdUrl;
  late String findTablesByPlaceUrl;
  late String findByExampleUrl;
  late String saveTablesUrl;
  late String removeTablesUrl;
  late String createQrForTablesUrl;
  late String exportPdfQrForTablesUrl;
  late String exportPdfQrForPlaceUrl;
  late String fileRecordsUrl;
  late String createPdfUrl;
  late String createTakeaway;

  /// Menus Services
  late String menusServiceUrl;
  late String createMenuUrl;
  late String findAllUrl;
  late String findUrl;
  late String findAllCategoriesUrl;
  late String findDefaultCategoriesUrl;
  late String findAllMenuItemsUrl;
  late String saveMenuItemsUrl;
  late String saveAllCategories;
  late String removeMenuItemsUrl;
  late String removeCategoryUrl;

  /// Storage Services
  late String findAllClientConfigs;
  late String saveClientConfig;
  late String storeFile;
  late String storeImageFile;

  /// Statistics Services
  late String statisticsServiceUrl;
  late String getSummary;

  Network() {
    baseUrl = application.appParams['base_url'] ?? AppSettings.baseUrl;
    baseStorageUrl =
        application.appParams['storage_url'] ?? AppSettings.baseStorageUrl;
    cacheMaxAge = '31536000';
    cacheMaxStale = '0';

    /// Users Services
    usersServiceUrl = baseUrl! + 'users/';
    refreshJwtUrl = usersServiceUrl + 'refresh';
    refreshTokenUrl = usersServiceUrl + 'refresh-token';
    currentUserUrl = usersServiceUrl + 'me';
    signInUrl = usersServiceUrl + 'signin';
    signUpUrl = usersServiceUrl + 'signup';
    requestOtpUrl = usersServiceUrl + 'request-otp';
    me = usersServiceUrl + 'me';
    updateUser = usersServiceUrl + 'update';
    setUserRoles = usersServiceUrl + 'set-roles';

    /// Places Services
    placesServiceUrl = baseUrl! + 'places/';
    savePlaceUrl = placesServiceUrl + 'save';
    updatePlaceUrl = placesServiceUrl + 'update';
    findPlaceUrl = placesServiceUrl + 'find';
    findPlacesByOwnerUrl = placesServiceUrl + 'find-by-owner';
    findPlaceByShortIdUrl = placesServiceUrl + 'find-by-short-id';
    findEagerPlaceByShortIdUrl = placesServiceUrl + 'find-eager-by-short-id';
    findTablesByPlaceUrl = placesServiceUrl + 'find-tables-by-place';
    saveTablesUrl = placesServiceUrl + 'save-tables';
    removeTablesUrl = placesServiceUrl + 'remove-tables';
    createQrForTablesUrl = placesServiceUrl + 'create-qr-for-tables';
    exportPdfQrForTablesUrl = placesServiceUrl + 'export-pdf-qr-for-tables';
    exportPdfQrForPlaceUrl = placesServiceUrl + 'export-pdf-qr-for-place';
    findByExampleUrl = placesServiceUrl + 'find-by-example';
    createTakeaway = placesServiceUrl + 'create-takeaway';
    fileRecordsUrl = placesServiceUrl + 'file-records/';
    createPdfUrl = fileRecordsUrl + 'create-pdf';

    /// Menus Services
    menusServiceUrl = baseUrl! + 'menus/';
    findAllCategoriesUrl = menusServiceUrl + 'find-all-categories';
    findUrl = menusServiceUrl + 'find';
    findAllUrl = menusServiceUrl + 'find-all';
    findDefaultCategoriesUrl = menusServiceUrl + 'find-default-categories';
    findAllMenuItemsUrl = menusServiceUrl + 'find-all-menu-items';
    createMenuUrl = menusServiceUrl + 'create';
    saveMenuItemsUrl = menusServiceUrl + 'save-menu-items';
    saveAllCategories = menusServiceUrl + 'save-all-categories';
    removeMenuItemsUrl = menusServiceUrl + 'remove-menu-items';
    removeCategoryUrl = menusServiceUrl + 'remove-category';

    /// Storage Services
    findAllClientConfigs = baseUrl! + 'find-all-client-configs';
    saveClientConfig = baseUrl! + 'save-client-config';
    storeFile = baseUrl! + 'store';
    storeImageFile = baseUrl! + 'store-image';

    /// Statistics Services
    statisticsServiceUrl = baseUrl! + 'statistics/';
    getSummary = statisticsServiceUrl + 'get-summary';
  }
}
