import 'package:hive/hive.dart';

class HiveHelper {
  /// Box Names
  static String loginUserBoxHive = "USER_LOGIN_BOX";

  /// Major keys
  static String loginUserKeyHive = "CURRENT_USER";

  /// Registers the Hive adapter for a specific model type [T]
  static void registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  /// Prepare a Hive box for any model type [T]
  static Future<Box<T>> prepareHiveBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    } else {
      return Hive.box<T>(boxName);
    }
  }

  /// Create/Insert an item into the Hive box
  static Future<void> addItem<T>(String boxName, String key, T item) async {
    final box = await prepareHiveBox<T>(boxName);
    await box.put(key, item);
  }

  /// Read/Get an item from the Hive box by key
  static Future<T?> getItem<T>(String boxName, String key) async {
    final box = await prepareHiveBox<T>(boxName);
    return box.get(key);
  }

  /// Update an item in the Hive box by key
  static Future<void> updateItem<T>(String boxName, String key, T item) async {
    final box = await prepareHiveBox<T>(boxName);
    await box.put(key, item);
  }

  /// Delete an item from the Hive box by key
  static Future<void> deleteItem<T>(String boxName, String key) async {
    final box = await prepareHiveBox<T>(boxName);
    await box.delete(key);
  }

  /// Read all items from the Hive box
  static Future<List<T>> getAllItems<T>(String boxName) async {
    final box = await prepareHiveBox<T>(boxName);
    return box.values.toList();
  }

  /// Delete all items from the Hive box
  static Future<void> deleteAllItems<T>(String boxName) async {
    final box = await prepareHiveBox<T>(boxName);
    await box.clear();
  }
}
