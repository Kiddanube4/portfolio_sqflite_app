


import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_sqflite_app/model/userModel.dart';
import 'package:portfolio_sqflite_app/homeScreen.dart';
import 'boxDecoraions.dart';
import 'package:flutter/material.dart';
import 'dbHelper.dart';

final dateJoined = DateTime.now();
final TextEditingController _mailController = TextEditingController();
final TextEditingController _passWordController = TextEditingController();

Widget buildEmailTF() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Email',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          controller: _mailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: 'Enter your Email',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget buildPasswordTF() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Password',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          controller: _passWordController,
          obscureText: true,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: 'Enter your Password',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}


Widget buildSignupBtn() {
  return GestureDetector(
    onTap: () async {
      int? i = await Databasehelper.instance.create({
        userFields.userName: 'kdnb4',
        userFields.userMail: 'nbk_1235@hotmail.com',
        userFields.passWord: 'Bmwgtrm5',
        userFields.timeJoined: dateJoined.toIso8601String()
      }, "userTable");
      print(i);
    },
    child: RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
void onLoginClicked(String mail, String password,BuildContext context) async {
  bool IsLogged = false;
  List<Map<String, Object?>>? allRows =
  await Databasehelper.instance.readAll("userTable");
  for (int i = 0; i < allRows!.length; i++) {
    if (mail == allRows[i]["userMail"]) {
      if (password == allRows[i]["passWord"]) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> mainScreen()));
      }
    }
  }
}

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? description;
  const TaskCardWidget({Key? key,   this.title,this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        Text(
         title ?? "(Unnamed Task)",
          style: GoogleFonts.nunitoSans(
            color: Color(0xFF211551),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
            Text(description ?? "No description added",
            style: GoogleFonts.aBeeZee(
              fontSize: 16.0,
              color: Color(0xFF86829D),
              height: 1.5
            ),)
      ]),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  final String? text;
  final bool IsDone;
  const ToDoWidget({Key? key, this.text, required this.IsDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 24.0,
        vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(right: 12.0),
            decoration:  BoxDecoration(
              color: IsDone ? Color(0xFF7349FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: IsDone ? null : Border.all(color: Color(0xFF86829D),
              width: 1.5)
            ),
            child: Image(image: AssetImage("assets/images/check_icon.png"),),
          ),
          Text(text ?? "(unnamed action)",
          style:GoogleFonts.nunitoSans(
            color:IsDone ? Color(0xFF211551) : Color(0xFF86829D),
            fontSize: 16.0,
            fontWeight: IsDone ? FontWeight.bold : FontWeight.w500
          ))
        ],
      ),
    );
  }
}

class bullshitFlutter extends StatefulWidget {
  const bullshitFlutter({Key? key}) : super(key: key);

  @override
  State<bullshitFlutter> createState() => _bullshitFlutterState();
}

class _bullshitFlutterState extends State<bullshitFlutter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          onLoginClicked(_mailController.text, _passWordController.text, context);
        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
