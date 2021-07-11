import 'package:formz/formz.dart';
import 'package:curdapp/entities/profile/profile_model.dart';

enum NameValidationError { invalid }
class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    return null;
  }
}

enum AgeValidationError { invalid }
class AgeInput extends FormzInput<int, AgeValidationError> {
  const AgeInput.pure() : super.pure(0);
  const AgeInput.dirty([int value = 0]) : super.dirty(value);

  @override
  AgeValidationError? validator(int value) {
    return null;
  }
}

enum NoteValidationError { invalid }
class NoteInput extends FormzInput<String, NoteValidationError> {
  const NoteInput.pure() : super.pure('');
  const NoteInput.dirty([String value = '']) : super.dirty(value);

  @override
  NoteValidationError? validator(String value) {
    return null;
  }
}

