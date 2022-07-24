class NameOne3{
  String tr_point_stop_id,tp_tourne_id,dc_status_id;

  NameOne3({required this.tr_point_stop_id,required this.tp_tourne_id,
    required this.dc_status_id
    });
  //constructor

  factory NameOne3.fromJSON(Map<String, dynamic> json){
    return NameOne3(
        tr_point_stop_id: json["tr_point_stop_id"],
      dc_status_id: json["dc_status_id"],
      tp_tourne_id:"http://10.0.2.2/pfe/tourn%c3%a9.php json"+json["tp_tourne_id"],

    );
  }
}