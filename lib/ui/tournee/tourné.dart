import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/ui/passage/passage.dart';
import 'package:untitled3/ui/passage/passage2.dart';
import '../menu/HIS.dart';
import 'TOURNE2.dart';
import '../menu/historique2.dart';
import '../login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  late  String idtourne;
  late String trr;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: tourne(),
    );
  }
}


class tourne extends StatefulWidget{
  late  String idtourne;
  tourne();
  @override

  _tourneState createState(){
    return _tourneState();
  }
}

class _tourneState extends State<tourne> {
  late  String idtourne;
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;
  bool error = false,
      dataloaded = false;
  var data;
  late  NameOne2 value;
  String dataurl = "http://10.0.2.2/pfe/tourn%c3%a9.php";



  @override
  void initState() {
    loaddata();
    //calling loading of data
    super.initState();
  }
  void loaddata() {
    Future.delayed(Duration.zero, () async {
      var res = await http.post(Uri.parse(dataurl));
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
          title: Text("les tournés"),
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
          BoxConstraints(minHeight: MediaQuery.of(context).size.height
            //set minimum height equal to 100% of VH
          ),
          width: MediaQuery.of(context).size.width,



          child: dataloaded
              ? datalist()
              : Center(child: CircularProgressIndicator()),
        )
        )
    );

  }

  Widget datalist() {
    if (data["error"]) {
      return Text(data["errmsg"]);
    } else {
      List<NameOne> namelist = List<NameOne>.from(data["data"].map((i) {
        return NameOne.fromJson(i);
      }));

      return  Expanded(

          child: ListView.builder(
              shrinkWrap: true,

              padding: EdgeInsets.all(12.0),
              itemCount: namelist.length,
              itemBuilder: (BuildContext context,int position){

                return ListTile(

                  onTap: (){   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            passage(namelist[position].tp_tourne_id),
                      ));},
                  title:Text(
                    namelist[position].tp_tourne_id,
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.deepOrange,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  subtitle:  Text(
                    namelist[position].libelle,
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.deepOrange,
                        fontStyle: FontStyle.italic
                    ),
                  ),

                );
              }
          )
      );
            }

    }
  }

