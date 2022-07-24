


class NameOne {
  String tp_tourne_id,libelle;
  NameOne({
    required this.tp_tourne_id,
    required this.libelle,
  });
  factory NameOne.fromJson(Map<String, dynamic> json){
    return NameOne(
      tp_tourne_id:json["tp_tourne_id"],
      libelle: json["libelle"],



    );
  }
}