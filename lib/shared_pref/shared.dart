import 'package:answer_login/modle/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum PreKey{loggedIn,id,name ,email,language}
class SharedPrefController{

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  SharedPrefController._();
  factory SharedPrefController(){
    return _instance ??=SharedPrefController._();
  }
  Future<void> initPreferences() async {
  _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future<void> sava ({required User user })async{
    await _sharedPreferences.setBool(PreKey.loggedIn.name, true);
    await _sharedPreferences.setInt(PreKey.id.name, user.id);
    await _sharedPreferences.setString(PreKey.name.name, user.name);
    await _sharedPreferences.setString(PreKey.email.name, user.email);
   }
  void setLanguage (String language) {
    _sharedPreferences.setString(PreKey.language.name,language);}
  bool get loggedIn => _sharedPreferences.getBool(PreKey.loggedIn.name) ?? false ;
  Future<bool> removeKey ({required String Key})async{
    if(_sharedPreferences.containsKey(Key)){
     await _sharedPreferences.remove(Key);
    }
    return false;
  }
   T? getValueFor<T> ({required String Key}){
    if(_sharedPreferences.containsKey(Key)) {
      return _sharedPreferences.get(Key) as T;
    }
    return null ;
   }
   Future<bool> clear(){
    return _sharedPreferences.clear();
   }

}
