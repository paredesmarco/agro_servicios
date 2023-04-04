import 'dart:math';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_solicitud_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/seguimiento_cuarentenario_sv_repository.dart';
import 'package:agro_servicios/app/utils/codigo_trampa.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/controllers/controlador_base.dart';

class SeguimientoCuarentenarioSvController extends GetxController
    with GetSingleTickerProviderStateMixin, ControladorBase {
  final _seguimientoRepository =
      Get.find<SeguimientoCuarentenarioSvRepository>();

  RxList<SeguimientoCuarentenarioLaboratorioSvModelo> listaLaboratorio =
      <SeguimientoCuarentenarioLaboratorioSvModelo>[].obs;

  RxList<SeguimientoCuarentenarioProductoSvModelo> seguimientosSolicitudes =
      <SeguimientoCuarentenarioProductoSvModelo>[].obs;

  final SeguimientoCuarentenarioSvModelo seguimientoModelo =
      SeguimientoCuarentenarioSvModelo();

  RxString mensajeSincronizacion = 'Sincronizando...'.obs;
  RxBool validandoBajada = true.obs;
  RxInt cantidadSeguimientos = 0.obs;
  String mensajeRespuesta = '';
  String estadoSincronizacion = '';
  bool _envioMuestra = false;
  var cantidadOrdenes = 0.obs;
  String fechaOrdenLaboratorio = '';
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    tabController.animation?.addListener(cambioVistaTab);
    super.onInit();
  }

  @override
  void onReady() {
    obtenerCantidadRegistrosSeguimiento();
    super.onReady();
  }

  @override
  void onClose() {
    tabController.removeListener(cambioVistaTab);
    tabController.dispose();
    super.onClose();
  }

  int index = 0;
  bool? verFab;
  void cambioVistaTab() {
    final aniValue = tabController.animation!.value;
    if (aniValue >= 2.5) {
      if (index != 3) {
        index = 3;
        update(['fab']);
      }
    } else if (aniValue >= 1.5 && aniValue < 2.5) {
      if (index != 2) {
        index = 2;
        verFab = true;
        update(['fab']);
      }
    } else if (aniValue < 1.5) {
      if (index != 0) {
        index = 0;
        verFab = false;
        update(['fab']);
      }
    }
  }

  get envioMuestra => _envioMuestra;

  set envioMuestra(valor) {
    _envioMuestra = valor;
    update(['fab']);
  }

  void iniciarValidacion({String? mensaje}) {
    validandoBajada.value = true;
    mensajeSincronizacion.value = mensaje ?? DEFECTO_A;
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeSincronizacion.value = mensaje;
  }

  Future<void> eliminarOrdenLaboratorio(index) async {
    final provinciaContrato =
        await _seguimientoRepository.getProvinciaContrato();

    listaLaboratorio.removeAt(index);
    listaLaboratorio.asMap().forEach((index, e) {
      e.codigoMuestra = generarCodigoMuestra(
        secuencia: index,
        provincia: provinciaContrato?.provincia ?? '',
        fechaInicial: fechaOrdenLaboratorio,
        codigoFormulario: 'SCV',
      );
    });

    cantidadOrdenes--;
    if (cantidadOrdenes < 1) {
      fechaOrdenLaboratorio = '';
    }
  }

  Future obtenerCantidadRegistrosSeguimiento() async {
    var res = await _seguimientoRepository.getCantidadRegistrosSeguimientos();
    cantidadSeguimientos.value = res[0]['cantidad'];
  }

  Future<void> bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    await obtenerCantidadRegistrosSeguimiento();
    if (cantidadSeguimientos <= 0) {
      await _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
    } else {
      mensajeSincronizacion.value = REGISTROS_PENDIENTES;

      estadoSincronizacion = 'advertencia';
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

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));
    RespuestaProvider resSolicitudes = await ejecutarConsulta(() async {
      return await _seguimientoRepository
          .getSolicitudesSeguimientoCuarentenario();
    });

    RespuestaProvider resLocalizacion = await ejecutarConsulta(() async {
      return await _seguimientoRepository.getCatalogoLocalizacion(null);
    });

    if (resSolicitudes.estado == 'exito' && resLocalizacion.estado == 'exito') {
      final List<SeguimientoCuarentenarioSolicitudSvModelo> solicitudes =
          resSolicitudes.cuerpo;

      final List<LocalizacionCatalogo> localizacion = resLocalizacion.cuerpo;

      estadoSincronizacion = 'exito';

      if (solicitudes.isNotEmpty) {
        try {
          await _seguimientoRepository.eliminarSolicitudeProductos();
          await _seguimientoRepository.eliminarSolicitudes();
          await _seguimientoRepository.eliminarSolicitudAreasCuarentena();

          for (var e in solicitudes) {
            final List<SeguimientoCuarentenarioProductoSvModelo>? productos =
                e.solicitudProductos;
            final List<SeguimientoCuarentenarioAreaCuarentenaSvModelo>? areas =
                e.solicitudAreasCuarentena;

            int idSolicitud = await _seguimientoRepository
                .guardarSolicitudesSeguimientoCuarentenario(e);

            areas?.forEach((area) async {
              await _seguimientoRepository
                  .guardarSolicitudesAreasCuarentenaSeguimientoCuarentenario(
                      area);
            });

            productos?.forEach((producto) async {
              producto.idSolicitud = idSolicitud;
              await _seguimientoRepository
                  .guardarSolicitudesProductoSeguimientoCuarentenario(producto);
            });
          }
          mensajeRespuesta =
              'Se sincronizó el catálogo de localizaciones y las solicitudes de Seguimiento Cuarentenario de Sanida Vegetal';
        } catch (e) {
          tiempo = 4;
          estadoSincronizacion = 'error';
          mensajeRespuesta = 'Error al guardar datos';
        }
      } else {
        estadoSincronizacion = 'error';
        mensajeRespuesta = 'No existen datos para sincronizar';
      }

      if (localizacion.isNotEmpty) {
        for (var provincia in localizacion) {
          await _seguimientoRepository.guardarLocalizacionCatalogo(provincia);
          provincia.cantonlist?.forEach((canton) async {
            await _seguimientoRepository.guardarLocalizacionCatalogo(canton);
            canton.parroquialist?.forEach((parroquia) async {
              await _seguimientoRepository
                  .guardarLocalizacionCatalogo(parroquia);
            });
          });
        }
      }
    } else {
      tiempo = 4;
      estadoSincronizacion = 'error';
      mensajeRespuesta = resSolicitudes.mensaje!;
    }

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    int tiempo = 4;
    String mensajeValidacion = '';
    // bool valido = true;

    iniciarValidacion(mensaje: ALMACENANDO);

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    final usuario = await _seguimientoRepository.getUsuario();

    seguimientoModelo.usuario = usuario?.nombre;

    seguimientoModelo.usuarioId = usuario?.identificador;

    seguimientoModelo.fechaCreacion = DateTime.now().toString();

    seguimientoModelo.idTablet =
        await _seguimientoRepository.getSecuencialRegistrosSeguimientos();

    seguimientoModelo.tabletId = usuario?.identificador;

    seguimientoModelo.tabletVersionBase = SCHEMA_VERSION;

    if (seguimientoModelo.ausenciaPlagas == 'No') {
      seguimientoModelo.faseDesarrolloPlaga = null;
      seguimientoModelo.organoAfectado = null;
      seguimientoModelo.distribucionPlaga = null;
    }

    try {
      final int res = await _seguimientoRepository
          .guardarInspeccionSeguiminetoCuarentenario(seguimientoModelo);

      var random = Random();

      for (var e in listaLaboratorio) {
        e.idPadre = res;
        e.idTablet = random.nextInt(100);
        await _seguimientoRepository
            .guardarInspeccionSeguiminetoCuarentenarioProducto(e);
      }
      mensajeValidacion = ALMACENADO_EXITO;
      tiempo = 2;
      // valido = true;
    } catch (e) {
      // valido = false;
      mensajeValidacion = 'Error: $e';
      tiempo = 4;
      debugPrint('Hubo un error: $e');
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
    bool error = false;
    int tiempo = 3;

    late List<SeguimientoCuarentenarioSvModelo> listaSeguimiento;
    late List<SeguimientoCuarentenarioLaboratorioSvModelo> listaOrdenes;

    Map<String, dynamic> datosPost = {"seguimientos": [], "ordenes": []};

    if (cantidadSeguimientos.value > 0) {
      iniciarValidacion(mensaje: SINCRONIZANDO_UP);

      mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

      await Future.delayed(const Duration(seconds: 1));

      try {
        listaSeguimiento =
            await _seguimientoRepository.getRegistrosSeguimientos();
        listaOrdenes = await _seguimientoRepository.getMuestraLaboratio();

        if (listaSeguimiento.isNotEmpty) {
          datosPost["seguimientos"] = listaSeguimiento;
          debugPrint('seguimientos preparados');
        }

        if (listaOrdenes.isNotEmpty) {
          datosPost["ordenes"] = listaOrdenes;
          debugPrint('ordenes preparadas');
        }

        error = false;
      } catch (e) {
        debugPrint('Error al preparar datos: $e');
        tiempo = 4;
        mensajeRespuesta = 'Error al preparar datos: $e';
        estadoSincronizacion = 'error';
        error = true;
      }

      if (!error) {
        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _seguimientoRepository.sincronizarUp(datosPost);
        });

        mensajeRespuesta = res.mensaje!;

        if (res.estado == 'exito') {
          tiempo = 3;
          await _seguimientoRepository.eliminarInspeccionesSeguimientos();
          await _seguimientoRepository.eliminarInspeccionesLaboratorio();
          await _seguimientoRepository.eliminarSolicitudeProductos();
          await _seguimientoRepository.eliminarSolicitudes();
          await _seguimientoRepository.eliminarSolicitudAreasCuarentena();
          await obtenerCantidadRegistrosSeguimiento();
        } else {
          tiempo = 5;
        }

        if (res.mensaje!.contains('ERROR:')) {
          var split = res.mensaje!.split("ERROR:");
          mensajeRespuesta = 'Error servidor:${split[1]}';
          estadoSincronizacion = 'error';
          tiempo = 4;
        } else {
          mensajeRespuesta = res.mensaje!;
        }
        estadoSincronizacion = res.estado!;
      }

      finalizarValidacion(mensajeRespuesta);
    } else {
      mensajeSincronizacion.value = SIN_REGISTROS;
      tiempo = 4;
      estadoSincronizacion = 'advertencia';
      validandoBajada.value = false;
      mostrarModalBottomSheet(
          titulo: SIN_DATOS, mensaje: mensaje, icono: icono);
    }

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
  }
}
