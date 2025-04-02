// Utils/Validation/Validation.dart
class Validation {
  // Email
  static String ValidationEmail(String email) {
    if (email.isEmpty) {
      return "يرجى إدخال البريد الإلكتروني";
    } else if (email.length <= 3) {
      return "يجب أن يكون البريد الإلكتروني أكثر من 3 أحرف";
    } else if (!email.contains('@')) {
      return "يجب أن يحتوي البريد الإلكتروني على الرمز @";
    } else {
      return "";
    }
  }

  static String ValidationPassword(password) {
    if (password.isEmpty) {
      return "يرجى إدخال كلمة المرور";
    } else if (password.length <= 7) {
      return "يجب أن تكون كلمة المرور أكثر من 7 أحرف";
    } else {
      return "";
    }
  }

  static String ValidationText(name) {
    if (name.isEmpty) {
      return "مطلوب";
    } else if (name.length <= 4) {
      return "يجب أن الحقل أكثر من 4 أحرف";
    } else {
      return "";
    }
  }
  static String ValidationNumber(name) {
    if (name.isEmpty) {
      return "مطلوب";
    } else if (name.length < 9) {
      return "يجب أن الحقل أكثر من 9 أحرف";
    } else {
      return "";
    }
  }
}
