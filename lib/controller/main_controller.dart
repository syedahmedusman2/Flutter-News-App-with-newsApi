import 'package:shared_preferences/shared_preferences.dart';

class Maincontroller {
  dynamic title;
  dynamic content;
  dynamic image;
  Maincontroller({
    required this.title, required this.content,required this.image
  });
}

class Logics {
  bool isSwitched = false;
  bool isSwitchedFT = false;

  getSwitchValues() async {
    isSwitchedFT = await getSwitchState();
    // etState(() {});s
  }
  

  Future<dynamic> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState", value);
  }

  Future<dynamic> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic isSwitchedFT = prefs.getBool("switchState");
    print(isSwitchedFT);

    return isSwitchedFT;
  }
}

