import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_incumplimiento_control_sv_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/repository/embalaje_control_sv_repository.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/common/comunes.dart';

class EmbalajeControlSvController extends GetxController
    with GetSingleTickerProviderStateMixin, ControladorBase {
  final EmbalajeControlSvRepository _embalajeRepository =
      Get.find<EmbalajeControlSvRepository>();

  List<LocalizacionModelo> provincia1 = [];
  List<LocalizacionCatalogo> catalogoLocalizacion = [];
  final EmbalajeControlModelo embalajeModelo = EmbalajeControlModelo();

  final EmbalajeControlLaboratorioSvModelo laboratorioModelo =
      EmbalajeControlLaboratorioSvModelo();

  int _provinciaBajada1 = 0;
  RxString mensajeBajarDatos = 'Sincronizando...'.obs;
  RxString mensajeSubirDatos = 'Sincronizando...'.obs;
  RxBool validandoBajada = true.obs;
  RxBool validandoSubida = true.obs;
  RxInt cantidadEmbalaje = 0.obs;
  String mensajeRespuesta = '';
  String estadoBajada = '';
  TabController? tabController;
  bool tieneMuestra = false;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    tabController!.animation!.addListener(cambioVistaTab);
    obtenerCantidadRegistrosEmbalaje();
    super.onInit();
  }

  @override
  void onClose() {
    tabController?.removeListener(cambioVistaTab);
    tabController?.dispose();
    super.onClose();
  }

  set setProvincia(int provincia) => _provinciaBajada1 = provincia;

  get provinciaSincronizacion => _provinciaBajada1;

  set setTieneMuestra(bool valor) {
    tieneMuestra = valor;
    update(['fab']);
  }

  int index = 0;
  bool? verFab;
  void cambioVistaTab() {
    final valorAnimacion = tabController!.animation!.value;
    if (valorAnimacion >= 2.5) {
      if (index != 3) {
        index = 3;
        verFab = true;
        update(['fab']);
      }
    } else if (valorAnimacion <= 2.5 && valorAnimacion > 1.5) {
      if (index != 2) {
        index = 2;
        verFab = true;
        update(['fab']);
      }
    } else if (valorAnimacion < 1.5) {
      if (index != 0) {
        index = 0;
        verFab = false;
        update(['fab']);
      }
    }
  }

  Future obtenerCantidadRegistrosEmbalaje() async {
    var res = await _embalajeRepository.getCantidadRegistros();
    cantidadEmbalaje.value = res[0]['cantidad'];
  }

  void iniciarValidacion({String? mensaje}) {
    validandoBajada.value = true;
    mensajeBajarDatos.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeBajarDatos.value = mensaje;
  }

  void finalizarValidacionSubida(String mensaje) {
    validandoSubida.value = false;
    mensajeSubirDatos.value = mensaje;
  }

  Future<void> bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    await obtenerCantidadRegistrosEmbalaje();

    if (cantidadEmbalaje <= 0) {
      await _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
    } else {
      mensajeBajarDatos.value = REGISTROS_PENDIENTES;

      estadoBajada = 'advertencia';
      validandoBajada.value = false;
      mostrarModalBottomSheet(
        titulo: SINCRONIZACION_PENDIENTES,
        mensaje: mensaje,
        icono: icono,
        mostrarBotones: true,
        alto: 280,
        bajarDatos: () async {
          Get.back();
          await _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
        },
      );
    }
  }

  Future<void> _bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    int tiempo = 3;

    iniciarValidacion();

    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 1));
    final RespuestaProvider resPuertos = await ejecutarConsulta(() async {
      return await _embalajeRepository.getPuertos();
    });

    final RespuestaProvider resPaises = await ejecutarConsulta(() async {
      return await _embalajeRepository.getPaises();
    });

    final usuario = await _embalajeRepository.getsusuario();

    final RespuestaProvider resProvincia = await ejecutarConsulta(() async {
      return await _embalajeRepository
          .getUbicacionContrato(usuario!.identificador!);
    });

    estadoBajada = resPuertos.estado!;

    if (resPuertos.estado == 'exito' && resProvincia.estado == 'exito') {
      if (resPuertos.cuerpo.length > 0) {
        await _embalajeRepository.eliminarPuertos();
        await _embalajeRepository.eliminarLugarInspeccion();

        resPuertos.cuerpo.forEach((puerto) async {
          tiempo = 2;
          try {
            mensajeRespuesta = 'Se sincronizó el catálogo de países y puertos';
            await _embalajeRepository.guardarPuerto(puerto);
            final PuertosCatalogoModelo puertos = puerto;

            puertos.lugarinspeccion?.forEach((lugarInspeecion) async {
              await _embalajeRepository.guardarLugarInspeccion(lugarInspeecion);
            });
          } catch (e) {
            estadoBajada = 'error';
            mensajeRespuesta = 'Error al guardar datos';
          }
        });
      } else {
        estadoBajada = 'error';
        mensajeRespuesta = 'No existen datos para sincronizar';
      }

      if (resPaises.estado == 'exito') {
        if (resPaises.cuerpo.length > 0) {
          final List<LocalizacionCatalogo> lista = resPaises.cuerpo;
          for (var localizacion in lista) {
            await _embalajeRepository.guardarPais(localizacion);
          }
        }
      }

      if (resProvincia.estado == 'exito') {
        ProvinciaUsuarioContratoModelo provincia = resProvincia.cuerpo;
        if (provincia.provincia != null) {
          await _embalajeRepository.eliminarProvinciaContrato();
          await _embalajeRepository.guardarProvinciaContrato(provincia);
        }
      }
    } else {
      estadoBajada = 'error';

      if (resPuertos.estado == 'error') {
        mensajeRespuesta = resPuertos.mensaje!;
      } else if (resProvincia.estado == 'error') {
        mensajeRespuesta = resProvincia.mensaje!;
      }
    }

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }

  Future<void> guardarFormulario({
    required String titulo,
    required Widget mensaje,
    required Widget icono,
  }) async {
    int tiempo = 4;
    String mensajeRespuesta = '';

    iniciarValidacion(mensaje: 'Almacenando...');

    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 1));

    try {
      final usuario = await _embalajeRepository.getsusuario();

      embalajeModelo.usuario = usuario!.nombre;
      embalajeModelo.usuarioId = usuario.identificador;
      embalajeModelo.fechaCreacion = DateTime.now().toString();
      embalajeModelo.tabletVersionBase = SCHEMA_VERSION;
      embalajeModelo.tabletId = usuario.identificador;
      embalajeModelo.idTablet =
          await _embalajeRepository.getSecuenciaEmbalaje();

      final res =
          await _embalajeRepository.guardarRegistroEmbalaje(embalajeModelo);
      laboratorioModelo.controlF03Id = res;
      laboratorioModelo.idTablet =
          await _embalajeRepository.getSecuenciaLaboratorio();

      if (Get.find<EmbalajeIncumplimientoControlSvController>()
          .listaLaboratorio
          .isNotEmpty) {
        await _embalajeRepository
            .guardarRegistroLaboratorioEmbalaje(laboratorioModelo);
      }

      tiempo = 2;
      mensajeRespuesta = 'Registros almacenados';
      estadoBajada = 'exito';
    } catch (e) {
      debugPrint('$e');
      estadoBajada = 'error';
      validandoBajada.value = false;
      mensajeRespuesta = 'Error: $e';
    }

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
    if (estadoBajada == 'exito') Get.back();
  }

  Future subirDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    late List<EmbalajeControlModelo> listaEmbalaje;
    late List<EmbalajeControlLaboratorioSvModelo> listaOrdenes;

    bool error = false;
    int tiempo = 3;

    Map<String, dynamic> datosPost = {
      "embalaje": [],
      "ordenes": [],
    };

    if (cantidadEmbalaje.value > 0) {
      iniciarValidacion();

      mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

      await Future.delayed(const Duration(seconds: 1));

      try {
        listaEmbalaje = await _embalajeRepository.getInspecciones();
        listaOrdenes = await _embalajeRepository.getOrdenesLaboratorio();

        if (listaEmbalaje.isNotEmpty) {
          datosPost["embalaje"] = listaEmbalaje;
          debugPrint("embalajes preparados");
        }

        if (listaOrdenes.isNotEmpty) {
          datosPost["ordenes"] = listaOrdenes;
          debugPrint("ordenes de laboratorio preparadas");
        }

        mensajeRespuesta = 'exito sin errores';
        estadoBajada = 'exito';
      } catch (e) {
        debugPrint('Error al preparar datos: $e');
        mensajeRespuesta = 'Error al preparar datos: $e';
        estadoBajada = 'error';
        error = true;
      }

      if (!error) {
        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _embalajeRepository.sincronizarUp(datosPost);
        });

        mensajeRespuesta = res.mensaje!;

        if (res.estado == 'exito') {
          tiempo = 3;
          await _embalajeRepository.eliminarRegistrosEmbalaje();
          await _embalajeRepository.eliminarOrdenesLaboratorio();
          await obtenerCantidadRegistrosEmbalaje();
        } else {
          estadoBajada = 'error';
        }

        if (res.mensaje!.contains('ERROR:')) {
          var split = res.mensaje!.split("ERROR:");
          mensajeRespuesta = 'Error servidor:${split[1]}';
          estadoBajada = 'error';
        }
      }

      finalizarValidacion(mensajeRespuesta);
    } else {
      mensajeBajarDatos.value = SIN_REGISTROS;
      tiempo = 4;
      estadoBajada = 'advertencia';
      validandoBajada.value = false;
      mostrarModalBottomSheet(
          titulo: SIN_DATOS, mensaje: mensaje, icono: icono);
    }

    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }
}
