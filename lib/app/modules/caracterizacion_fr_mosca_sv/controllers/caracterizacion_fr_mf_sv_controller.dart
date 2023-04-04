import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/caracterizacion_fr_mosca_sv/caracterizacion_fr_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';
import 'package:agro_servicios/app/data/repository/caracterizacion_fr_mf_sv_repository.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';

class CaracterizacionFrMfSvController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  TabController? tabController;

  List<LocalizacionModelo> provincia1 = [];
  List<LocalizacionCatalogo> catalogoLocalizacion = [];
  CaracterizacionFrMfSvModelo caracterizacionModelo =
      CaracterizacionFrMfSvModelo();

  int index = 0;
  int _provinciaBajada1 = 0;
  bool? verFab;
  String mensajeRespuesta = '';
  String _estadoBajada = '';

  var mensajeBajarDatos = 'Sincronizando...'.obs;
  var mensajeSubirDatos = 'Sincronizando...'.obs;

  var validandoBajada = true.obs;
  var validandoSubida = true.obs;
  var cantidadCaracterizacion = 0.obs;

  final CaracterizacionFrMfSvRepository _caracterizacionRepository =
      Get.find<CaracterizacionFrMfSvRepository>();

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController!.animation!.addListener(cambioVistaTab);
    obtenerCantidadRegistroscaracterizacion();
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

  get provinciaSincronizacion => _provinciaBajada1;
  get estadoBajada => _estadoBajada;

  set setProvincia(int provincia) => _provinciaBajada1 = provincia;

  void cambioVistaTab() {
    final valorAnimacion = tabController!.animation!.value;

    if (valorAnimacion > 1.5 && index <= 3) {
      if (index != 2) {
        index = 2;
        verFab = true;
        update(['fab']);
      }
    } else if (valorAnimacion >= 0.5 && index <= 2) {
      if (index != 1) {
        index = 1;
        verFab = true;
        update(['fab']);
      }
    } else if (valorAnimacion <= 0.5 && index > 0) {
      if (index != 0) {
        index = 0;
        verFab = false;
        update(['fab']);
      }
    }
  }

  void obtenerTodasProvincias() async {
    provincia1 = await _caracterizacionRepository.getTodasProvincias();
    update();
  }

  Future obtenerCantidadRegistroscaracterizacion() async {
    var res = await _caracterizacionRepository.getCantidadCaracterizacion();
    cantidadCaracterizacion.value = res[0]['cantidad'];
  }

  void iniciarValidacion({String? mensaje}) {
    validandoBajada.value = true;
    mensajeBajarDatos.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeBajarDatos.value = mensaje;
  }

  Future<void> bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    await obtenerCantidadRegistroscaracterizacion();
    if (cantidadCaracterizacion <= 0) {
      _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
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
    iniciarValidacion();

    int tiempo = 4;

    mostrarModalBottomSheet(
      titulo: titulo,
      mensaje: mensaje,
      icono: icono,
    );

    await Future.delayed(const Duration(seconds: 1));
    final RespuestaProvider res = await ejecutarConsulta(() async {
      return await _caracterizacionRepository
          .getCatalogoLocalizacion(_provinciaBajada1);
    });

    if (res.estado != 'error') {
      if (res.cuerpo.length > 0) {
        res.cuerpo.forEach((provincia) async {
          tiempo = 2;
          mensajeRespuesta = 'Se sincronizó el catálogo de la provincia';
          await _caracterizacionRepository.eliminarProvinciaSincronizada();
          await _caracterizacionRepository.eliminarCaracterizacion();
          await obtenerCantidadRegistroscaracterizacion();
          provincia.cantonlist?.forEach((canton) async {
            await _caracterizacionRepository
                .guardarLocalizacionCatalogo(canton);
            canton.parroquialist?.forEach((parroquia) async {
              await _caracterizacionRepository
                  .guardarLocalizacionCatalogo(parroquia);
            });
          });
        });
        await _caracterizacionRepository
            .guardarProvinciaSincronizada(res.cuerpo[0]);
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
    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 4));
    Get.back();
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget mensaje,
      required Widget icono,
      required CaracterizacionFrMfSvModelo propietario,
      required CaracterizacionFrMfSvModelo ubicacion,
      required CaracterizacionFrMfSvModelo cultivo}) async {
    Random random = Random();
    UsuarioModelo usuario = await _caracterizacionRepository.getUsuario();
    int tiempo = 4;
    String mensajeRespuesta = '';

    iniciarValidacion(mensaje: 'Almacenando...');

    mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

    await Future.delayed(const Duration(seconds: 1));

    try {
      caracterizacionModelo = CaracterizacionFrMfSvModelo(
          nombreAsociacionProductor: propietario.nombreAsociacionProductor,
          identificador: propietario.identificador,
          telefono: propietario.telefono,
          codigoProvincia: ubicacion.codigoProvincia,
          provincia: ubicacion.provincia,
          codigoCanton: ubicacion.codigoCanton,
          canton: ubicacion.canton,
          codigoParroquia: ubicacion.codigoParroquia,
          parroquia: ubicacion.parroquia,
          coordenadaX: ubicacion.coordenadaX,
          coordenadaY: ubicacion.coordenadaY,
          coordenadaZ: ubicacion.coordenadaZ,
          sitio: ubicacion.sitio,
          imagen: ubicacion.imagen,
          especie: cultivo.especie,
          variedad: cultivo.variedad,
          areaProduccionEstimada: cultivo.areaProduccionEstimada,
          observaciones: cultivo.observaciones,
          usuarioId: usuario.identificador,
          usuario: usuario.nombre,
          idTablet: (random.nextInt(90) + 1),
          fechaInspeccion: DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(DateTime.now())
              .toString(),
          tabletId: usuario.identificador,
          tabletVersionBase: SCHEMA_VERSION);
      await _caracterizacionRepository
          .guardarCaracterizacion(caracterizacionModelo);
      tiempo = 2;
      mensajeRespuesta = 'Registros almacenados';
    } catch (e) {
      validandoBajada.value = false;
      mensajeRespuesta = 'Error: $e';
    }

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
    Get.back();
  }

  Future<void> subirDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    late List<CaracterizacionFrMfSvModelo> listaCaracterizacion;
    bool error = false;
    int tiempo = 4;
    String mensajeRespuesta = '';
    Map<String, dynamic> datosPost = {
      "detalle": [],
    };

    List<String> pathImagenes = [];

    if (cantidadCaracterizacion > 0) {
      iniciarValidacion();

      mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

      await Future.delayed(const Duration(seconds: 1));

      try {
        listaCaracterizacion =
            await _caracterizacionRepository.getCaracterizacionTodos();

        if (listaCaracterizacion.isNotEmpty) {
          for (var e in listaCaracterizacion) {
            if (e.imagen != null) {
              pathImagenes.add(e.imagen!);
              e.imagen = await base64Archivo(e.imagen);
            }
          }
          datosPost["detalle"] = listaCaracterizacion;
        }
      } catch (e) {
        mensajeRespuesta = 'Error al preparar datos: $e';
        error = true;
      }

      if (!error) {
        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _caracterizacionRepository.sincronizarUp(datosPost);
        });

        if (res.estado == 'exito') {
          tiempo = 3;
          await _caracterizacionRepository.eliminarCaracterizacion();
          await obtenerCantidadRegistroscaracterizacion();
          eliminarArchivos(pathImagenes);
        }

        if (res.mensaje!.contains('ERROR:')) {
          var split = res.mensaje!.split("ERROR:");
          mensajeRespuesta = 'Error servidor:${split[1]}';
        } else {
          mensajeRespuesta = res.mensaje!;
        }
        _estadoBajada = res.estado!;
      }

      finalizarValidacion(mensajeRespuesta);
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
