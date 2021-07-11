part of 'profile_bloc.dart';

enum ProfileStatusUI { init, loading, error, done }
enum ProfileDeleteStatus { ok, ko, none }

class ProfileState extends Equatable {
  final List<Profile> profiles;
  final Profile loadedProfile;
  final bool editMode;
  final ProfileDeleteStatus deleteStatus;
  final ProfileStatusUI profileStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final NameInput name;
  final AgeInput age;
  final NoteInput note;

  ProfileState({
    this.profiles = const [],
    this.profileStatusUI = ProfileStatusUI.init,
    this.loadedProfile = const Profile(
      0,
      '',
      0,
      '',
    ),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = ProfileDeleteStatus.none,
    this.name = const NameInput.pure(),
    this.age = const AgeInput.pure(),
    this.note = const NoteInput.pure(),
  });

  ProfileState copyWith({
    List<Profile>? profiles,
    ProfileStatusUI? profileStatusUI,
    bool? editMode,
    ProfileDeleteStatus? deleteStatus,
    Profile? loadedProfile,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    NameInput? name,
    AgeInput? age,
    NoteInput? note,
  }) {
    return ProfileState(
      profiles: profiles ?? this.profiles,
      profileStatusUI: profileStatusUI ?? this.profileStatusUI,
      loadedProfile: loadedProfile ?? this.loadedProfile,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey:
          generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      name: name ?? this.name,
      age: age ?? this.age,
      note: note ?? this.note,
    );
  }

  @override
  List<Object> get props => [
        profiles,
        profileStatusUI,
        loadedProfile,
        editMode,
        deleteStatus,
        formStatus,
        generalNotificationKey,
        name,
        age,
        note,
      ];

  @override
  bool get stringify => true;
}
