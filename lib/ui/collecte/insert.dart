

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/ui/login/login.dart';
import 'package:untitled3/ui/menu/HIS.dart';
import 'package:untitled3/ui/menu/historique2.dart';
import 'package:untitled3/ui/tournee/tourn%C3%A9.dart';

import 'annule.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

//import package file manually

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WriteSQLdata(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc),
    );
  }
}

class WriteSQLdata extends StatefulWidget {
  late String tr;
  late String tpt, trp, dt, trc, trs, dc;
  WriteSQLdata(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc);

  @override
  _WriteSQLdataState createState() {
    return _WriteSQLdataState(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc);
  }
}

class _WriteSQLdataState extends State<WriteSQLdata> {
  var data;
  String  _chosenValue='';
  String _scanBarcode = 'Unknown';
  late bool  showprogress;
  late String errormsg;

  TextEditingController rf_objet = TextEditingController();
  TextEditingController objet_type_id = TextEditingController();
  TextEditingController objet_type_libelle = TextEditingController();
  TextEditingController valeur_declare = TextEditingController();
  bool error = false, dataloaded = false;
  String dataurl = "http://10.0.2.2/pfe/insert.php";
  String url= "http://10.0.2.2/pfe/select.php";
  late bool sending, success;
  late String msg;
  late String idtourne;

  String dropdownvalue = 'BDT';
  var items = [
    'BDT',
    'MDT',
    'MDT5',
    'VL',
    'DV'
  ];
  String dropdownvalue2 = 'Billet';
  var items2 = [
    'Billet',
    'Monnaie',
    'Monnaie 5D',
    'Valeur',
    'Devise'
  ];
  final String tr;
  final String tpt, trp, dt, trc, trs, dc;

  _WriteSQLdataState( this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc);


  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  startLogin() async {
    String dataurl = "http://10.0.2.2/pfe/insert.php";

    print(valeur_declare);

    var response = await http.post(Uri.parse(dataurl), body: {
      "rf_objet": rf_objet,
      "objet_type_id": objet_type_id,
      "objet_type_libelle": objet_type_libelle,
      "valeur_declare": valeur_declare,
      "tr_point_stop_id" :  this.tr,
      "tp_tourne_passage_id": this.tpt,
      "tr_centre_fort_id": this.trp,
      "tr_client_id": this.trc,
      "tr_societe_id": this.trs,
      "dc_status_id" :  this.dc,
      "mt_date_journe" :  this.dt,
    });
    print(response);
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      print(jsondata["status"]);

      if (jsondata["status"] == "Failled") {
        _showDialog('Mot de passe ou identifiant Incorrect');
      } else {
        if (jsondata["status"] == "Success") {
          _showDialog2('Mot de passe ou identifiant Incorrect');
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
  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:const Text("Write Data PHP & MySQL"),
            backgroundColor:Colors.redAccent,
            actions: [

              PopupMenuButton(
                  onSelected: (value){
                    if(value == 1){
                      // open settings screen on click on settings
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('les tournés'),
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await Future.delayed(Duration.zero);
                        navigator.push(
                          MaterialPageRoute(builder: (_) => tourne()),
                        );
                      },
                    ),
                    PopupMenuItem(
                      child: Text('Validation '),
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await Future.delayed(Duration.zero);
                        navigator.push(
                          MaterialPageRoute(builder: (_) => annule(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc),),
                        );
                      },
                    ),
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
              ListTile(
                  leading: Icon(Icons.assignment_turned_in ),
                  title: Text('validation'),
                  onTap: () =>  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) =>
                        annule(this.tr,this.tpt, this.trp, this.dt, this.trc, this.trs, this.dc)),
                  )
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
        body:Center(
          //appbar
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView( //enable scrolling, when keyboard appears,
                    // hight becomes small, so prevent overflow
                      child:Container(
                          padding: EdgeInsets.all(20),
                          child: Column(children: <Widget>[

                            Container(
                              child:Text(error?msg:"saisir les collectes"),
                              //if there is error then sho msg, other wise show text message
                            ),

                            Container(
                              child:Text(success?"Write Success":"send data"),
                              //is there is success then show "Write Success" else show "send data"
                            ),

                            ElevatedButton(
                                onPressed: () => scanBarcodeNormal(),
                                child: const Text('rf_objet')),

                            Text('Scan result : $_scanBarcode\n',
                                style: const TextStyle(fontSize: 20)),
                            DropdownButton(

                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                            DropdownButton(
                              // Initial Value
                              value: dropdownvalue2,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items2.map((String items2) {
                                return DropdownMenuItem(
                                  value: items2,
                                  child: Text(items2),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue2) {
                                setState(() {
                                  dropdownvalue2 = newValue2!;
                                });
                              },
                            ),


                            Container(
                                child: TextField(
                                  controller: valeur_declare,
                                  decoration: InputDecoration(
                                    labelText:"valeur_declare:",
                                    hintText:"valeur_declare",
                                  ),
                                )
                            ),


                            Container(
                                margin: EdgeInsets.only(top:20),
                                child:SizedBox(
                                    width: double.infinity,
                                    child:ElevatedButton(
                                      onPressed:(){ //if button is pressed, setstate sending = true, so that we can show "sending..."
                                        setState(() {
                                          sending = true;
                                        });
                                        startLogin();
                                      },
                                      child: Text(
                                        sending?"Sending...":"SEND DATA",
                                        //if sending == true then show "Sending" else show "SEND DATA";
                                      ),
                                      //background of button is darker color, so set brightness to dark
                                    )
                                )
                            )
                          ],)
                      )
                  ),

                ])));
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
  void _showDialog2(msg) {
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

