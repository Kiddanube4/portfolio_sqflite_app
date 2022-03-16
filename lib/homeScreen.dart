import 'package:flutter/material.dart';
import 'package:portfolio_sqflite_app/taskPage.dart';
import 'model/taskModel.dart';
import 'widgets.dart';
import 'dbHelper.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  Databasehelper db = Databasehelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: Color(0xFFF6F6F6),
        child: Stack(
          children: <Widget>[
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 32,
                top:32),
                  child: Image(image: AssetImage('assets/images/logo.png'))
              ),
             Expanded(child: FutureBuilder(
               future: db.getTasks(),
                builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) { 
                 return ListView.builder(itemCount: snapshot.data?.length,
                 itemBuilder: (context,index) {
                   return GestureDetector(

                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(task:snapshot.data![index])));
                      } ,
                       child: TaskCardWidget(title: snapshot.data![index].title,));
                 },);
                },
             ),
             )
            ],
          ),
            Positioned(
              bottom: 24.0,
              right: 0.0,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  TaskPage(task: Task() ))).then((value) {
                    setState(() {

                    });
                  });
                },
                child: Container(
                  width: 60,
                  height: 60,

                  decoration: BoxDecoration(
                    color: Color(0xFF7349FE),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Image(image: AssetImage(
                    "assets/images/add_icon.png"
                  ),),

                ),
              ),
            )
        ]
        ),

      ),
    ));
  }
}
