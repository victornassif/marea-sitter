class AppRoutes {
  static const VERSION_LIST = '/version-list';
  static const VERSION_FORM = '/version-form';
  static const BEHAVIOR_FORM = '/behavior-form';
  static const BEHAVIOR_LIST = '/behavior-list';
  static const FACTORY_FORM = '/factory-form';
  static const DISPATCH_FORM = '/dispatch-form';
  static const FACTORY_LIST = '/factory-list';
  static const FACTORY_CAROUSEL = '/';

  List<KeyValueRoute> listRoutes;

  List<KeyValueRoute> getAll() {
    listRoutes = List<KeyValueRoute>();
    listRoutes.add(KeyValueRoute(route: '/', name: 'fabricação'));
    listRoutes.add(KeyValueRoute(route: '/version-list', name: 'versões'));
    listRoutes.add(KeyValueRoute(route: '/behavior-list', name: 'comportamentos'));
    return listRoutes;
  }
}

class KeyValueRoute {
  String name;
  String route;

  KeyValueRoute({this.name, this.route});
}
