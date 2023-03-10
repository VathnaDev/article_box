import 'package:shared_preferences/shared_preferences.dart';

// PrefUtils: A single class to manage all SharedPref keys-value
//
//

class PrefUtils {
  // Singleton Setup
  PrefUtils._();
  static PrefUtils? _instanec;
  static PrefUtils get instance => _instanec ??= PrefUtils._();

  // Instnaces
  late SharedPreferences _mPref;

  // Defined Keys
  final _keySample = "key_sample";

  // Must be called in app launch
  Future<void> initialize() async {
    _mPref = await SharedPreferences.getInstance();
  }

  String get sample => _mPref.getString(_keySample) ?? "";
  set sample(String x) => _mPref.setString(_keySample, x);
}
