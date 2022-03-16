import 'userModel.dart';
class Task{
  final int? id;
  final String? title;
  final String? description;
  Task({ this.title, this.id, this.description});
  Map<String, dynamic> toMap() {
    return {
      'title':title ?? "",
      'description':description ?? "",
    };


  }

}