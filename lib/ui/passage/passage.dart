//passage

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/ui/menu/HIS.dart';
import 'package:untitled3/ui/menu/historique2.dart';
import 'package:untitled3/ui/login/login.dart';
import 'package:untitled3/ui/tournee/TOURNE2.dart';
import 'package:untitled3/ui/passage/infos%20passages.dart';
import 'package:untitled3/ui/passage/passage2.dart';
import 'package:untitled3/ui/tournee/tourn%C3%A9.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late String idtourne;
  late  String idt;
  late  String tr;
  late String  tpt,trp,dt,trc,trs,dc;

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: passage(this.idtourne),
    );
  }
}

class passage extends StatefulWidget {
  late String idtourne;
  late  String idt;
  late  String tr;
  late String  tpt,trp,dt,trc,trs,dc;

  passage(this.idtourne);

  @override
  _passageState createState() {
    return _passageState(this.idtourne);
  }
}

class _passageState extends State<passage> {
  late String idt;
  late  String tr;
  bool error = false, dataloaded = false;
  var data;
  late NameOne2 value;
  String dataurl = "http://10.0.2.2/pfe/passage.php";
  final String idtourne;
  late String  tpt,trp,dt,trc,trs,dc;

  _passageState(this.idtourne);

  @override
  void initState() {
    loaddata();
    //calling loading of data
    super.initState();
  }

  void loaddata() {
    Future.delayed(Duration.zero, () async {
      var res = await http.post(Uri.parse(dataurl), body: {
        'tp_tourne_id': this.idtourne,
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
          title: Text("les passage"),
          backgroundColor: Colors.deepOrange,
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
                   MaterialPageRoute(builder: (context) => his()),
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
              BoxConstraints(minHeight: MediaQuery.of(context).size.height
                  //set minimum height equal to 100% of VH
                  ),
          width: MediaQuery.of(context).size.width,
          child: dataloaded
              ? datalist()
              : Center(child: CircularProgressIndicator()),

    )));}

  Widget datalist() {
    if (data["error"]) {
      return Text(data["errmsg"]);
    } else {
      List<NameOne2> namelist = List<NameOne2>.from(data["data"].map((i) {
        return NameOne2.fromJSON(i);
      }));

      return Expanded(

          child: ListView.builder(

              shrinkWrap: true,
              padding: EdgeInsets.all(12.0),
              itemCount: namelist.length,
              itemBuilder: (BuildContext context, int position) {
                return InkWell(
                    onTap: () { Navigator.push(
                         context,
                        new MaterialPageRoute(builder: (context) => passage2(
                            namelist[position].tr_point_stop_id,
                       ),
                        ));},

                    child: Card(

                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[

                                   Text(
                                    '${'tp_tourne_passage= ' + namelist[position].tp_tourne_passage_id}',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.deepOrange,
                                        fontStyle: FontStyle.italic),
                                  ),

                                   Text(
                                    '${'tr_point_stop= ' + namelist[position].tr_point_stop_id}',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.deepOrange,
                                        fontStyle: FontStyle.italic),
                                  ),






                                ]))));
              }));
    }
  }
}
