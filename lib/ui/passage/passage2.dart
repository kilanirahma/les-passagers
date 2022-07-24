


class NameOne2  {
  String tp_tourne_passage_id, tr_societe_id,heure_intervention,commandes,
      tp_tourne_id,tr_point_stop_id,tr_client_id,libelle,dc_status_id, mt_date_journe,tr_centre_fort_id
  ;


  NameOne2({
    required this.tp_tourne_passage_id,
    required this.tr_societe_id,
    required this.tr_client_id,
    required this.heure_intervention,
    required this.commandes,
    required this.tr_point_stop_id,
    required this.tp_tourne_id,
    required this.libelle,
    required this.dc_status_id,
    required this.mt_date_journe,
    required this.tr_centre_fort_id,



  });

  //constructor

  factory NameOne2.fromJSON(Map<String, dynamic> json){
    return NameOne2(
      tp_tourne_passage_id: json["tp_tourne_passage_id"],
      tr_societe_id: json["tr_societe_id"],
      heure_intervention: json["heure_intervention"],
      commandes: json["commandes"],
      tr_point_stop_id:  json["tr_point_stop_id"],
      tr_client_id: json["tr_client_id"],
      tp_tourne_id:json["tp_tourne_id"],
      libelle:json["libelle"],
      dc_status_id:json["dc_status_id"],
      mt_date_journe:json["mt_date_journe"],
      tr_centre_fort_id:json["tr_centre_fort_id"],

    );
  }
}