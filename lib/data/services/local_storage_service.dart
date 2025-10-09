import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final _storage = GetStorage();

  static const String isFirstTimeKey = 'IsFirstTime';

  Future<void> init() async {
    await GetStorage.init();
  }

  bool? readBool(String key) => _storage.read(key);

  void writeBool(String key, bool value) => _storage.write(key, value);

  bool getIsFirstTime() {
    return _storage.read(isFirstTimeKey) ?? true;
  }

  void setIsFirstTime(bool value) {
    _storage.write(isFirstTimeKey, value);
  }
}
