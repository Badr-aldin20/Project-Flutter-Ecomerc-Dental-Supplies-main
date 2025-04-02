// Utils/Check internet.dart
import 'dart:io';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (E) {
    return true;
  }
}
