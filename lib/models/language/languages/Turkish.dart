import '../language.dart';

class Turkish extends Language {
  @override
  String get loginPageDontHaveAccount => "Hesabın yok mu? ";

  @override
  String get loginPageForgotPassword => "Şifremi unuttum?";

  @override
  String get loginPageLogin => "Giriş Yap";

  @override
  String get loginPageRememberMe => "Beni Hatırla";

  @override
  String get loginPageSignUp => "Kaydol";

  @override
  String get loginPagePassword => "Şifre";

  @override
  String get loginPageMail => "Bilkent Mail";

  @override
  String get signUpBack => "Geri";

  @override
  String get signUpFinish => "Bitir";

  @override
  String get signUpNext => "Sonraki";

  @override
  String get signUpWelcomer => "Welcome to";
}
