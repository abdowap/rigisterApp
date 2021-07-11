import 'package:curdapp/entities/profile/profile_model.dart';
import 'package:curdapp/shared/db/database_helper.dart';

class ProfileRepository {
  ProfileRepository();

  static final String uriEndpoint = '/profiles';

  final dbHelper = DatabaseHelper.instance;

  Future<List<Profile>> getAllProfiles() async {
    final allProfilesRequest = await dbHelper.queryAllRows();
    List<Profile> prof = [];
    allProfilesRequest.map((e) => prof.add(Profile.fromJson(e)));
    return prof;
  }

  Future<Profile> getProfile(int? id) async {
    final allProfilesRequest = await dbHelper.queryAllRows();
    List<Profile> prof = [];
    allProfilesRequest.map((e) => prof.add(Profile.fromJson(e)));
    return prof.first;
  }

  Future<Profile> create(Profile profile) async {
    final profileRequest = await dbHelper.insert(profile.toJson());
    final allProfilesRequest = await dbHelper.queryAllRows();
    List<Profile> prof = [];
    allProfilesRequest.map((e) => prof.add(Profile.fromJson(e)));
    return prof.first;
  }

  Future<Profile> update(Profile profile) async {
    final profileRequest = await dbHelper.update(profile.toJson());
    final allProfilesRequest = await dbHelper.queryAllRows();
    List<Profile> prof = [];
    allProfilesRequest.map((e) => prof.add(Profile.fromJson(e)));
    return prof.first;
  }

  Future<void> delete(int id) async {
    final profileRequest = await dbHelper.delete(id);
  }
}
