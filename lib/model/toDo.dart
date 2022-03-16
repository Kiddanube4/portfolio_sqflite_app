import 'userModel.dart';
class ToDo{
  final int? id;
  final String? title;
  final int? taskID;
  final int? Isdone;
  ToDo({this.title,this.Isdone,this.id,this.taskID});
  Map<String,dynamic> toMap(){
    return {
      toDoFields.id: id,
      toDoFields.taskID: taskID,
      toDoFields.todoTitle:title,
      toDoFields.IsDone:Isdone,
    };

  }
}