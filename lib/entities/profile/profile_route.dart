
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curdapp/shared/models/entity_arguments.dart';

import 'bloc/profile_bloc.dart';
import 'profile_list_screen.dart';
import 'profile_repository.dart';
import 'profile_update_screen.dart';
import 'profile_view_screen.dart';

class ProfileRoutes {
  static final list = '/entities/profile-list';
  static final create = '/entities/profile-create';
  static final edit = '/entities/profile-edit';
  static final view = '/entities/profile-view';

  static const listScreenKey = Key('__profileListScreen__');
  static const createScreenKey = Key('__profileCreateScreen__');
  static const editScreenKey = Key('__profileEditScreen__');
  static const viewScreenKey = Key('__profileViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(profileRepository: ProfileRepository())
            ..add(InitProfileList()),
          child: ProfileListScreen());
    },
    create: (context) {
      return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(profileRepository: ProfileRepository()),
          child: ProfileUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(profileRepository: ProfileRepository())
            ..add(LoadProfileByIdForEdit(id: arguments.id)),
          child: ProfileUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(profileRepository: ProfileRepository())
            ..add(LoadProfileByIdForView(id: arguments.id)),
          child: ProfileViewScreen());
    },
  };
}
