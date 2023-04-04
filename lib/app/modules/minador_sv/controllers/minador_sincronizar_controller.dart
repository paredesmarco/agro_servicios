import 'package:agro_servicios/app/data/models/minador_sv/minador_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_sitio_modelo.dart';
import 'package:agro_servicios/app/data/repository/minador_sv_repository.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/ponderacion_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinadorSincronizarController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final _minadorRepositorio = Get.find<MinadorRepository>();

  RxList<LocalizacionModelo> listaProvincias = <LocalizacionModelo>[].obs;

  int _productoresBajados = 0;
  int _sitiosBajados = 0;
  int _preguntasBajados = 0;
  int _ponderacionBajados = 0;
  int nFormularios = 0;
  String provinciaUsuario = '';
  String errorProvincia = '';
  String idFormulario = 'APL_PRO_MINADOR';

  var mensajeSincronizacion = 'Sincronizando...'.obs;
  var validandoSincronizacion = false.obs;
  var estadoSincronizacion = ''.obs;

  @override
  void onInit() {
    getProvinciaUsuario();
    super.onInit();
  }

  @override
  void onReady() {
    getProvinciaUsuario();
    getInspecciones();
    super.onReady();
  }

  void _iniciarSincronizacion({String? mensaje}) {
    validandoSincronizacion.value = true;
    mensajeSincronizacion.value = mensaje ?? 'Validando...';
  }

  void _finalizarSincronizacion(String mensaje) {
    validandoSincronizacion.value = false;
    mensajeSincronizacion.value = mensaje;
  }

  Future<void> getProvinciaUsuario() async {
    ProvinciaUsuarioContratoModelo? provinciaModelo =
        await _minadorRepositorio.obtenerProvinciaContrato();

    if (provinciaModelo != null) {
      provinciaUsuario = provinciaModelo.provincia!;
    }
    validaDatos;
    update(['localizacion']);
  }

  Future<void> getInspecciones() async {
    List<MinadorModelo> inspecciones =
        await _minadorRepositorio.getMinadorListaCompleto(idFormulario);
    nFormularios = inspecciones.length;
    update(['localizacion', 'registros']);
  }

  ///Subir datos
  subirDatos(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    //Variables

    estadoSincronizacion.value = 'error';
    bool error = false;
    _iniciarSincronizacion(mensaje: 'Subir Información de las Inspecciones');
    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    if (nFormularios > 0) {
      Map<String, dynamic> datosPost = {
        "detalle": [],
      };

      try {
        List<MinadorModelo> inspecciones =
            await _minadorRepositorio.getMinadorListaCompleto(idFormulario);

        List<RespuestasAreasModelo> listaAreas = [];
        List<RespuestasModelo> listaRespuestas = [];

        if (inspecciones.isNotEmpty) {
          datosPost['detalle'] = inspecciones;
          for (int n = 0; n < inspecciones.length; n++) {
            listaAreas = await _minadorRepositorio.getIdAreasParaFormulario(
                idFormulario, inspecciones[n].numeroReporte);
            inspecciones[n].listaAreas = listaAreas;
            listaRespuestas =
                await _minadorRepositorio.getRespuestasParaFormulario(
                    idFormulario, inspecciones[n].numeroReporte);
            inspecciones[n].listaRespuestas = listaRespuestas;
          }
        }
      } catch (e) {
        _finalizarSincronizacion('Error al preparar los datos $e');
        estadoSincronizacion.value = 'error';
        await Future.delayed(const Duration(seconds: 4));
        error = true;
      }

      if (!error) {
        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _minadorRepositorio.saveUpMinador(datosPost);
        });
        if (res.estado == 'exito') {
          await _minadorRepositorio.deleteTodosInspecciones();
          await _minadorRepositorio.deleteTodosRespuestas(idFormulario);
          await _minadorRepositorio.deleteTodasIdAreas(idFormulario);

          _finalizarSincronizacion('Inspecciones Subidas: $nFormularios');
          estadoSincronizacion.value = 'exito';
          await Future.delayed(const Duration(seconds: 2));
        } else {
          if (res.mensaje!.contains('ERROR:')) {
            var split = res.mensaje!.split('ERROR:');
            _finalizarSincronizacion('Error ${res.mensaje}${split[1]}');
            await Future.delayed(const Duration(seconds: 4));
            estadoSincronizacion.value = 'error';
          }
          _finalizarSincronizacion('Error ${res.mensaje}');
          await Future.delayed(const Duration(seconds: 4));
          estadoSincronizacion.value = 'error';
        }
      }
    } else {
      _finalizarSincronizacion('No, tiene datos para subir.');
      await Future.delayed(const Duration(seconds: 4));
      estadoSincronizacion.value = 'error';
    }

    if (estadoSincronizacion.value == 'exito') {
      await Future.delayed(const Duration(seconds: 1));
      mensajeSincronizacion.value = 'Sincronizacion Completa';
      Get.offNamed(Rutas.HOME);
    } else {
      Get.offNamed(Rutas.MINADORSINCRONIZARSV);
    }
  }

  ///Sincroniza los catalos del formulario Minador: Productores y Sitios
  bajarDatos(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    bool val = validaDatos;
    _iniciarSincronizacion(mensaje: 'Descargando Información de Operadores');
    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    if (val == true) {
      if (nFormularios < 1) {
        //Productor
        _iniciarSincronizacion(
            mensaje: 'Descargando Información de Operadores');

        _minadorRepositorio.deleteProductoCatalago();

        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _minadorRepositorio
              .getProductorCatalogo(provinciaUsuario);
        });

        try {
          if (res.estado == 'exito') {
            List<MinadorProductorModelo> listProductoModelo = res.cuerpo;

            for (var modelo in listProductoModelo) {
              await _minadorRepositorio.saveProductorModelo(modelo);
            }
            _productoresBajados = listProductoModelo.length;
            _finalizarSincronizacion(
                'Operadores Descargados: $_productoresBajados');
            estadoSincronizacion.value = 'exito';
            await Future.delayed(const Duration(seconds: 3));
          } else {
            _finalizarSincronizacion('Ocurrió un error al bajar Productores');
            estadoSincronizacion.value = 'error';
            await Future.delayed(const Duration(seconds: 4));
          }
        } catch (e) {
          _finalizarSincronizacion(e.toString());
          estadoSincronizacion.value = 'error';
          await Future.delayed(const Duration(seconds: 4));
        }

        _iniciarSincronizacion(mensaje: 'Descargando Información de Sitios ');

        //Sitio
        _minadorRepositorio.deleteSitioCatalogo();
        final RespuestaProvider ress = await ejecutarConsulta(() async {
          return await _minadorRepositorio.getSitioCatalogo(provinciaUsuario);
        });

        try {
          if (ress.estado == 'exito') {
            List<MinadorSitioModelo> listSitioModelo = ress.cuerpo;

            for (var modelo in listSitioModelo) {
              await _minadorRepositorio.saveSitioModelo(modelo);
            }
            _sitiosBajados = listSitioModelo.length;
            _finalizarSincronizacion('Sitio Descargados: $_sitiosBajados');
            estadoSincronizacion.value = 'exito';
            await Future.delayed(const Duration(seconds: 3));
          } else {
            _finalizarSincronizacion('Ocurrió un error al bajar Sitio');
            estadoSincronizacion.value = 'error';
            await Future.delayed(const Duration(seconds: 4));
          }
        } catch (e) {
          _finalizarSincronizacion(e.toString());
          estadoSincronizacion.value = 'error';
          await Future.delayed(const Duration(seconds: 4));
        }
        /*
       * Preguntas y Ponderación 
      */

        /*
       * Preguntas
      */
        _iniciarSincronizacion(mensaje: 'Descargando Preguntas');
        // mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

        _minadorRepositorio.deletePreguntasSvCatalogo('APL_PRO_MINADOR');

        final RespuestaProvider resPr = await ejecutarConsulta(() async {
          return await _minadorRepositorio.getPreguntas('APL_PRO_MINADOR');
        });

        try {
          if (resPr.estado == 'exito') {
            List<PreguntasModelo> listPreguntaModelo = resPr.cuerpo;
            _preguntasBajados = listPreguntaModelo.length;
            for (var modelo in listPreguntaModelo) {
              await _minadorRepositorio.savePreguntasModelo(modelo);
            }

            _finalizarSincronizacion(
                'Preguntas Descargados: $_preguntasBajados');
            estadoSincronizacion.value = 'exito';
            await Future.delayed(const Duration(seconds: 2));
          } else {
            _finalizarSincronizacion('Ocurrió un error al bajar Preguntas');
            estadoSincronizacion.value = 'error';
            await Future.delayed(const Duration(seconds: 2));
          }
        } catch (e) {
          _finalizarSincronizacion(e.toString());
          estadoSincronizacion.value = 'error';
          await Future.delayed(const Duration(seconds: 2));
        }
        /*
       * Ponderación 
      */
        _iniciarSincronizacion(mensaje: 'Descargando Ponderacion');

        _minadorRepositorio.deletePonderacionSvCatalogo('APL_PRO_MINADOR');
        final RespuestaProvider resPo = await ejecutarConsulta(() async {
          return await _minadorRepositorio.getPonderacion('APL_PRO_MINADOR');
        });

        try {
          if (resPo.estado == 'exito') {
            List<PonderacionModelo> listPonderacionModelo = resPo.cuerpo;
            _ponderacionBajados = listPonderacionModelo.length;
            for (var modelo in listPonderacionModelo) {
              await _minadorRepositorio.savePonderacionModelo(modelo);
            }
            _finalizarSincronizacion(
                'Ponderacion Descargados: $_ponderacionBajados');
            estadoSincronizacion.value = 'exito';
            await Future.delayed(const Duration(seconds: 2));
          } else {
            _minadorRepositorio.deleteProductoCatalago();
            _minadorRepositorio.deleteSitioCatalogo();
            _minadorRepositorio.deletePreguntasSvCatalogo('APL_PRO_MINADOR');
            _finalizarSincronizacion(
                'Resultado automático pendiente de configurar');
            estadoSincronizacion.value = 'error';
            await Future.delayed(const Duration(seconds: 4));
          }
        } catch (e) {
          _finalizarSincronizacion(e.toString());
          estadoSincronizacion.value = 'error';
          await Future.delayed(const Duration(seconds: 2));
        }
      } else {
        _finalizarSincronizacion('Suba Los formularios Pendientes');
        estadoSincronizacion.value = 'error';
        await Future.delayed(const Duration(seconds: 2));
        update(['localizacion']);
      }
    } else {
      _finalizarSincronizacion('No existe los datos requeriodos');
      estadoSincronizacion.value = 'error';
      await Future.delayed(const Duration(seconds: 2));
      update(['localizacion']);
    }

    /*if (estadoSincronizacion.value == 'exito') {
      mensajeSincronizacion.value = 'Sincronizacion Completa';
      // Get.offNamed(Rutas.HOME);
    } else {
      Get.offNamed(Rutas.MINADORSINCRONIZARSV);
    }*/

    Get.back();
  }

  bool get validaDatos {
    bool esValido = true;

    if (provinciaUsuario == '') {
      errorProvincia =
          'El usuario, no tiene provincia asignada en su contrato.';
      esValido = false;
    } else {
      errorProvincia = '';
    }
    return esValido;
  }
}
