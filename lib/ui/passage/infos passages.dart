import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/ui/collecte/annule.dart';
import 'package:untitled3/ui/passage/passage2.dart';
import 'package:untitled3/ui/tournee/tourn%C3%A9.dart';

import '../menu/HIS.dart';
import '../menu/historique2.dart';
import '../login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late String id;
  late String idt;
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: passage2(this.tr),
    );
  }
}

class passage2 extends StatefulWidget {
  late String id;
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;
  late String idt;

  passage2( this.tr);

  @override
  _passage2State createState() {
    return _passage2State( this.tr);
  }
}

class _passage2State extends State<passage2> {
  late String id;
  late String ids;
  late String idc;


  bool error = false, dataloaded = false;
  var data;
  late NameOne2 value;
  String dataurl = "http://10.0.2.2/pfe/nouveau%201.PHP";
  final String tr;
  late String tpt,  trc, trs,trp,dt,dc,idtourne;
  _passage2State( this.tr);

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
                      new MaterialPageRoute(builder: (context) => annule(
                          namelist[position].tr_point_stop_id,
                          namelist[position].tp_tourne_passage_id,
                        namelist[position].tr_centre_fort_id,
                        namelist[position].tr_client_id,
                        namelist[position].tr_societe_id,
                        namelist[position].dc_status_id,
                        namelist[position].mt_date_journe,
                      ),
                    ));},

                child: Card(

                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new Text(
                                '${'tr_societe= ' + namelist[position].tr_societe_id}',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.deepOrange,
                                    fontStyle: FontStyle.italic),
                              ),
                              new Text(
                                '${'tr_client= ' + namelist[position].tr_client_id}',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.deepOrange,
                                    fontStyle: FontStyle.italic),
                              ),
                              new Text(
                                '${'commandes= ' + namelist[position].commandes}',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.deepOrange,
                                    fontStyle: FontStyle.italic),
                              ),
                              new Text(
                                '${'heure_intervention= ' + namelist[position].heure_intervention}',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.deepOrange,
                                    fontStyle: FontStyle.italic),
                              ),

                              new Text(
                                '${'mt_date_journe	= ' + namelist[position].mt_date_journe	}',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.deepOrange,
                                    fontStyle: FontStyle.italic),
                              ),




                            ]))));
              }));
    }
  }
}
