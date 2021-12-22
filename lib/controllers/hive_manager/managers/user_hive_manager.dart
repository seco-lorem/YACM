import 'package:hive/hive.dart';
import 'package:yacm/controllers/hive_manager/hive_manager.dart';
import 'package:yacm/models/user/user.dart';

class UserHiveManager implements HiveManager<User> {
  @override
  Future<User> create(String boxName, String id, User data) async {
    try {
      Box _userBox = await Hive.openBox(boxName);

      await _userBox.put(data.id, data);

      return data;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<bool> delete(String boxName, String id) async {
    try {
      Box _userBox = await Hive.openBox(boxName);

      await _userBox.delete(id);

      return true;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<User> read(String boxName, String id) async {
    try {
      Box _userBox = await Hive.openBox(boxName);

      return await _userBox.get(id);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<User> update(String boxName, String id, User data) async {
    try {
      Box _userBox = await Hive.openBox(boxName);

      await _userBox.put(id, data);

      return data;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
