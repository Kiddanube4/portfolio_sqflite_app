import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_sqflite_app/model/toDo.dart';
import 'package:portfolio_sqflite_app/widgets.dart';
import 'dbHelper.dart';
import 'model/taskModel.dart';

class TaskPage extends StatefulWidget {

  final Task task;
  const TaskPage({
    Key? key, required this.task
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();


}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController taskTitle = TextEditingController();
  final TextEditingController taskDEscription = TextEditingController();
  final Databasehelper _dbhelper = Databasehelper();
  int taskID = 0;
  String _taskTitle = "";
  @override
  void initState() {
   if(widget.task.id != null ){
     _taskTitle = widget.task.title!;
     taskID = widget.task.id!;
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 6.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image(
                          image:
                              AssetImage("assets/images/back_arrow_icon.png")),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                        controller: taskTitle..text = _taskTitle,
                        onSubmitted: (value) async {
                          if(value != ""){
                            if(widget.task.id == null) {
                              Task _newTask = Task(title: value);
                            await  Databasehelper.instance.insertTask(_newTask)
                                  .then((value) => print("new task created"));
                            }else{

                            }
                          }
                        },
                    decoration: InputDecoration(
                        hintText: "Enter Task title", border: InputBorder.none),
                    style: GoogleFonts.nunitoSans(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF211551)),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: "Enter desciprion for the task",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 24)),
              ),
            ),
            FutureBuilder(
              future: _dbhelper.getToDo(taskID),
              builder: (BuildContext context, AsyncSnapshot<List<ToDo>> snapshot) {
                return Expanded(
                  child: ListView.builder(itemCount: snapshot.data?.length,
                    itemBuilder: (context,index) {
                    return GestureDetector(
                      onTap: () {

                      },
                        child: ToDoWidget(IsDone: snapshot.data![index].Isdone == 0 ? false : true, text: snapshot.data![index].title));

                    },
                  ),
                );
              },
            ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
              Container(
                  width: 20.0,
                  height: 20.0,
                  margin: EdgeInsets.only(right: 12.0),
                  decoration:  BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Color(0xFF86829D),
                          width: 1.5)
                  ),
                  child: Image(image: AssetImage("assets/images/check_icon.png"),),
              ),
              Expanded(child: TextField(
                onSubmitted: (value) async{
                  if(value != ""){
                    if(widget.task.id != null) {
                      ToDo _newTodo = ToDo(title: value,
                      Isdone: 0,
                      taskID: widget.task.id);
                     await Databasehelper.instance.insertTodo(_newTodo)
                          .then((value) => print("new todo created"));
                     setState(() {

                     });
                    }else{

                    }
                  }
                },
                  decoration: InputDecoration(
                    hintText: "Enter To-Do item",
                    border: InputBorder.none
                  ),
              ))
            ],
                  ),
                ),


          ],
        ),
            Positioned(
              bottom: 24.0,
              right: 24.0,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskPage(task: Task())));
                },
                child: Container(
                  width: 60,
                  height: 60,

                  decoration: BoxDecoration(
                      color: Color(0xFFFE3577),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Image(image: AssetImage(
                      "assets/images/delete_icon.png"
                  ),),

                ),
              ),
            )

      ])),
    ));
  }
}
