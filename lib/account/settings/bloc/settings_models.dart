import 'package:formz/formz.dart';

enum FirstnameValidationError { invalid }

extension FirstnameValidationErrorX on FirstnameValidationError {
String get invalidMessage =>'Firstname has to be ${FirstnameInput.numberMin} characters minimum';
}

class FirstnameInput extends FormzInput<String, FirstnameValidationError> {
  const FirstnameInput.pure() : super.pure('');
  const FirstnameInput.dirty([String value = '']) : super.dirty(value);

  static int numberMin = 3;

  @override
  FirstnameValidationError? validator(String value) {
    if(value.isEmpty == false){
      return value.length >= numberMin ? null : FirstnameValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum LastnameValidationError { invalid }

extension LastnameValidationErrorX on LastnameValidationError {
String get invalidMessage =>'Lastname has to be ${LastnameInput.numberMin} characters minimum';
}

class LastnameInput extends FormzInput<String, LastnameValidationError> {
  const LastnameInput.pure() : super.pure('');
  const LastnameInput.dirty([String value = '']) : super.dirty(value);

  static int numberMin = 3;

  @override
  LastnameValidationError? validator(String value) {
    if(value.isEmpty == false){
      return value.length >= numberMin ? null : LastnameValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum EmailValidationError { invalid }

extension EmailValidationErrorX on EmailValidationError {
  String get invalidMessage =>'Email format incorrect';
}

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.contains('@') ? null : EmailValidationError.invalid;
  }
}
