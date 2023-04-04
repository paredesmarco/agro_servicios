import 'dart:convert';

TripsSitioModelo newResponseFromJson(String str) =>
    TripsSitioModelo.fromJson(json.decode(str));

class TripsSitioModelo {
  int? idArea;
  String? area;
  String? sitio;
  int? idSitio;
  String? tipoArea;
  String? direccion;
  String? parroquia;
  String? canton;
  String? provincia;
  String? identificadorOperador;

  TripsSitioModelo({
    this.idArea,
    this.area,
    this.sitio,
    this.idSitio,
    this.tipoArea,
    this.direccion,
    this.parroquia,
    this.canton,
    this.provincia,
    this.identificadorOperador,
  });

  factory TripsSitioModelo.fromJson(Map<String, dynamic> json) =>
      TripsSitioModelo(
        idArea: json["id_area"],
        area: json["area"],
        sitio: json["sitio"],
        idSitio: json["id_sitio"],
        tipoArea: json["tipo_area"],
        direccion: json["direccion"],
        parroquia: json["parroquia"],
        canton: json["canton"],
        provincia: json["provincia"],
        identificadorOperador: json["identificador_operador"],
      );

  Map<String, dynamic> toJson() => {
        "id_area": idArea,
        "area": area,
        "sitio": sitio,
        "id_sitio": idSitio,
        "tipo_area": tipoArea,
        "direccion": direccion,
        "parroquia": parroquia,
        "canton": canton,
        "provincia": provincia,
        "identificador_operador": identificadorOperador,
      };
  @override
  String toString() {
    return '''
    TripsSitioModelo {
id_area:$idArea            
area:$area                 
sitio:$sitio               
id_sitio:$idSitio          
tipo_area:$tipoArea        
direccion:$direccion       
parroquia:$parroquia       
canton:$canton             
provincia:$provincia       
identificador_operador:$identificadorOperador      
    }
    ''';
  }
}
