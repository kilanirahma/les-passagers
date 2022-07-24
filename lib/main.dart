
import 'package:flutter/material.dart';
import 'package:untitled3/splash.dart';
import 'package:untitled3/ui/collecte/annule.dart';
import 'package:untitled3/ui/collecte/insert.dart';
import 'package:untitled3/ui/passage/passage.dart';
import 'package:untitled3/ui/tournee/tourn%C3%A9.dart';
import 'ui/collecte/INSERT2.dart';
import 'ui/passage/infos passages.dart';
import 'ui/login/login.dart';
import 'ui/tournee/tourné.dart';
void main() {

  String idtourne='';
  String idt='';
  String tr ='';
  String tpt='';
  String dc ='';
  String trs='' ;
  String trp='' ;
  String dt='' ;
  String trc='';



  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen',
    routes: {'splashscreen' : (context) => splashscreen(),
      'login' : (context) => LoginPage(),
      '/' : (context) => tourne(),
      '/' : (context) => passage(idtourne),
      '/' : (context) => passage2(tr),
      '/annule' : (context) => annule(tr,tpt, trp, dt, trc, trs, dc),
      '/WriteSQLdata' : (context) => WriteSQLdata(tr,tpt, trp, dt, trc, trs, dc),












    },
  ));
}

