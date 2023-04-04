import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_form_sv_controller.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:get/get.dart';

///Controlador solo para manejar los tabs de Formulario
///Relacionada con Pagr trip_form_sv
class TripsPaso2Controller extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final controlador = Get.find<TripsFormSvController>();

  RxList<PreguntasModelo> listaPreguntasModelo = <PreguntasModelo>[].obs;
  RxList<RespuestasModelo> listaRespuestasModelo = <RespuestasModelo>[].obs;

  @override
  void onReady() {
    seleccionaPreguntasTipArea();
    super.onReady();
  }

  limpiaPreguntas() {
    update(["preguntas"]);
  }

  ///Establece las preguntas segun el tipo de area seleccionado
  seleccionaPreguntasTipArea() async {
    //Evalua si ha selecionado tipo de area.
    if (controlador.modelo.tipoArea != '' &&
        controlador.modelo.tipoArea != null) {
      //Buscar si ya guardamos las preguntas y si ha cambiado el tipo de area.
      listaRespuestasModelo.value = await controlador.getRespuestas(
          controlador.idFormulario, controlador.modelo.numeroReporte);

      if (listaRespuestasModelo.isNotEmpty) {
        //Borra Preguntas si las areas son diferentes y crear
        String area = listaRespuestasModelo[0].tipoArea.toString();
        if (area != controlador.modelo.tipoArea) {
          controlador.deleteRespuestas(
              controlador.idFormulario, controlador.modelo.numeroReporte);
          preguntasNuevo();
        } else {
          preguntasCargar();
        }
      } else {
        //Nuevo
        preguntasNuevo();
      }
    }
    update(["preguntas"]);
  }

  ///Establece las preguntas segun el tipo de area seleccionado
  preguntasCargar() async {
    // var idx = 0;
    bool val = false;
    var valor = "No";
    listaRespuestasModelo.value = await controlador.getRespuestas(
        controlador.idFormulario, controlador.modelo.numeroReporte);

    for (var e in listaRespuestasModelo) {
      valor = e.respuesta!;
      if (valor == "Si") {
        val = true;
      } else {
        val = false;
      }
      e.isFavorite = val;
    }
  }

  ///Nuevo -Guarda las respuestas
  preguntasNuevo() async {
    //Busca  preguntas le corresponden segun el tipo de area.
    List<PreguntasModelo> list = await controlador.getPreguntasParaFormulario(
        controlador.idFormulario, controlador.modelo.tipoArea);

    //Carga las preguntas en las respuestas
    for (var e in list) {
      RespuestasModelo modeloRespuesta = RespuestasModelo();
      modeloRespuesta.idPregunta = e.id;
      modeloRespuesta.formulario = e.formulario;
      modeloRespuesta.tipoArea = e.tipoArea;
      modeloRespuesta.orden = e.orden;
      modeloRespuesta.pregunta = e.pregunta;
      modeloRespuesta.puntos = e.puntos;
      modeloRespuesta.tab = e.tab;
      modeloRespuesta.tipo = e.tipo;
      modeloRespuesta.modoVisualizar = e.modoVisualizar;
      modeloRespuesta.fecha = e.fecha;
      modeloRespuesta.estado = e.estado;
      modeloRespuesta.tipoDato = e.tipoDato;
      modeloRespuesta.obligatorio = e.obligatorio;
      modeloRespuesta.opcionesRespuesta = e.opcionesRespuesta;
      modeloRespuesta.numeroReporte =
          controlador.modelo.numeroReporte; //Numero de Reporte del Formulario
      modeloRespuesta.respuesta = "No";
      controlador.saveRespuesta(modeloRespuesta);
    }
    //Carga las Preguntas
    listaRespuestasModelo.value = await controlador.getRespuestas(
        controlador.idFormulario, controlador.modelo.numeroReporte);
  }

  onFavorite(int index, isFavorito) async {
    String dicotomia;
    if (isFavorito) {
      dicotomia = 'Si';
    } else {
      dicotomia = 'No';
    }
    var idRespuesta = listaRespuestasModelo[index].id;
    listaRespuestasModelo[index].respuesta = dicotomia;
    listaRespuestasModelo[index].isFavorite = isFavorito;

    controlador.actualizarRespuestasModelo(idRespuesta, dicotomia);

    update(["preguntas"]);
  }
}
