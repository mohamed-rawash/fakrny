import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {

  GetStorage _box = GetStorage();
  String _key = 'isDarkmode';

  ThemeMode get theme => loadThemeFromBox()? ThemeMode.dark: ThemeMode.light;

  _saveThemeToBox(bool isDarkmode){
    _box.write(_key, isDarkmode);
  }

  bool loadThemeFromBox(){
    return _box.read<bool>(_key)?? false;
  }

  switchThemeMode(){
    Get.changeThemeMode(loadThemeFromBox()? ThemeMode.light: ThemeMode.dark);
    _saveThemeToBox(!loadThemeFromBox());
  }

}
