import 'package:path_provider/path_provider.dart';
import 'package:portfolio_sqflite_app/model/toDo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'model/userModel.dart';
import 'model/taskModel.dart';

class Databasehelper{
  static const dbName = "tododb";
  static const version = 2;
  static const userTable = "userTable";
  static const dataTable = "Tasks";
  static const todoTable = "toDo";

  Databasehelper.privateConstructor();
  static final Databasehelper instance = Databasehelper.privateConstructor();
  Databasehelper();
  static Database? _db;

  Future<Database?> get database async {
    if(_db != null) return _db;
    _db = await _initDB();
    return _db;
  }
  _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,dbName);
    return await openDatabase(path,version: version,onCreate: _onCreate);

  }
  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const taskType = 'TEXT';
    const IntType = 'INTEGER';
    await db.execute(
        '''
        CREATE TABLE $userTable(
        ${userFields.id} $idType,
        ${userFields.userMail} $textType,
        ${userFields.passWord} $textType,
        ${userFields.userName} $textType,
        ${userFields.timeJoined} $textType
        )
        '''
    );
    await db.execute(
        '''
        CREATE TABLE $dataTable(
        ${dataFields.id} $idType,
        ${dataFields.title} $taskType,
        ${dataFields.description} $taskType
        )
        '''
    );
    await db.execute(
        '''
        CREATE TABLE $todoTable(
        ${toDoFields.id} $idType,
        ${toDoFields.todoTitle} $taskType,
        ${toDoFields.IsDone} $IntType,
        ${toDoFields.taskID} $IntType
        )
        '''
    );
  }
  Future<int?> create(Map<String,dynamic> row,String tableName) async {
    final db = await instance.database;
    return await db?.insert(tableName,row);
  }
  Future<List<Map<String,Object?>>?> singleReaD(String tableName,int id)async{
    final db = await instance.database;
    return await db?.query(tableName,where: '_id = ? ',whereArgs:[id]);
  }

  Future<List<Map<String,dynamic>>?> readAll(String tableName)async{
    final db = await instance.database;
    return await db?.query(tableName);
  }
  Future<int?> update(Map<String,dynamic> row,String tableName) async{
    Database? db = await instance.database;
    int id = row["_id"];
   return await db?.update(tableName, row,where: '_id = ?',whereArgs: [id]);
  }
  Future<int?> delete(int id, String tableName) async{
    Database? db = await instance.database;
    return await db?.delete(tableName,where: '_id = ?', whereArgs: [id]);
  }
  Future<int?> insertTask(Task task) async {
    Database? db = await instance.database;
    return await db?.insert(dataTable, task.toMap(),conflictAlgorithm: ConflictAlgorithm.abort);
  }
  Future<List<Task>> getTasks() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>>? taskMap = await db?.query(dataTable);
    return List.generate(taskMap!.length, (index) {
      return Task(id: taskMap[index][dataFields.id],title: taskMap[index][dataFields.title],description: taskMap[index][dataFields.description]);
    });
  }
  Future<int?> insertTodo(ToDo todo) async {
    Database? db = await instance.database;
    return await db?.insert(todoTable, todo.toMap(),conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<List<ToDo>> getToDo(int taskID) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>>? toDoMap = await db?.rawQuery("SELECT * FROM $todoTable WHERE ${toDoFields.taskID} = $taskID");
    return List.generate(toDoMap!.length, (index) {
      return ToDo(id: toDoMap[index][toDoFields.id],title: toDoMap[index][toDoFields.todoTitle],
          taskID: toDoMap[index][toDoFields.taskID],Isdone: toDoMap[index][toDoFields.IsDone]);
    });
  }
}