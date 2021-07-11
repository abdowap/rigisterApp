part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitProfileList extends ProfileEvent {}

class NameChanged extends ProfileEvent {
  final String name;

  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];
}
class AgeChanged extends ProfileEvent {
  final int age;

  const AgeChanged({required this.age});

  @override
  List<Object> get props => [age];
}
class NoteChanged extends ProfileEvent {
  final String note;

  const NoteChanged({required this.note});

  @override
  List<Object> get props => [note];
}

class ProfileFormSubmitted extends ProfileEvent {}

class LoadProfileByIdForEdit extends ProfileEvent {
  final int? id;

  const LoadProfileByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteProfileById extends ProfileEvent {
  final int? id;

  const DeleteProfileById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadProfileByIdForView extends ProfileEvent {
  final int? id;

  const LoadProfileByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
