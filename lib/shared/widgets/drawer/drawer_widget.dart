import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curdapp/routes.dart';
import 'package:curdapp/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:flutter/material.dart';

import 'package:curdapp/entities/profile/profile_route.dart';
// jhipster-merlin-needle-menu-import-entry-add

class CurdappDrawer extends StatelessWidget {
   CurdappDrawer({Key? key}) : super(key: key);

   static final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DrawerBloc, DrawerState>(
      listener: (context, state) {
        if(state.isLogout) {
          Navigator.popUntil(context, ModalRoute.withName(CurdappRoutes.login));
          Navigator.pushNamed(context, CurdappRoutes.login);
        }
      },
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            header(context),
            ListTile(
              leading: Icon(Icons.home, size: iconSize,),
              title: Text('Home'),
              onTap: () => Navigator.pushNamed(context, CurdappRoutes.main),
            ),
            ListTile(
              leading: Icon(Icons.settings, size: iconSize,),
              title: Text('Settings'),
              onTap: () => Navigator.pushNamed(context, CurdappRoutes.settings),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, size: iconSize,),
          title: Text('Sign out'),
              onTap: () => context.read<DrawerBloc>().add(Logout())
            ),
            Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Profiles'),
                onTap: () => Navigator.pushNamed(context, ProfileRoutes.list),
            ),
            // jhipster-merlin-needle-menu-entry-add
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Text('Menu',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
