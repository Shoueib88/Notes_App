import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/cubit/note_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteCubitBloc extends Cubit<NoteState> {
  NoteCubitBloc() : super(InitNoteState());

  final formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();

  Database? _db;

  Future<Database?> get db async {
    _db = database;
    if (_db == null) {
      _db = await createDataBase();
      return _db;
    } else
      return _db;
  }

  Database? database;
  createDataBase() async {
    var datapath = await getDatabasesPath();

    print(datapath);

    String path = join(datapath, 'note.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                'CREATE TABLE Note (id INTEGER PRIMARY KEY, title TEXT, message TEXT)')
            .then((value) => print('success'))
            .catchError((e) {
          print(e);
        });
      },
      onOpen: (db) {
        getDataBase(db);
        print('tabel is created');
      },
    );
  }

  insertDataBase({required String title, required String message}) async {
    await database!.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO Note(title, message) VALUES("$title", "$message")');
    }).then((value) {
      emit(InsertDataBaseSuccess());
      print('data inserted successfully $value');
      getDataBase(database);
    }).catchError((e) {
      emit(InsertDataBaseError());
      print(e);
    });
  }

  deleteDataBase({required int id}) async {
    await database!
        .rawDelete('DELETE FROM Note WHERE id = ?', [id]).then((value) {
      emit(DeleteDataBaseSuccess());
      print("$value is deleted");
      getDataBase(database);
    }).catchError((error) {
      emit(DeleteDataBaseError());
      print(error);
    });
  }

  updatemessageDataBase(
      {required String title, required String message, required int id}) async {
    await database!.rawUpdate('UPDATE Note SET title= ?, message= ? WHERE id=?',
        [title, message, id]).then((value) {
      print('updated data $value');
      getDataBase(database);
      emit(UpdateDataBaseSuccess());
    }).catchError((e) {
      print(e);
    });
  }

  List<Map> notesList = [];

  getDataBase(Database? database) {
    emit(GetDataBaseLoading());
    notesList.clear();
    database!.rawQuery('SELECT * FROM Note').then((value) {
      for (Map<String, Object?> element in value) {
        notesList.add(element);
      }
      emit(GetDataBaseSuccess());
    }).catchError((error) {
      emit(GetDataBaseError());
      print(error);
    });
  }
}
