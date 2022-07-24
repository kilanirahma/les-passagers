import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:untitled3/ui/tournee/tourn%C3%A9.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String errormsg;
  late bool error, showprogress;
  late String tr_personne_id, password;
List spacecrafts = [];
  var _tr_personne_id = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    String apiurl = "http://10.0.2.2/pfe/LOGIN.PHP";
    print(tr_personne_id);

    var response = await http.post(Uri.parse(apiurl), body: {
      'tr_personne_id': tr_personne_id,
      'password': password,
    });
    print(response);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      print(jsondata["status"]);

      if (jsondata["status"] == "Failled") {
        _showDialog('Mot de passe ou identifiant Incorrect');
      } else {
        if (jsondata["status"] == "Success") {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => tourne()),
          );
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false;
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    tr_personne_id = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
                ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange,
              Colors.deepOrangeAccent,
              Colors.red,
              Colors.redAccent,
            ],
          ),
        ),
        //show linear gradient background of page

        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Text(
              "sign in",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ), //title text
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Sign In using Email and Password",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ), //subtitle text
          ),
          Container(
            //show error message here
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            child: error ? errmsg(errormsg) : Container(),
            //if error == true then show error message
            //else set empty container as child
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _tr_personne_id, //set username controller
              style: TextStyle(color: Colors.orange[100], fontSize: 20),
              decoration: myInputDecoration(
                label: "username",
                icon: Icons.person,
              ),
              onChanged: (value) {
                //set username  text on change
                tr_personne_id = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _password,
              //set password controller
              style: TextStyle(color: Colors.orange[100], fontSize: 20),
              obscureText: true,
              decoration: myInputDecoration(
                label: "password",
                icon: Icons.lock,
              ),
              onChanged: (value) {
                // change password text
                password = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    //show progress indicator on click
                    showprogress = true;
                  });
                  startLogin();
                },
                child: showprogress
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.orange[100],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepOrangeAccent),
                        ),
                      )
                    : Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 20),
                      ),

                // if showprogress == true then show progress indicator
                // else show "LOGIN NOW" text
                colorBrightness: Brightness.dark,
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                    //button corner radius
                    ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: InkResponse(
                onTap: () {
                  //action on tap
                },
                child: Text(
                  "Forgot Password? Troubleshoot",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ]),
      )),
    );
  }

  InputDecoration myInputDecoration(
      {required String label, required IconData icon}) {
    return InputDecoration(
      hintText: label,
      //show label as placeholder
      hintStyle: TextStyle(color: Colors.orange[100], fontSize: 20),
      //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: Colors.orange[100],
          )
          //padding and icon for prefix
          ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.orange, width: 1)),
      //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.orange, width: 1)),
      //focus border

      fillColor: Color.fromRGBO(251, 140, 0, 0.5),
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.red, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }

  void _showDialog(msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Échoué'),
            content: new Text(msg),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Fermer',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

}
