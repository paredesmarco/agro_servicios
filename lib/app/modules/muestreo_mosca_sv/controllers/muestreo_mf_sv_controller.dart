import 'dart:async';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_laboratorio_controller.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/muestreo_mf_sv_repository.dart';
import 'package:agro_servicios/app/utils/codigo_trampa.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';

class MuestreoMfSvController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  List<LocalizacionModelo> provincia1 = [];
  List<LocalizacionCatalogo> catalogoLocalizacion = [];
  List<MuestreoMfSvLaboratorioModeo> modeloLaboratorio = [];

  final MuestreoMfSvRepository _muestreoRepository =
      Get.find<MuestreoMfSvRepository>();

  int _provinciaBajada1 = 0;
  var mensajeBajarDatos = 'Sincronizando...'.obs;
  var mensajeSubirDatos = 'Sincronizando...'.obs;
  var validandoBajada = true.obs;
  var validandoSubida = true.obs;
  var cantidadMuestreo = 0.obs;
  String mensajeRespuesta = '';
  String _estadoBajada = '';
  TabController? tabController;

  set setProvincia(int provincia) => _provinciaBajada1 = provincia;

  get provinciaSincronizacion => _provinciaBajada1;
  get estadoBajada => _estadoBajada;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController!.animation!.addListener(cambioVistaTab);
    obtenerCantidadRegistrosMuestreo();
    super.onInit();
  }

  @override
  void onReady() {
    obtenerTodasProvincias();
    super.onReady();
  }

  @override
  void onClose() {
    tabController?.removeListener(cambioVistaTab);
    tabController?.dispose();
    super.onClose();
  }

  int index = 0;
  bool? verFab;
  void cambioVistaTab() {
    final aniValue = tabController!.animation!.value;
    if (aniValue >= 0.5) {
      if (index != 1) {
        index = 1;
        verFab = true;
        update(['fab']);
      }
    } else if (aniValue <= 0.5 && index > 0) {
      if (index != 0) {
        index = 0;
        verFab = false;
        update(['fab']);
      }
    }
  }

  void obtenerTodasProvincias() async {
    provincia1 = await _muestreoRepository.getTodasProvincias();
    update();
  }

  Future obtenerCantidadRegistrosMuestreo() async {
    var res = await _muestreoRepository.getCantidadMuestreo();
    cantidadMuestreo.value = res[0]['cantidad'];
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
    await obtenerCantidadRegistrosMuestreo();
    if (cantidadMuestreo <= 0) {
      await _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
    } else {
      mensajeBajarDatos.value = REGISTROS_PENDIENTES;

      _estadoBajada = 'advertencia';
      validandoBajada.value = false;
      mostrarModalBottomSheet(
        titulo: SINCRONIZACION_PENDIENTES,
        mensaje: mensaje,
        icono: icono,
        mostrarBotones: true,
        alto: 280,
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
    final RespuestaProvider res = await ejecutarConsulta(() async {
      return await _muestreoRepository
          .getCatalogoLocalizacion(_provinciaBajada1);
    });

    if (res.estado != 'error') {
      if (res.cuerpo.length > 0) {
        res.cuerpo.forEach((provincia) async {
          tiempo = 2;
          mensajeRespuesta = 'Se sincronizó el catálogo de la provincia';
          await _muestreoRepository.eliminarProvinciaSincronizada();
          provincia.cantonlist?.forEach((canton) async {
            await _muestreoRepository.guardarLocalizacionCatalogo(canton);
            canton.parroquialist?.forEach((parroquia) async {
              await _muestreoRepository.guardarLocalizacionCatalogo(parroquia);
            });
          });
        });
        await _muestreoRepository.guardarProvinciaSincronizada(res.cuerpo[0]);
        await _muestreoRepository.eliminarMuestreo();
        await _muestreoRepository.eliminarOrdenesLaboratorio();
        await obtenerCantidadRegistrosMuestreo();
      } else {
        mensajeRespuesta = 'No existen datos para sincronizar';
      }
    } else {
      mensajeRespuesta = res.mensaje!;
    }

    _estadoBajada = res.estado!;

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }

  Future<void> sinProvincias(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    Get.bottomSheet(Modal(titulo: titulo, mensaje: mensaje, icono: icono),
        shape: Modal.borde(),
        isDismissible: false,
        isScrollControlled: false,
        enableDrag: false);

    await Future.delayed(const Duration(seconds: 4));
    Get.back();
  }

  void eliminarOrdenLaboratorio(index) {
    modeloLaboratorio.removeAt(index);
    modeloLaboratorio.asMap().forEach((index, e) {
      e.codigoMuestra = generarCodigoMuestra(
        secuencia: index,
        provincia: 'Pichincha',
        fechaInicial:
            Get.find<MuestreoMfSvLaboratorioController>().fechaOrdenLaboratorio,
        codigoFormulario: 'MF',
      );
    });

    Get.find<MuestreoMfSvLaboratorioController>().cantidadOrdenes--;
    if (Get.find<MuestreoMfSvLaboratorioController>().cantidadOrdenes < 1) {
      Get.find<MuestreoMfSvLaboratorioController>().fechaOrdenLaboratorio = '';
    }
  }

  bool validarOrden() {
    bool esValido = true;
    if (modeloLaboratorio.isEmpty) esValido = false;
    return esValido;
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget mensaje,
      required Widget icono,
      required MuestreoMfSvModelo muestreo}) async {
    for (var e in modeloLaboratorio) {
      e.idTablet = muestreo.idTablet;
    }

    String mensajeValidacion = '';
    int tiempo = 4;

    iniciarValidacion(mensaje: 'Almacenando...');

    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 1));

    try {
      await _muestreoRepository.guardarMuestreo(muestreo, modeloLaboratorio);
      mensajeValidacion = 'Registros almacenados';
      tiempo = 2;
    } catch (e) {
      debugPrint('$e');
      validandoBajada.value = false;
      mensajeValidacion = 'Error: $e';
    }

    finalizarValidacion(mensajeValidacion);

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
    Get.back();
  }

  Future<void> subirDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    late List<MuestreoMfSvModelo> listaMuestreo;
    late List<MuestreoMfSvLaboratorioModeo> listaLaboratorio;
    bool error = false;
    int tiempo = 4;
    String mensajeRespuesta = '';
    Map<String, dynamic> datosPost = {
      "detalle": [],
      "ordenes": [],
    };

    List<String> pathImagenes = [];

    if (cantidadMuestreo > 0) {
      iniciarValidacion();

      mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

      await Future.delayed(const Duration(seconds: 1));

      try {
        listaMuestreo = await _muestreoRepository.getMuesteoTodos();
        listaLaboratorio = await _muestreoRepository.getLaboratoriosTodos();

        if (listaMuestreo.isNotEmpty) {
          for (var e in listaMuestreo) {
            if (e.imagen != null) {
              pathImagenes.add(e.imagen!);
              e.imagen = await base64Archivo(e.imagen);
            }
          }
          datosPost["detalle"] = listaMuestreo;
          debugPrint("muestreo preparado");
        }

        if (listaLaboratorio.isNotEmpty) {
          datosPost["ordenes"] = listaLaboratorio;
          debugPrint("ordenes de laboratorio preparadas");
        } else {
          datosPost["ordenes"] = [];
        }
      } catch (e) {
        debugPrint('Error al preparar datos: $e');
        mensajeRespuesta = 'Error al preparar datos: $e';
        error = true;
      }

      if (!error) {
        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _muestreoRepository.sincronizarUp(datosPost);
        });

        if (res.estado == 'exito') {
          tiempo = 3;
          await _muestreoRepository.eliminarMuestreo();
          await _muestreoRepository.eliminarOrdenesLaboratorio();
          await obtenerCantidadRegistrosMuestreo();
          eliminarArchivos(pathImagenes);
        }

        if (res.mensaje!.contains('ERROR:')) {
          var split = res.mensaje!.split("ERROR:");
          mensajeRespuesta = 'Error servidor:${split[1]}';
        } else {
          mensajeRespuesta = res.mensaje!;
        }

        _estadoBajada = res.estado!;

        finalizarValidacion(mensajeRespuesta);
      }
    } else {
      mensajeBajarDatos.value = SIN_REGISTROS;
      tiempo = 4;
      _estadoBajada = 'advertencia';
      validandoBajada.value = false;
      mostrarModalBottomSheet(
          titulo: SIN_DATOS, mensaje: mensaje, icono: icono);
    }
    await Future.delayed(Duration(seconds: tiempo));
    Get.back();
  }
}
