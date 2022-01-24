import 'package:get/get.dart';


// store and change current language
class LangViewModel extends GetxController {

  String lang = 'en';

  changLang(String lan) {
    lang = lan;
    update();
  }
}
