class NameOne4 {
  String rf_objet, objet_type_id,objet_type_libelle,valeur_declare,tp_tourne_passage_id,
      tr_point_stop_id,mt_date_journe,tr_centre_fort_id,dc_status_id,tr_client_id,tr_societe_id;


  NameOne4({
    required this.rf_objet,
    required this.objet_type_id,
    required this.objet_type_libelle,
    required this.valeur_declare,
    required this.tr_point_stop_id,
    required this.tp_tourne_passage_id,
    required this.mt_date_journe,
    required this.tr_centre_fort_id,
    required this.tr_client_id,
    required this.tr_societe_id,
    required this.dc_status_id,




  });

  //constructor

  factory NameOne4.fromJSON(Map<String, dynamic> json){
    return NameOne4(
      rf_objet: json["rf_objet"],
      objet_type_id: json["objet_type_id"],
      objet_type_libelle: json["objet_type_libelle"],
      valeur_declare: json["valeur_declare"],
      tp_tourne_passage_id:  json["tp_tourne_passage_id"],
      tr_point_stop_id: json["tr_point_stop_id"],
      mt_date_journe:json["mt_date_journe"],
      tr_centre_fort_id:json["tr_centre_fort_id"],
      tr_client_id:json["tr_client_id"],
      tr_societe_id:json["tr_societe_id"],
      dc_status_id:json["dc_status_id"],


    );
  }
}