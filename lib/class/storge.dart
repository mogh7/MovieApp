import 'package:move_app/main.dart';
import 'package:move_app/screens/homePage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

int version = 2;

//open database
Future<void> openDb() async {
  Database database = await openDatabase(
    path.join(await getDatabasesPath(), 'Like.db'),
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE likeMovie (id INTEGER PRIMARY KEY, MovieId INTEGER, posterPath TEXT)');
    },
    version: version,
  );
  SplashScreen.db = database;
}

//insert MovieLike
Future<void> insertMovieLike(MovieLike like) async {
  await SplashScreen.db.insert(
    'likeMovie',
    like.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  HomePage.likeList = await SplashScreen.db.rawQuery('SELECT * FROM likeMovie');
}

//readData
Future readMovieLike() async {
  Database database = await openDatabase(
    path.join(await getDatabasesPath(), 'Like.db'),
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE likeMovie (id INTEGER PRIMARY KEY, MovieId INTEGER, posterPath TEXT)');
    },
    version: version,
  );
  // database.rawDelete('DELETE FROM likeMovie');
  HomePage.likeList = await database.rawQuery('SELECT * FROM likeMovie');
}

//deleatRaw in dataBase
Future<void> deleatMovie(int movieId) async {
  await SplashScreen.db
      .delete('likeMovie', where: 'MovieId = ?', whereArgs: [movieId]);
  HomePage.likeList = await SplashScreen.db.rawQuery('SELECT * FROM likeMovie');
}

class MovieLike {
  final int MovieId;
  final String posterPath;

  MovieLike({
    required this.MovieId,
    required this.posterPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'MovieId': MovieId,
      'posterPath': posterPath,
    };
  }
}
