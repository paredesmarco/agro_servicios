import 'package:flutter/cupertino.dart';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:flutter/material.dart';

class EstilosTextos {
  static const titulo =
      TextStyle(color: Colores.TituloFormulario, fontSize: 17);

  static const radioYcheckbox = TextStyle(color: Colores.radio_chechbox);

  static const errorTexto = TextStyle(color: Colores.errorTexto, fontSize: 12);

  static const textoEtiquetasCards = TextStyle(
      color: Colores.radio_chechbox, fontSize: 12, fontWeight: FontWeight.w500);

  static const textoDescripcionCard =
      TextStyle(color: Color(0XFF9A9EA0), fontSize: 12);

  static const etiquetasInputs =
      TextStyle(fontSize: 13, color: Color(0XFF9E9E9E));

  static const tituloTarjetas = TextStyle(
      color: Colores.TituloFormulario,
      fontSize: 14,
      fontWeight: FontWeight.w500);

  static const tituloPopUp = TextStyle(
      color: Colores.TituloFormulario,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  static const textosBotonPopupEtiqueta =
      TextStyle(color: Color(0xFF6e7579), fontSize: 12);

  static const textosBotonPopupContenido = TextStyle(color: Color(0xFFa2abae));

  static const textoEtiquetasInfo = TextStyle(
      color: Colores.radio_chechbox, fontSize: 13, fontWeight: FontWeight.w600);

  static const textoDescripcionInfo =
      TextStyle(color: Color(0XFF9A9EA0), fontSize: 13);
}
