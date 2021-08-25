



class Config {
  int? id;
  int splash;
  int adultos;
  int bebes;
  int ninos37;

  Config(
      {required this.adultos, required this.splash, required this.bebes, required this.ninos37, int? id});

  Map<String, dynamic> toJson() =>
      {
        ConfigFields.id: id,
        ConfigFields.splash: splash,
        ConfigFields.ninos37: ninos37,
        ConfigFields.bebes: bebes,
        ConfigFields.adultos: adultos,


      };



  static Config fromJson(Map<String, dynamic> json) {

    int val = json['_id'] as int;


    return Config(

      id: val,
      adultos: json[ConfigFields.adultos] as int,
      bebes: json[ConfigFields.bebes] as int,
      ninos37: json[ConfigFields.ninos37] as int,
      splash: json[ConfigFields.splash] as int,


    );
  }




}

class ConfigFields {

  static final List<String> values = [
    id, splash, adultos, bebes, ninos37
  ];
  static final String id = '_id';
  static final String splash = 'splash';
  static final String adultos = 'adultos';
  static final String bebes = 'bebes';
  static final String ninos37 = 'ninos37';


}