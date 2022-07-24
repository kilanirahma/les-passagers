import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/ui/passage/passage2.dart';
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
      home: his1(),
    );
  }
}


class his1 extends StatefulWidget{
  late  String idtourne;
  his1();
  @override

  _his1State createState(){
    return _his1State();
  }
}

class _his1State extends State<his1> {
  late  String idtourne;
  late String tpt, trp, dt, trc, trs, dc,tr;

  bool error = false,
      dataloaded = false;
  var data;
  late  NameOne2 value;
  String dataurl =   "http://10.0.2.2/pfe/historique2.php";



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
            title: Text("les passages annulés"),
            backgroundColor: Colors.red,
            actions: [

              PopupMenuButton(
                  onSelected: (value){
                    if(value == 1){
                      // open settings screen on click on settings
                    }
                  },
                  itemBuilder: (context) => [


                    PopupMenuItem(
                      child: Text('logout'),
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await Future.delayed(Duration.zero);
                        navigator.push(
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      },
                    ),
                  ]),
            ]),

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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/N.jpg'),
                    fit: BoxFit.cover,
                  ),
                )

            )));}

  Widget datalist() {
    if (data["error"]) {
      return Text(data["errmsg"]);
    } else {
      List<NameOne2> namelist = List<NameOne2>.from(data["data"].map((i) {
        return NameOne2.fromJSON(i);
      }));

      return  Expanded(

          child: ListView.builder(
              shrinkWrap: true,

              padding: EdgeInsets.all(12.0),
              itemCount: namelist.length,
              itemBuilder: (BuildContext context,int position){

                return new ListTile(


                  title:new Text(
                    '${namelist[position].tr_point_stop_id}',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  subtitle:new Text(
                    '${namelist[position].libelle}',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
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

