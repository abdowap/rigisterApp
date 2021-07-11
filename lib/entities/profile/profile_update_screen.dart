import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curdapp/entities/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:curdapp/shared/repository/http_utils.dart';
import 'package:curdapp/entities/profile/profile_model.dart';
import 'profile_route.dart';

class ProfileUpdateScreen extends StatelessWidget {
  ProfileUpdateScreen({Key? key}) : super(key: ProfileRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, ProfileRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Profiles':
'Create Profiles';
                 return Text(title);
                }
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[settingsForm(context)]),
          ),
      ),
    );
  }

  Widget settingsForm(BuildContext context) {
    return Form(
      child: Wrap(runSpacing: 15, children: <Widget>[
          nameField(),
          ageField(),
          noteField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget nameField() {
        return BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) => previous.name != current.name,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProfileBloc>().nameController,
                  onChanged: (value) { context.read<ProfileBloc>()
                    .add(NameChanged(name:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'name'));
            }
        );
      }
      Widget ageField() {
        return BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) => previous.age != current.age,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProfileBloc>().ageController,
                  onChanged: (value) { context.read<ProfileBloc>()
                    .add(AgeChanged(age:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'age'));
            }
        );
      }
      Widget noteField() {
        return BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) => previous.note != current.note,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProfileBloc>().noteController,
                  onChanged: (value) { context.read<ProfileBloc>()
                    .add(NoteChanged(note:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'note'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(ProfileState state, BuildContext context) {
    String notificationTranslated = '';
    Color? notificationColors;

    if (state.generalNotificationKey.toString().compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong when calling the server, please try again';
      notificationColors = Theme.of(context).errorColor;
    } else if (state.generalNotificationKey.toString().compareTo(HttpUtils.badRequestServerKey) == 0) {
      notificationTranslated ='Something wrong happened with the received data';
      notificationColors = Theme.of(context).errorColor;
    }

    return Text(
      notificationTranslated,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
          color: notificationColors),
    );
  }

  submit(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          String buttonLabel = state.editMode == true ?
'Edit':
'Create';
          return RaisedButton(
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Visibility(
                    replacement: CircularProgressIndicator(value: null),
                    visible: !state.formStatus.isSubmissionInProgress,
                    child: Text(buttonLabel),
                  ),
                )),
            onPressed: state.formStatus.isValidated ? () => context.bloc<ProfileBloc>().add(ProfileFormSubmitted()) : null,
          );
        }
    );
  }
}
