import 'package:flutter/material.dart';

class Medidas {
  static late MediaQueryData _mediaQueryData;
  static late double anchoPantalla;
  static late double altoPantalla;
  static late double medidaDefecto;
  static late Orientation orientacion;
  static late double alturaBarraEstado;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    anchoPantalla = _mediaQueryData.size.width;
    altoPantalla = _mediaQueryData.size.height;
    orientacion = _mediaQueryData.orientation;
    alturaBarraEstado = _mediaQueryData.padding.top;
  }
}

double getProporcionAlturaPantalla(double alturaIngresada) {
  double altoPantalla = Medidas.altoPantalla;
  return (alturaIngresada / 812.0) * altoPantalla;
}

double getProporcionAnchoPantalla(double anchoIngresado) {
  double anchoPantalla = Medidas.anchoPantalla;
  return (anchoIngresado / 375.0) * anchoPantalla;
}

double get anchoPantalla => Medidas.anchoPantalla;

double get altoPantalla => Medidas.altoPantalla;

double get barraEstadoAltura => Medidas.alturaBarraEstado;

get orientacion => Medidas.orientacion;

enum OrientacionE { vertical, horizontal }
