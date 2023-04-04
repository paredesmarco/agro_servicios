import 'package:agro_servicios/app/modules/trips/controllers/trips_paso1_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_form_sv_controller.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/ponderacion_modelo.dart';
import 'package:agro_servicios/app/data/repository/trips_sv_repository.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Controlador solo para manejar los tabs de Formulario
///Relacionada con Pagr trip_form_sv
class TripsPaso3Controller extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final tripsRepositorio = Get.find<TripsRepository>();

  final controlador = Get.find<TripsFormSvController>();
  final controladorP1 = Get.find<TripsPaso1Controller>();

  List<PonderacionModelo> listaPonderacionModelo = [];

  String? errorRepresentante;

  var mensajeGuardar = 'Guardar...'.obs;
  var validandoGuardar = false.obs;
  var estadoSincronizacion = ''.obs;
  final delayed = Debouncer(delay: const Duration(milliseconds: 10));

  get getObservaciones {
    if (controlador.modelo.observaciones != null) {
      return '${controlador.modelo.observaciones}';
    } else {
      return null;
    }
  }

  get getRepresentante {
    if (controlador.modelo.representante != null) {
      return '${controlador.modelo.representante}';
    } else {
      return null;
    }
  }

  setEstadoF09(valor) {
    controlador.modelo.estadoF09 = valor;
    controlador.actualizarCampo('estado_f09', valor);
  }

  setObservaciones(valor) {
    controlador.modelo.observaciones = valor;
    controlador.actualizarCampo('observaciones', valor);
  }

  setRepresentante(valor) {
    controlador.modelo.representante = valor;
    controlador.actualizarCampo('representante', valor);
  }

  setResultado(valor) {
    controlador.modelo.resultado = valor;
    controlador.actualizarCampo('resultado', valor);
  }

  setIdResultado(valor) {
    controlador.modelo.idPonderacion = valor;
    controlador.actualizarCampo('id_ponderacion', valor);
  }

  setTotalResultado(valor) {
    controlador.modelo.totalResultado = valor;
    controlador.actualizarCampo('total_resultado', valor);
  }

  setIdTablet(valor) {
    controlador.modelo.idTablet = valor;
    controlador.actualizarCampo('id_tablet', valor);
  }

  iniciarGuardar({String? mensaje}) {
    validandoGuardar.value = true;
    mensajeGuardar.value = mensaje ?? 'Guardar...';
  }

  finalizarGuardar(String mensaje) {
    validandoGuardar.value = false;
    mensajeGuardar.value = mensaje;
  }

  guardarObservacion(valor) {
    delayed(() {
      setObservaciones(valor);
      controlador.actualizarCampo('observaciones', valor);
    });
  }

  guardarRepresentante(valor) {
    delayed(() {
      setRepresentante(valor);
      controlador.actualizarCampo('representante', valor);
    });
  }

  guardarTripsDatos(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    iniciarGuardar(mensaje: 'Guardar Información de la Inspeccion');
    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    establecerResultado();

    if (validaDatosP3 && controladorP1.validaDatosFormulario) {
      //Guardar los n formulario por n areas

      // List<TripsSitioModelo> _lista = await controlador.listaAreasSeleccionadas(
      //     controlador.modelo.ruc,
      //     controlador.modelo.idSitioProduccion,
      //     controlador.modelo.observacionF09);

      iniciarGuardar(mensaje: 'Guardar inspeccion');
      mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

      //Actualiza el modelo y ya esta guardado.
      setEstadoF09('activo');
      setIdTablet(controlador.modelo.id);

      // controlador.actualizarModelo();
      await Future.delayed(const Duration(seconds: 3));

      finalizarGuardar(
          'Se guardo correctamente, su resultado determina: ${controlador.modelo.resultado}');
      estadoSincronizacion.value = 'exito';
      await Future.delayed(const Duration(seconds: 4));
    } else {
      finalizarGuardar('No se guardo el formulario, llene todos los datos');
      estadoSincronizacion.value = 'error';
      await Future.delayed(const Duration(seconds: 1));
    }

    if (estadoSincronizacion.value == 'exito') {
      mensajeGuardar.value = 'Se guardo Correctamente el formulario';
      controladorP1.limpiarDatos('Productor');
      Get.offAllNamed(Rutas.HOME);
    } else {
      update(["observaciones", "representante"]);
      Get.back();
    }
  }

  ///Establece el resultado automatico de la Inspección.
  Future<void> establecerResultado() async {
    int suma, ri, rf = 0;
    String resultadoFinal = '';
    int idResultado = 0;

    listaPonderacionModelo =
        await tripsRepositorio.getPonderacionParaFormulario(
            controlador.idFormulario, controlador.modelo.tipoArea.toString());

    suma = await controlador.getRespuestasPositivas(
        controlador.idFormulario, controlador.modelo.numeroReporte);

    for (var e in listaPonderacionModelo) {
      ri = (e.rinicial!);
      rf = (e.rfinal!);
      if (suma >= ri) {
        if (suma <= rf) {
          resultadoFinal = e.resultado!;
          idResultado = e.id!;
        }
      }
    }

    setResultado(resultadoFinal);
    setTotalResultado(suma);
    setIdResultado(idResultado);
  }

  bool get validaDatosP3 {
    bool esValido = true;

    if (controlador.modelo.representante == null ||
        controlador.modelo.representante == '') {
      errorRepresentante = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorRepresentante = null;
    }
    return esValido;
  }
}
