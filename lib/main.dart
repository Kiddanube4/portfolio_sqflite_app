import 'package:flutter/material.dart';
import 'package:portfolio_sqflite_app/homeScreen.dart';
import 'widgets.dart';
import 'dbHelper.dart';
void main()=>runApp(MaterialApp(home:HomePage(),));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: const Text("Login"),centerTitle: true,),
      body: Stack(
        children: <Widget>[
          //app background
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/mugiwara.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  buildEmailTF(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  buildPasswordTF(),
                  bullshitFlutter(),
                  buildSignupBtn()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

