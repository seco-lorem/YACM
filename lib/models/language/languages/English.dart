import '../language.dart';

class English extends Language {
  @override
  String get loginPageDontHaveAccount => "Don't have an account? ";

  @override
  String get loginPageForgotPassword => "Forgot Password?";

  @override
  String get loginPageLogin => "Sign In";

  @override
  String get loginPageRememberMe => "Remember Me";

  @override
  String get loginPageSignUp => "Sign Up";

  @override
  String get loginPagePassword => "Password";

  @override
  String get loginPageMail => "Bilkent Mail";

  @override
  String get signUpBack => "Back";

  @override
  String get signUpFinish => "Finish";

  @override
  String get signUpNext => "Next";

  @override
  String get signUpWelcomer => "Welcome to ";
}
