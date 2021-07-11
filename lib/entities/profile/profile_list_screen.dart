import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curdapp/account/login/login_repository.dart';
import 'package:curdapp/entities/profile/bloc/profile_bloc.dart';
import 'package:curdapp/entities/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:curdapp/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:curdapp/shared/widgets/drawer/drawer_widget.dart';
import 'package:curdapp/shared/widgets/loading_indicator_widget.dart';
import 'package:curdapp/shared/models/entity_arguments.dart';
import 'profile_route.dart';

class ProfileListScreen extends StatelessWidget {
    ProfileListScreen({Key? key}) : super(key: ProfileRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if(state.deleteStatus == ProfileDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Profile deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Profiles List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) => previous.profiles != current.profiles,
              builder: (context, state) {
                return Visibility(
                  visible: state.profileStatusUI == ProfileStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Profile profile in state.profiles) profileCard(profile, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CurdappDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ProfileRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget profileCard(Profile profile, BuildContext context) {
    ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 60.0,
                color: Theme.of(context).primaryColor,
              ),
                  title: Text('Name : ${profile.name.toString()}'),
                  subtitle: Text('Age : ${profile.age.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, ProfileRoutes.edit,
                            arguments: EntityArguments(profile.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              profileBloc, context, profile.id);
                          },
                        );
                    }
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    DropdownMenuItem<String>(
                        value: 'Delete', child: Text('Delete'))
                  ]),
              selected: false,
              onTap: () => Navigator.pushNamed(
                  context, ProfileRoutes.view,
                  arguments: EntityArguments(profile.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(ProfileBloc profileBloc, BuildContext context, int? id) {
    return BlocProvider<ProfileBloc>.value(
      value: profileBloc,
      child: AlertDialog(
        title: new Text('Delete Profiles'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              profileBloc.add(DeleteProfileById(id: id));
            },
          ),
          new TextButton(
            child: new Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}
