class AppRoutes{
  static const HOME = '/';
  static const VERSION_FORM = '/version-form';
  static const BEHAVIOR_FORM = '/behavior-form';
  static const BEHAVIOR_LIST = '/behavior-list';

  List<String> getAll (){
    List<String> list = List<String>();
    list.add(HOME);
    list.add(BEHAVIOR_LIST);
    return list;
  } 
}