import 'dart:convert';

import '../models/user.dart';
import '../Services/BoxManager.dart';

class UserRepository {
  BoxManager _boxManager = BoxManager();

  Future<void> saveUser(User user) async {
    _validateUser(user);
    await _boxManager.userBox.put('currentUser', user.toJsonString());
  }

  Future<User?> getUser() async {
    var data = _boxManager.userBox.get('currentUser');
    if (data != null) {
      return User.fromJson(jsonDecode(data) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await saveUser(user);
  }

  Future<void> deleteUser() async {
    await _boxManager.userBox.delete('currentUser');
  }

  void _validateUser(User user) {
    if (user.name.isEmpty || user.email.isEmpty) {
      throw ArgumentError('Repetitions cannot be null or negative');
    }
    // the above is an example, you can of course add more validations
  }
}