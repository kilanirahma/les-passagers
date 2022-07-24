//passage

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/confirm%C3%A9.dart';
import 'package:untitled3/ui/login/login.dart';
import 'package:untitled3/ui/menu/HIS.dart';
import 'package:untitled3/ui/tournee/tourn%C3%A9.dart';
import 'INSERT2.dart';
import 'insert.dart';
import 'package:untitled3/ui/menu/historique2.dart';
import 'package:untitled3/ui/tournee/tourn%C3%A9.dart';
import 'INSERT2.dart';
import 'annule.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late String idtourne;
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: annule(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc),
    );
  }
}

class annule extends StatefulWidget {
  late String idtourne;
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;
  annule(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc);

  @override
  _annuleState createState() {
    return _annuleState(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc);
  }
}

class _annuleState extends State<annule> {
  late String idtourne, msg;
  bool error = false,
      dataloaded = false;
  var data;
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;
  String dataurl =  "http://10.0.2.2/pfe/update.php";

  String url = "http://10.0.2.2/pfe/update2.PHP";


  _annuleState(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc);

  List<NameOne4> namelist = [];

  @override
  void initState() {
    loaddata();
    //calling loading of data
    super.initState();
  }

  void loaddata() {
    Future.delayed(Duration.zero, () async {
      var res = await http.post(Uri.parse(dataurl), body: {
        'tr_point_stop_id': this.tr,

      });
      if (res.statusCode == 200) {
        setState(() {
          data = json.decode(res.body);
          dataloaded = true;
        });
      } else {
        setState(() {
          error = true;
        });
      }
    });
  }

  void loaddata1() {
    Future.delayed(Duration.zero, () async {
      var res = await http.post(Uri.parse(url), body: {
        'tr_point_stop_id': this.tr,
      });
      if (res.statusCode == 200) {
        setState(() {
          data = json.decode(res.body);
          dataloaded = true;
        });
      } else {
        setState(() {
          error = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text("Valider les passages"),
            backgroundColor:Colors.deepOrange,
   ),
        drawer:Drawer(
          child: ListView(
            // Remove padding
            padding: EdgeInsets.zero,
            children: [
              Image.asset('assets/eee.png', height: 160,),
              const SizedBox(height: 60,),


              ListTile(
                  leading: Icon(Icons.directions),
                  title: Text('tournées'),
                  onTap: () =>  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => tourne()),
                  )
              ),

              ListTile(
                leading: Icon(Icons.check),
                title: Text('les passages confirmé'),
                onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => his()),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('les passages annulé'),
                onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => his1()),
                ),
              ),

              Divider(),
              ListTile(
                  title: Text('Déconnexion'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () =>   Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => LoginPage()),
                  )
              ),
            ],
          ),
        ),
      body: SingleChildScrollView(
          child: Container(
            constraints:
            BoxConstraints(minHeight: MediaQuery
                .of(context)
                .size
                .height
              //set minimum height equal to 100% of VH
            ),
            width: MediaQuery
                .of(context)
                .size
                .width,

            //show linear gradient background of page

            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 200),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RaisedButton(

                    onPressed: () {
                      setState(() {
                        //show progress indicator on click
                      });
                      loaddata1();



                      _showDialog('passage confirmé');
                    },
                    child: Text(
                      "confirmer",
                      style: TextStyle(fontSize: 20),
                    ),

                    // if showprogress == true then show progress indicator
                    // else show "LOGIN NOW" text
                    colorBrightness: Brightness.dark,
                    color: Colors.green,
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
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        //show progress indicator on click
                      });
                      loaddata();

                      Navigator.pop(
                        context,
                        new MaterialPageRoute(builder: (context) => tourne()),
                      );
                      _showDialog3('passage annule');
                    },
                    child: Text(
                      "Annuler",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }


  void _showDialog3(msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('validation'),
            content: new Text(msg),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'passage suivant ',
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => tourne()),
                  );
                },
              )
            ],

          );
        });
  }

  void _showDialog(msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('validation'),
            content: new Text(msg),
            actions: <Widget>[
              RaisedButton(
                child: new Text(
                  'passage confirmé ',
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) =>
                        WriteSQLdata(
                            this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc
                          )),
                  );
                },
              )
            ],

          );
        });
  }
}
