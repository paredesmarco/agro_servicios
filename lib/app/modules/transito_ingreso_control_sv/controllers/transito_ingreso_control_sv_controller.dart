import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/transito_ingreso_control_sv/transito_ingreso_producto_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_ingreso_control_sv/transito_ingreso_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/transito_ingreso_control_sv_repository.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransitoIngresoControlSvController extends GetxController
    with GetSingleTickerProviderStateMixin, ControladorBase {
  final _ingresoRepository = Get.find<TransitoIngresoControlSvRepository>();
  TabController? tabController;

  TransitoIngresoSvModelo ingresoModelo = TransitoIngresoSvModelo();
  RxList<TransitoIngresoProductoSvModelo> listaProductoModelo =
      <TransitoIngresoProductoSvModelo>[].obs;

  RxString mensajeBajarDatos = 'Sincronizando...'.obs;
  RxString mensajeSubirDatos = 'Sincronizando...'.obs;
  RxInt cantidadIngreso = 0.obs;
  RxBool validandoBajada = true.obs;
  RxBool validandoSubida = true.obs;
  String mensajeRespuesta = '';
  String estadoBajada = '';

  @override
  void onInit() {
    obtenerCantidadRegistrosTransitoIngreso();
    tabController = TabController(length: 3, vsync: this);
    tabController!.animation!.addListener(cambioVistaTab);
    super.onInit();
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
    final valorAnimacion = tabController!.animation!.value;
    if (valorAnimacion >= 1.5) {
      if (index != 3) {
        index = 3;
        verFab = true;
        update(['fab']);
      }
    } else if (valorAnimacion <= 1.5 && valorAnimacion > 0.5) {
      if (index != 2) {
        index = 2;
        verFab = true;
        update(['fab']);
      }
    } else if (valorAnimacion < 0.5) {
      if (index != 0) {
        index = 0;
        verFab = false;
        update(['fab']);
      }
    }
  }

  Future obtenerCantidadRegistrosTransitoIngreso() async {
    var res = await _ingresoRepository.getCantidadRegistros();
    debugPrint('$res');
    cantidadIngreso.value = res[0]['cantidad'];
  }

  void eliminarItemProducto(int index) {
    listaProductoModelo.removeAt(index);
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
    await obtenerCantidadRegistrosTransitoIngreso();
    if (cantidadIngreso <= 0) {
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
    final RespuestaProvider resEnvases = await ejecutarConsulta(() async {
      return await _ingresoRepository.getCatalogoEnvases('SV');
    });

    final RespuestaProvider resPaises = await ejecutarConsulta(() async {
      return await _ingresoRepository.getPaises();
    });

    final RespuestaProvider resPuertos = await ejecutarConsulta(() async {
      return await _ingresoRepository.getPuertos();
    });

    final RespuestaProvider resPaisesOrigen = await ejecutarConsulta(() async {
      return await _ingresoRepository.getPaisesOrigenProcedenciaTransito('SV');
    });

    final RespuestaProvider resProductos = await ejecutarConsulta(() async {
      return await _ingresoRepository.getProductosTransito('SV');
    });

    if (resEnvases.estado == 'exito' &&
        resPaises.estado == 'exito' &&
        resPuertos.estado == 'exito' &&
        resPaisesOrigen.estado == 'exito' &&
        resProductos.estado == 'exito') {
      _ingresoRepository.eliminarEnvases();
      _ingresoRepository.eliminarPuertos();
      _ingresoRepository.eliminarPaisesOrigenProcedencia();
      _ingresoRepository.eliminarProductosTransito();

      tiempo = 2;
      mensajeRespuesta = 'Se sincronizaron 5 catálogos';
      resEnvases.cuerpo.forEach((puerto) async {
        try {
          await _ingresoRepository.guardarEnvase(puerto);
        } catch (e) {
          tiempo = 4;
          estadoBajada = 'error';
          mensajeRespuesta = 'Error al guardar datos';
        }
      });

      resPaises.cuerpo.forEach((pais) async {
        try {
          await _ingresoRepository.guardarPais(pais);
        } catch (e) {
          tiempo = 4;
          estadoBajada = 'error';
          mensajeRespuesta = 'Error al guardar datos';
        }
      });

      resPuertos.cuerpo.forEach((puerto) async {
        try {
          await _ingresoRepository.guardarPuerto(puerto);
        } catch (e) {
          tiempo = 4;
          estadoBajada = 'error';
          mensajeRespuesta = 'Error al guardar datos';
        }
      });

      resPaisesOrigen.cuerpo.forEach((paisorigen) async {
        try {
          await _ingresoRepository.guardarPaisOrigenrocedencia(paisorigen);
        } catch (e) {
          tiempo = 4;
          estadoBajada = 'error';
          mensajeRespuesta = 'Error al guardar datos';
        }
      });

      resProductos.cuerpo.forEach((producto) async {
        try {
          await _ingresoRepository.guardarProductoTransito(producto);
        } catch (e) {
          tiempo = 4;
          estadoBajada = 'error';
          mensajeRespuesta = 'Error al guardar datos';
        }
      });
      finalizarValidacion(mensajeRespuesta);
    } else {
      finalizarValidacion('Ocurrió un error al sincronizar los datos');
    }

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
      final usuario = await _ingresoRepository.getsusuario();
      final secuenciaIngreso = await _ingresoRepository.getSecuenciaIngreso();

      ingresoModelo.usuarioIngreso = usuario!.nombre;
      ingresoModelo.usuarioIdIngreso = usuario.identificador;
      ingresoModelo.fechaIngreso = DateTime.now().toString();
      ingresoModelo.idTablet = secuenciaIngreso;
      ingresoModelo.tabletVersionBaseIngreso = SCHEMA_VERSION;

      debugPrint('listaProductoModelo.length: ${listaProductoModelo.length}');

      final res =
          await _ingresoRepository.guardarVerificacionIngreso(ingresoModelo);
      for (var e in listaProductoModelo) {
        debugPrint(e.descripcionProducto);
        final secuenciaProducto =
            await _ingresoRepository.getSecuenciaProducto();
        debugPrint('secuenciaProducto $secuenciaProducto');
        e.controlF02Id = res;
        e.idTablet = secuenciaProducto;
        await _ingresoRepository.guardarVerificacionIngresoProducto(e);
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
    late List<TransitoIngresoSvModelo> listaIngresos;
    late List<TransitoIngresoProductoSvModelo> listaProductos;

    bool error = false;
    int tiempo = 3;

    Map<String, dynamic> datosPost = {
      "ingreso": [],
      "productos": [],
    };

    if (cantidadIngreso.value > 0) {
      iniciarValidacion();

      mostrarModalBottomSheet(titulo: titulo, mensaje: mensaje, icono: icono);

      await Future.delayed(const Duration(seconds: 1));

      try {
        listaIngresos =
            await _ingresoRepository.getRegistrosVerificacionIngreso();
        listaProductos =
            await _ingresoRepository.getRegistrosVerificacionIngresoProductos();

        if (listaIngresos.isNotEmpty) {
          datosPost["ingreso"] = listaIngresos;
          debugPrint("verificacion ingresos preparados");
        }

        if (listaProductos.isNotEmpty) {
          datosPost["productos"] = listaProductos;
          debugPrint("productos preparadas");
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
          return await _ingresoRepository.sincronizarUp(datosPost);
        });

        mensajeRespuesta = res.mensaje!;

        if (res.estado == 'exito') {
          tiempo = 3;
          await _ingresoRepository
              .eliminarVerificacionTransitoIngresosProductos();
          await _ingresoRepository.eliminarVerificacionTransitoIngresos();
          await obtenerCantidadRegistrosTransitoIngreso();
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
