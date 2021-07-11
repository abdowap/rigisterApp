import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curdapp/entities/profile/bloc/profile_bloc.dart';
import 'package:curdapp/entities/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:curdapp/shared/widgets/loading_indicator_widget.dart';
import 'profile_route.dart';

class ProfileViewScreen extends StatelessWidget {
  ProfileViewScreen({Key? key}) : super(key: ProfileRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Profiles View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) => previous.loadedProfile != current.loadedProfile,
              builder: (context, state) {
                return Visibility(
                  visible: state.profileStatusUI == ProfileStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    profileCard(state.loadedProfile, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ProfileRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget profileCard(Profile profile, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + profile.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Name : ' + profile.name.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Age : ' + profile.age.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Note : ' + profile.note.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
