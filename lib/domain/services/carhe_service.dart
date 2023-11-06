import 'package:financial_assistant/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  CacheService._();
  static final _instance = CacheService._();
  static CacheService get instance => _instance;
  SharedPreferences? _sharedPreferences;
  
  Future<void> initialise() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future<T?> read<T>(TypeStoreKey<T> typedStoreKey) async => (_sharedPreferences?.get(typedStoreKey.key) as T?)
      ?? typedStoreKey.defaultValue;

  Future<bool> contains(TypeStoreKey typedStoreKey) async =>  _sharedPreferences!.containsKey(typedStoreKey.key);

  Future<void> write<T>(TypeStoreKey<T> typedStoreKey, T? value) async {
    if (value == null) {
      await _sharedPreferences?.remove(typedStoreKey.key);

      return;
    }
    switch (T) {
      case int:
        await _sharedPreferences?.setInt(typedStoreKey.key, value as int);
        break;
      case String:
        await _sharedPreferences?.setString(typedStoreKey.key, value as String);
        break;
      case double:
        await _sharedPreferences?.setDouble(typedStoreKey.key, value as double);
        break;
      case bool:
        await _sharedPreferences?.setBool(typedStoreKey.key, value as bool);
        break;
      case List:
        await _sharedPreferences?.setStringList(typedStoreKey.key, value as List<String>);
        break;
    }
  }  

  Future<void> clearCache() async{
    await _sharedPreferences?.clear();
  }
}
