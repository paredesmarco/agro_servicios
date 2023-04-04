import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/seleccion_productos_importados_sv_controller.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/productos_importados/inspeccion_productos_importados_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/producto_importado_lote_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/productos_importados_orden_modelo.dart';
import 'package:agro_servicios/app/utils/codigo_trampa.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/productos_importados/solicitud_productos_importados_modelo.dart';
import 'package:agro_servicios/app/data/repository/productos_importados_sv_repository.dart';

class ProductosImportadosSvController extends GetxController
    with GetSingleTickerProviderStateMixin, ControladorBase {
  final _repositorio = Get.find<ProductosImportadosSvRepository>();

  RxString mensajeBajarDatos = 'Sincronizando...'.obs;
  RxString mensajeSubirDatos = 'Sincronizando...'.obs;
  RxString mensajeSincronizacion = 'Sincronizando...'.obs;

  RxBool validandoSincronizacion = true.obs;

  RxInt cantidadInspecciones = 0.obs;

  String estadoBajada = '';
  String mensajeRespuesta = '';

  String estadoSincronizacion = '';

  String fechaOrdenLaboratorio = '';

  bool _envioMuestra = false;

  RxBool errorAnalisis = false.obs;
  RxBool validandoGuardado = false.obs;
  RxString mensajeGuardado = DEFECTO_A.obs;
  RxString codigoMuestra = ''.obs;
  String estadoGuardado = '';

  InspeccionProductosImportadosModelo inspeccion =
      InspeccionProductosImportadosModelo();

  RxList<ProductoImportadoLoteModelo> listaLotes =
      <ProductoImportadoLoteModelo>[].obs;

  RxList<ProductosImportadosOrdenModelo> listaOrdenes =
      <ProductosImportadosOrdenModelo>[].obs;

  RxList<ProductoImportadoModelo> listaProductos =
      <ProductoImportadoModelo>[].obs;

  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    tabController.animation?.addListener(cambioVistaTab);
    obtenerCantidadRegistrosInspecciones();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  set envioMuestra(valor) {
    _envioMuestra = valor;
    update(['fab']);
  }

  bool get envioMuestra => _envioMuestra;

  set setEnvioMuestra(valor) {
    envioMuestra = valor;
    update(['fab']);
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
    } else if (aniValue < 1.5 && aniValue > 0.5) {
      if (index != 1) {
        index = 1;
        verFab = false;
        update(['fab']);
      }
    } else if (aniValue < 0.5) {
      if (index != 0) {
        index = 0;
        verFab = false;
        update(['fab']);
      }
    }
  }

  Future<void> obtenerCantidadRegistrosInspecciones() async {
    var res = await _repositorio.getCantidadInspecciones();
    cantidadInspecciones.value = res;
  }

  void iniciarValidacion({String? mensaje}) {
    validandoGuardado.value = true;
    mensajeGuardado.value = mensaje ?? DEFECTO_A;
  }

  void finalizarValidacion(String mensaje) {
    validandoGuardado.value = false;
    mensajeGuardado.value = mensaje;
  }

  Future<void> eliminarLote(index) async {
    listaLotes.removeAt(index);
  }

  Future<void> eliminarOrdenesLaboratorio(index) async {
    listaOrdenes.removeAt(index);
    if (listaOrdenes.isEmpty) fechaOrdenLaboratorio = '';

    final provinciaContrato = await _repositorio.getProvinciaContrato();

    listaOrdenes.asMap().forEach((index, e) {
      e.codigoMuestra = generarCodigoMuestra(
        secuencia: index,
        provincia: provinciaContrato?.provincia ?? '',
        fechaInicial: fechaOrdenLaboratorio,
        codigoFormulario: 'IPI',
      );
    });
  }

  Future<void> bajarDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    await obtenerCantidadRegistrosInspecciones();
    if (cantidadInspecciones.value <= 0) {
      await _bajarDatos(titulo: titulo, mensaje: mensaje, icono: icono);
    } else {
      mensajeSincronizacion.value = REGISTROS_PENDIENTES;
      mensajeGuardado.value = REGISTROS_PENDIENTES;

      estadoSincronizacion = 'advertencia';
      validandoSincronizacion.value = false;
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
    final provincia = await _repositorio.getProvinciaContrato();

    int tiempo = 2;

    iniciarValidacion(mensaje: DEFECTO_S);

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    final RespuestaProvider res = await ejecutarConsulta(() async =>
        await _repositorio.getProductosImportados(
            provincia!.provincia!, 'VEGETAL'));

    if (res.estado == 'exito') {
      List<SolicitudProductosImportadosModelo> lista = res.cuerpo;

      if (lista.isNotEmpty) {
        try {
          await _repositorio.eliminarSolictudProductosImportados();
          await _repositorio.eliminarProductosSolicitudes();
          await _repositorio.eliminarInspeccion();
          await _repositorio.eliminarInspeccionLotes();
          await _repositorio.eliminarInspeccionProductos();
          await _repositorio.eliminarInspeccionOrdenesLaboratorio();

          for (var e in lista) {
            List<ProductoImportadoModelo>? productos = e.productos;

            int? id = await _repositorio.guardarSolictudProductosImportados(e);

            productos?.forEach((j) async {
              j.controlF01Id = id;

              await _repositorio.guardarProductosSolictudProductosImportados(j);
            });
          }
          mensajeRespuesta =
              'Se sincronizaron los registros de DDA de Sanidad Vegetal';
          estadoSincronizacion = 'exito';
        } catch (e) {
          tiempo = 4;
          estadoSincronizacion = 'error';
          mensajeRespuesta = 'Error al guardar datos';
        }
      } else {
        estadoSincronizacion = 'error';
        mensajeRespuesta = 'No existen datos para sincronizar';
      }
    } else {
      tiempo = 4;
      estadoSincronizacion = 'error';
      mensajeRespuesta = res.mensaje!;
    }

    finalizarValidacion(mensajeRespuesta);

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    final productosSolicitud =
        Get.find<SeleccionRegistroProductosImportadosSvController>()
            .productosSolicitud;

    int tiempo = 4;
    String mensajeValidacion = '';

    iniciarValidacion(mensaje: ALMACENANDO);

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    try {
      await completarDatosInspeccion();

      final id = await _repositorio.guardarInspeccion(inspeccion);

      for (var e in listaLotes) {
        e.controlF01Id = id;
        await _repositorio.guardarInspeccionLote(e);
      }

      for (var e in listaOrdenes) {
        e.controlF01Id = id;
        await _repositorio.guardarInspeccionOrdenLaboratorio(e);
      }

      for (var e in productosSolicitud) {
        e.controlF01Id = id;
        await _repositorio.guardarInspeccionProductos(e);
      }

      mensajeValidacion = ALMACENADO_EXITO;
      estadoSincronizacion = 'exito';
      tiempo = 2;
    } catch (e) {
      estadoSincronizacion = 'error';
      mensajeValidacion = 'Error: $e';
      tiempo = 4;
      debugPrint('Error al preparar los datos: $e');
    }

    finalizarValidacion(mensajeValidacion);

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
    if (estadoSincronizacion != 'error') Get.back();
  }

  Future<void> completarDatosInspeccion() async {
    final solicitud =
        Get.find<SeleccionRegistroProductosImportadosSvController>()
            .solicitudRegistro;

    final productosSolicitud =
        Get.find<SeleccionRegistroProductosImportadosSvController>()
            .productosSolicitud;

    final usuario = await _repositorio.getUsuario();

    final peso = productosSolicitud.fold<double>(
        0, (sum, item) => sum + double.parse(item.cantidadIngresada!));

    DateTime now = DateTime.now();
    String fechaFormateada = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);

    inspeccion.pfi = solicitud.pfi;
    inspeccion.dda = solicitud.dda;
    inspeccion.usuarioId = usuario!.identificador;
    inspeccion.usuario = usuario.nombre;
    inspeccion.pesoIngreso = peso.toString();
    inspeccion.fechaCreacion = fechaFormateada;
  }

  subirDatos(
      {required String titulo,
      required Widget mensaje,
      required Widget icono}) async {
    bool error = false;

    Map<String, dynamic> datosPost = {
      "inspecciones": [],
      "lotes": [],
      "ordenes": [],
      "productos": []
    };

    int tiempo = 2;
    String mensajeValidacion = '';

    if (cantidadInspecciones.value > 0) {
      iniciarValidacion(mensaje: ALMACENANDO);

      mensajeSincronizacion.value = SINCRONIZANDO_UP;

      mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

      await Future.delayed(const Duration(seconds: 1));

      try {
        final inspecciones = await _repositorio.getInspecciones();

        final lotes = await _repositorio.getInspeccionesLotes();

        final ordenes = await _repositorio.getInspeccionesOrdenesLaboratorio();

        final productos = await _repositorio.getInspeccionesProductos();

        Random random = Random();

        if (inspecciones.isNotEmpty) {
          for (var e in inspecciones) {
            e!.idTablet = (random.nextInt(90) + 1);
            e.tabletId =
                Get.find<LoginController>().usuarioModelo!.identificador;
            e.tabletVersion = SCHEMA_VERSION;
          }
          datosPost["inspecciones"] = inspecciones;
          debugPrint('inspecciones preparados');
        }

        if (lotes.isNotEmpty) {
          for (var e in lotes) {
            e!.idTablet = (random.nextInt(90) + 1);
          }
          datosPost["lotes"] = lotes;
          debugPrint('lotes preparados');
        }

        if (ordenes.isNotEmpty) {
          for (var e in ordenes) {
            e!.idTablet = (random.nextInt(90) + 1);
          }
          datosPost["ordenes"] = ordenes;
          debugPrint('ordenes preparados');
        }

        if (productos.isNotEmpty) {
          for (var e in productos) {
            e!.idTablet = (random.nextInt(90) + 1);
          }
          datosPost["productos"] = productos;
          debugPrint('productos preparados');
        }
        error = false;
      } catch (e) {
        debugPrint('Error al preparar datos: $e');
        tiempo = 4;
        mensajeValidacion = 'Error al preparar datos: $e';
        estadoSincronizacion = 'error';
        error = true;
      }

      if (!error) {
        final RespuestaProvider res = await ejecutarConsulta(() async {
          return await _repositorio.sincronizarUp(datosPost);
        });

        if (res.estado == 'exito') {
          _repositorio.eliminarInspeccion();
          _repositorio.eliminarInspeccionLotes();
          _repositorio.eliminarInspeccionOrdenesLaboratorio();
          _repositorio.eliminarInspeccionProductos();
          _repositorio.eliminarProductosSolicitudes();
          _repositorio.eliminarSolictudProductosImportados();
          obtenerCantidadRegistrosInspecciones();
        }

        mensajeValidacion = res.mensaje!;
        estadoSincronizacion = res.estado!;
      }

      mensajeSincronizacion.value = mensajeValidacion;

      finalizarValidacion(mensajeValidacion);
    } else {
      mensajeSincronizacion.value = SIN_REGISTROS;
      validandoSincronizacion.value = false;
      tiempo = 4;
      estadoSincronizacion = 'advertencia';
      mostrarModalBottomSheet(
          titulo: SIN_DATOS, mensaje: mensaje, icono: icono);
    }

    await Future.delayed(Duration(seconds: tiempo));

    Get.back();
  }
}
