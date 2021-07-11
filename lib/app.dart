import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curdapp/account/login/bloc/login_bloc.dart';
import 'package:curdapp/account/login/login_repository.dart';
import 'package:curdapp/account/register/bloc/register_bloc.dart';
import 'package:curdapp/account/settings/settings_screen.dart';
import 'package:curdapp/main/bloc/main_bloc.dart';
import 'package:curdapp/routes.dart';
import 'package:curdapp/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:curdapp/shared/repository/account_repository.dart';
import 'package:curdapp/themes.dart';
import 'account/settings/bloc/settings_bloc.dart';

import 'account/login/login_screen.dart';
import 'account/register/register_screen.dart';


import 'entities/profile/profile_route.dart';
// jhipster-merlin-needle-import-add - JHipster will add new imports here

class CurdappApp extends StatelessWidget {
  const CurdappApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curdapp app',
      theme: Themes.jhLight,
      routes: {
        CurdappRoutes.login: (context) {
          return BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(loginRepository: LoginRepository()),
            child: LoginScreen());
        },
        CurdappRoutes.register: (context) {
          return BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(accountRepository: AccountRepository()),
            child: RegisterScreen());
        },
        CurdappRoutes.main: (context) {
          return BlocProvider<MainBloc>(
            create: (context) => MainBloc(accountRepository: AccountRepository())
              ..add(Init()),
            child: MainScreen());
        },
      CurdappRoutes.settings: (context) {
        return BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(accountRepository: AccountRepository())
            ..add(LoadCurrentUser()),
          child: SettingsScreen());
        },
        ...ProfileRoutes.map,
        // jhipster-merlin-needle-route-add - JHipster will add new routes here
      },
    );
  }
}
