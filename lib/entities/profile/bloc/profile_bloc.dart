import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:curdapp/entities/profile/profile_model.dart';
import 'package:curdapp/entities/profile/profile_repository.dart';
import 'package:curdapp/entities/profile/bloc/profile_form_model.dart';
import 'package:curdapp/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'profile_events.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final noteController = TextEditingController();

  ProfileBloc({required ProfileRepository profileRepository}) :
        _profileRepository = profileRepository,
  super(ProfileState());

  @override
  void onTransition(Transition<ProfileEvent, ProfileState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is InitProfileList) {
      yield* onInitList(event);
    } else if (event is ProfileFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadProfileByIdForEdit) {
      yield* onLoadProfileIdForEdit(event);
    } else if (event is DeleteProfileById) {
      yield* onDeleteProfileId(event);
    } else if (event is LoadProfileByIdForView) {
      yield* onLoadProfileIdForView(event);
    }else if (event is NameChanged){
      yield* onNameChange(event);
    }else if (event is AgeChanged){
      yield* onAgeChange(event);
    }else if (event is NoteChanged){
      yield* onNoteChange(event);
    }  }

  Stream<ProfileState> onInitList(InitProfileList event) async* {
    yield this.state.copyWith(profileStatusUI: ProfileStatusUI.loading);
    List<Profile> profiles = await _profileRepository.getAllProfiles();
    yield this.state.copyWith(profiles: profiles, profileStatusUI: ProfileStatusUI.done);
  }

  Stream<ProfileState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Profile? result;
        if(this.state.editMode) {
          Profile newProfile = Profile(state.loadedProfile.id,
            this.state.name.value,
            this.state.age.value,
            this.state.note.value,
          );

          result = await _profileRepository.update(newProfile);
        } else {
          Profile newProfile = Profile(null,
            this.state.name.value,
            this.state.age.value,
            this.state.note.value,
          );

          result = await _profileRepository.create(newProfile);
        }

        if (result == null) {
          yield this.state.copyWith(formStatus: FormzStatus.submissionFailure,
              generalNotificationKey: HttpUtils.badRequestServerKey);
        } else {
          yield this.state.copyWith(formStatus: FormzStatus.submissionSuccess,
              generalNotificationKey: HttpUtils.successResult);
        }
      } catch (e) {
        yield this.state.copyWith(formStatus: FormzStatus.submissionFailure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<ProfileState> onLoadProfileIdForEdit(LoadProfileByIdForEdit? event) async* {
    yield this.state.copyWith(profileStatusUI: ProfileStatusUI.loading);
    Profile loadedProfile = await _profileRepository.getProfile(event?.id);

    final name = NameInput.dirty((loadedProfile.name != null ? loadedProfile.name: '')!);
    final age = AgeInput.dirty((loadedProfile.age != null ? loadedProfile.age: 0)!);
    final note = NoteInput.dirty((loadedProfile.note != null ? loadedProfile.note: '')!);

    yield this.state.copyWith(loadedProfile: loadedProfile, editMode: true,
      name: name,
      age: age,
      note: note,
    profileStatusUI: ProfileStatusUI.done);

    nameController.text = loadedProfile.name!;
    ageController.text = loadedProfile.age!.toString();
    noteController.text = loadedProfile.note!;
  }

  Stream<ProfileState> onDeleteProfileId(DeleteProfileById event) async* {
    try {
      await _profileRepository.delete(event.id!);
      this.add(InitProfileList());
      yield this.state.copyWith(deleteStatus: ProfileDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ProfileDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ProfileDeleteStatus.none);
  }

  Stream<ProfileState> onLoadProfileIdForView(LoadProfileByIdForView event) async* {
    yield this.state.copyWith(profileStatusUI: ProfileStatusUI.loading);
    try {
      Profile loadedProfile = await _profileRepository.getProfile(event.id);
      yield this.state.copyWith(loadedProfile: loadedProfile, profileStatusUI: ProfileStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedProfile: null, profileStatusUI: ProfileStatusUI.error);
    }
  }


  Stream<ProfileState> onNameChange(NameChanged event) async* {
    final name = NameInput.dirty(event.name);
    yield this.state.copyWith(
      name: name,
      formStatus: Formz.validate([
        name,
      this.state.age,
      this.state.note,
      ]),
    );
  }
  Stream<ProfileState> onAgeChange(AgeChanged event) async* {
    final age = AgeInput.dirty(event.age);
    yield this.state.copyWith(
      age: age,
      formStatus: Formz.validate([
      this.state.name,
        age,
      this.state.note,
      ]),
    );
  }
  Stream<ProfileState> onNoteChange(NoteChanged event) async* {
    final note = NoteInput.dirty(event.note);
    yield this.state.copyWith(
      note: note,
      formStatus: Formz.validate([
      this.state.name,
      this.state.age,
        note,
      ]),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    ageController.dispose();
    noteController.dispose();
    return super.close();
  }

}
