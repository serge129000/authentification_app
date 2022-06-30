// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:authentification_app/pages/post_connexion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
//import backend
import 'package:mysql1/mysql1.dart';
import '../backend/mysql.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

//booleen d'affichage du mot de passe
bool onshow = false;
//Textfield controller
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
//recuperation du login et du mot de passe a enregistre dans le sharedpreferences
String? _login;
String? _password;

class _IndexState extends State<Index> {
  //connection avec la base de donnees

  getConnection(String login, String password) async {
    try {
      var connection = await MySqlConnection.connect(setting);
      print("est connecter");
      //requete Sql
      String sql =
          "select * from users where login = '$login' and password = '$password'";
      //le resultat retournes par la requete
      var res = await connection.query(sql);
      //print(res);
      if (res.toString() == "()") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Login ou mot de passe errone",
              style: GoogleFonts.poppins(color: Colors.white),
            )));
        // ignore: use_build_context_synchronously
      } else {
        //parcourir le resultat res
        for (var element in res) {
          setState(() {
            _login = element["login"].toString();
            _password = element["password"].toString();
          });
        }
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("login", _login!);
        sharedPreferences.setString("password", _password!);
        //aller sur la page de post_connection
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PostC()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    //getConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //variables de recupearation largeur et taille de l'ecran
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //la variable pour recuperer le textscale du device
    double textscale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 60),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.inter(
                              fontSize: textscale * 35,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sign in to continue",
                          style: GoogleFonts.poppins(
                              fontSize: textscale * 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ],
                ),
                TextField(
                  controller: email,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    //fontWeight: FontWeight.w200
                  ),
                  decoration: InputDecoration(
                      //label: Text("Username"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ],
                ),
                TextField(
                  obscureText: onshow,
                  controller: password,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    //fontWeight: FontWeight.w200
                  ),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              onshow = !onshow;
                            });
                          },
                          icon: onshow == true
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                      //label: Text("Password"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        /*style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey)
                      ),*/
                        onPressed: () {},
                        child: Text(
                          "Forgot your password?",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 232, 12, 85))),
                      onPressed: () {
                        if (email.text == "" || password.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Veuillez completer les champs requis",
                                style: GoogleFonts.poppins(color: Colors.white),
                              )));
                        } else {
                          //fonction qui recupere les donnees si existants
                          getConnection(email.text, password.text);
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.inter(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(right: 80, left: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 14, 109, 186)),
                        child: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.lightBlue),
                        child: Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.pink),
                        child: Icon(
                          FontAwesomeIcons.googlePlusG,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
