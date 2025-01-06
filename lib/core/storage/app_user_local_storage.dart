import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/core/common/entity/user_hive_box.dart';
import 'package:blog_app/features/blog/data/model/blog_hive_box_model.dart';
import 'package:hive/hive.dart';

class AppUserLocalStorage {
  AppUserLocalStorage._internal(this.userHiveBox);

  static final AppUserLocalStorage _instance = AppUserLocalStorage._internal(
    UserHiveBox(
      Hive.box(name: 'user'),
    ),
  );

  factory AppUserLocalStorage() => _instance;

  final UserHiveBox userHiveBox;

  ///Saving user details to local storage
  void saveUserDetails({required User user}) {
    userHiveBox.box.put('name', user.name);
    userHiveBox.box.put('email', user.email);
    userHiveBox.box.put('id', user.id);
    userHiveBox.box.put('userProfile', user.userProfile);
  }

  ///Getting user details from local storage
  User user() {
    final String name = userHiveBox.box.get('name');
    final String email = userHiveBox.box.get('email');
    final String id = userHiveBox.box.get('id');
    final String userProfile = userHiveBox.box.get('userProfile');
    return User(
      name: name,
      email: email,
      id: id,
      userProfile: userProfile,
    );
  }

  ///Save User is Logged In or not
  void saveUserLoggedIn(bool isLoggedIn) {
    userHiveBox.box.put('isLoggedIn', isLoggedIn);
  }

  ///Check if user is logged in or not
  bool isUserLoggedIn() {
    return userHiveBox.box.get('isLoggedIn', defaultValue: false);
  }
}
