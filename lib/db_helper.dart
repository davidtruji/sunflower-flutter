import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:sunflower_flutter/plant.dart';

class DBHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentsDir.path, "databases", "data.db");
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 2,
          onCreate: _onCreate,
        ),
      );
      return winLinuxDB;
    } else if (Platform.isAndroid || Platform.isIOS) {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, "data.db");
      final iOSAndroidDB = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
      return iOSAndroidDB;
    }
    throw Exception("Unsupported platform");
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS plants(
            plantId TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            growZoneNumber INTEGER,
            wateringInterval INTEGER,
            imageUrl TEXT
          )
 """);
  }

  Future<List<Plant>> readPlantsFromJSON() async {
    debugPrint("READING PLANTS JSON");
    try {
      final String response = await rootBundle.loadString('assets/plants.json');
      final parsed =
          (jsonDecode(response) as List).cast<Map<String, dynamic>>();
      return parsed.map<Plant>((json) => Plant.fromJson(json)).toList();
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<List<Plant>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('plants');

    return List.generate(maps.length, (index) {
      return Plant(
        plantId: maps[index]['plantId'],
        name: maps[index]['name'],
        description: maps[index]['description'],
        growZoneNumber: maps[index]['growZoneNumber'],
        wateringInterval: maps[index]['wateringInterval'],
        imageUrl: maps[index]['imageUrl'],
      );
    });
  }

  Future<Plant> insertPlant(Plant plant) async {
    final db = await database;
    db.insert(
      "plants",
      plant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return plant;
  }

/*
  Future<List<User>> batchInsert() async {
    final db = await database;
    final batch = db.batch();
    final Random random = Random();
    final List<User> userList = List.generate(
      1000,
      (index) => User(
        id: index + 1,
        name: 'User $index',
        email: 'user$index@example.com',
        password: random.nextInt(9999),
        phoneNumber: random.nextInt(10000),
      ),
    );
    for (final User user in userList) {
      batch.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    return userList;
  }


   */

/*
  TODO: Create new queries
  Future<User?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        name: maps[0]['name'],
        email: maps[0]['email'],
        password: maps[0]['password'],
        phoneNumber: maps[0]['phoneNumber'],
      );
    }

    return null;
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    final Batch batch = db.batch();

    batch.delete('users');

    await batch.commit();
  }


   */
}
