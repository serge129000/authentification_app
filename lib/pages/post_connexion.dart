// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:authentification_app/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostC extends StatefulWidget {
  const PostC({Key? key}) : super(key: key);

  @override
  State<PostC> createState() => _PostCState();
}

String? login;

class _PostCState extends State<PostC> {
  //get data
  getD() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //recupere le login stocke
    setState(() {
      login = sharedPreferences.getString("login");
    });
  }

  @override
  void initState() {
    getD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //fonction deconnection
    getDeconnect() async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Se Deconnecter?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Non")),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Index()), (route) => false);
                    },
                    child: Text("Oui"))    
              ],
            );
          });
    }
//fin fonction deconnection
    //variables de recupearation largeur et taille de l'ecran
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //la variable pour recuperer le textscale du device
    double textscale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 60),
                height: height / 2.7,
                width: width,
                decoration: BoxDecoration(
                    // ignore: duplicate_ignore
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Colors.pink,
                      Colors.pinkAccent,
                      Color.fromARGB(255, 237, 27, 27)
                    ])),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("images/image1.jpg"),
                        //child: Image.asset("images/image1.jpg"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Mr $login",
                        style: GoogleFonts.inter(
                            fontSize: textscale * 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ])),
            Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              height: height / 2,
              child: SingleChildScrollView(
                child: Text(
                    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        '''),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 15),
              width: width,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink)),
                  onPressed: () {
                    getDeconnect();
                  },
                  child: Text(
                    "Deconnection",
                    style: GoogleFonts.inter(fontSize: textscale * 15),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
