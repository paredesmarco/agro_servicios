import 'dart:convert';

List<Pantallas> pantallasFromJson(String str) => List<Pantallas>.from(json.decode(str).map((x) => Pantallas.fromJson(x)));

String pantallasToJson(List<Pantallas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pantallas {
    Pantallas({
        this.pantalla,
        this.imagen,
        this.textos,
    });

    String? pantalla;
    String? imagen;
    List<Texto>? textos;

    factory Pantallas.fromJson(Map<String, dynamic> json) => Pantallas(
        pantalla: json["pantalla"],
        imagen: json["imagen"],
        textos: List<Texto>.from(json["textos"].map((x) => Texto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pantalla": pantalla,
        "imagen": imagen,
        "textos": List<dynamic>.from(textos!.map((x) => x.toJson())),
    };
}

class Texto {
    Texto({
        this.texto,
    });

    String? texto;

    factory Texto.fromJson(Map<String, dynamic> json) => Texto(
        texto: json["texto"],
    );

    Map<String, dynamic> toJson() => {
        "texto": texto,
    };
}
