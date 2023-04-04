import 'dart:math';
import 'package:agro_servicios/app/data/models/respuesta_servicio.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/vigilancia_sv_provider.dart';
import 'package:agro_servicios/app/bloc/bloc_base.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/orden_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo_singleton.dart';
import 'package:agro_servicios/app/utils/codigos_provincias.dart'
    as codigo_provincia;

export 'package:agro_servicios/app/data/models/vigilancia_sv/orden_laboratorio_modelo.dart';

class OrdenLaboratorioSvBloc extends BlocBase with ChangeNotifier {
  final VigilanciaModeloSingleton _modeloVigilancia =
      VigilanciaModeloSingleton();
  final _laboratorioModelo = OrdenLaboratorioSvModelo();
  final VigilanciaModeloSingleton modeloVigilancia =
      VigilanciaModeloSingleton();
  final servicio = VigilanciaSvProvider();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<OrdenLaboratorioSvModelo> _listaOrdenes = [];

  int _secuencialOrden = 0;
  int _numeroOrdenesAgregadas = 0;
  int _cantidadVigilancia = 0;

  Random random = Random();

  String? _tipoMuestra = '';
  String _conservacionMuestra = '';
  String _codigoMuestra = '';
  String? _analisis = '';
  String _entomologico = '';
  String _nemantologico = '';
  String _fitopatologico = '';
  String _biologiaMolecular = '';
  String _maleza = '';
  String _malacologia = '';
  String _mensajeValidacion = '';
  String _mensajeGuardado = '';
  String _mensajeSincronizacion = '';
  String _fechaCodigoTrampa = '';
  String envioMuestra1 = 'Si';

  //Estados validación formulario
  String? _tipoMuestraError;
  String? _conservacionMuestraError;
  String _analisisError = '';

  bool _esEntomologico = false;
  bool _esNematologico = false;
  bool _esFitopatologico = false;
  bool _esBiologiaMolecular = false;
  bool _esMaleza = false;
  bool _esMalacologia = false;
  bool _estadoGuardandoOrdenlaboratorio = false;
  bool _estaGuardandoFormulario = false;
  bool? _estaSincronizandoUp;

  final Icon _iconoCheck = const Icon(
    Icons.check_circle_outline,
    size: 84.0,
    color: Colors.lightGreen,
  );

  final Icon _iconoError = const Icon(
    Icons.error_outline,
    size: 84.0,
    color: Colors.redAccent,
  );

  Icon? _icono;

//Getters

  int get secuencialOrden => _secuencialOrden;
  int get numeroOrdenesAgregadas => _numeroOrdenesAgregadas;
  int? get cantidadVigilancia => _cantidadVigilancia;

  String get envioMuestra => _modeloVigilancia.envioMuestra!;
  String? get tipoMuestra => _tipoMuestra;
  String get conservacionMuestra => _conservacionMuestra;
  String get mensajeValidacion => _mensajeValidacion;
  String get codigoMuestra => _codigoMuestra;
  String get mensajeGuardado => _mensajeGuardado;
  String get mensajeSincronizacion => _mensajeSincronizacion;

  String? get tipoMuestraError => _tipoMuestraError;
  String? get conservacionMuestraError => _conservacionMuestraError;
  String get analisisError => _analisisError;

  List get listaOrdenes => _listaOrdenes;

  bool get esEntomologico => _esEntomologico;
  bool get esNematologico => _esNematologico;
  bool get esFitopatologico => _esFitopatologico;
  bool get esBiologiaMolecular => _esBiologiaMolecular;
  bool get esMaleza => _esMaleza;
  bool get esMalacologia => _esMalacologia;
  bool get estadoGuardandoOrdenlaboratorio => _estadoGuardandoOrdenlaboratorio;
  bool get estaGuardandoFormulario => _estaGuardandoFormulario;
  get estaSincronizandoUp => _estaSincronizandoUp;

  Icon? get icono => _icono;

  //Setters
  set setCodigoMuestra(valor) => _codigoMuestra = valor;
  set setObservacion(valor) => _modeloVigilancia.observaciones = valor;
  set setSecuencialOrden(valor) => _secuencialOrden = valor;
  set setTipoMuestra(valor) => _laboratorioModelo.tipoMuestra = valor;
  set setConservacionMuestra(valor) => _laboratorioModelo.conservacion = valor;

  set setEnvioMuestra(valor) {
    envioMuestra1 = 'No';
    _modeloVigilancia.envioMuestra = valor;
    // if (valor == 'No') limpiarOrdenes();
    notifyListeners();
  }

  set setEntomologico(bool valor) {
    _esEntomologico = valor;
    if (valor) {
      _entomologico = 'Entomológico';
    } else {
      _entomologico = '';
    }
    notifyListeners();
  }

  set setNemantologico(bool valor) {
    _esNematologico = valor;
    if (valor) {
      _nemantologico = ', Nematológico';
    } else {
      _nemantologico = '';
    }
    notifyListeners();
  }

  set setFitopatologico(bool valor) {
    _esFitopatologico = valor;
    if (valor) {
      _fitopatologico = ', Fitopatológico';
    } else {
      _fitopatologico = '';
    }
    notifyListeners();
  }

  set setBiologiaMolecular(bool valor) {
    _esBiologiaMolecular = valor;
    if (valor) {
      _biologiaMolecular = ', Biología Molecular';
    } else {
      _biologiaMolecular = '';
    }
    notifyListeners();
  }

  set setMaleza(bool valor) {
    _esMaleza = valor;
    if (valor) {
      _maleza = ', Malezas';
    } else {
      _maleza = '';
    }
    notifyListeners();
  }

  set setMalacologia(bool valor) {
    _esMalacologia = valor;
    if (valor) {
      _malacologia = ', Malacología';
    } else {
      _malacologia = '';
    }
    notifyListeners();
  }

  set setAnalisis(bool valor) {
    _analisis = '${_analisis!}, $valor';
  }

  set setEstadoGuardandoOrdenlaboratorio(valor) {
    _estadoGuardandoOrdenlaboratorio = valor;
    notifyListeners();
  }

  set setMensajeValidacion(valor) {
    _mensajeValidacion = valor;
    notifyListeners();
  }

  set setGuardandoFormulario(valor) {
    _estaGuardandoFormulario = valor;
    notifyListeners();
  }

  set setMensajeGuardado(valor) {
    _mensajeGuardado = valor;
    notifyListeners();
  }

  set setEstaSincronizandoUp(valor) {
    _estaSincronizandoUp = valor;
    notifyListeners();
  }

  set setMensajeSincronizacion(valor) {
    _mensajeSincronizacion = '';
    // notifyListeners();
  }

  String generarCodigoMuestra(secuencia) {
    int? numeroSecuencial = secuencia;
    String fecha;
    String codigoMuestra;
    String provincia =
        codigo_provincia.codigoProvincia(_modeloVigilancia.nombreProvincia);

    numeroSecuencial = numeroSecuencial ?? 0;
    numeroSecuencial += 1;

    fecha = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    _fechaCodigoTrampa = _fechaCodigoTrampa == '' ? fecha : _fechaCodigoTrampa;
    codigoMuestra = 'VF$provincia-$_fechaCodigoTrampa-$numeroSecuencial';
    _laboratorioModelo.codigoMuestra = codigoMuestra;

    return codigoMuestra;
  }

  eliminarOrdenLaboratorio(index) {
    _listaOrdenes.removeAt(index);

    _listaOrdenes.asMap().forEach((index, e) {
      e.codigoMuestra = generarCodigoMuestra(index);
    });

    _numeroOrdenesAgregadas--;

    notifyListeners();
  }

  bool validarFormulario() {
    bool esValido = true;
    llenarAnalisis();
    if (_laboratorioModelo.tipoMuestra == '--' ||
        _laboratorioModelo.tipoMuestra == null) {
      _tipoMuestraError = 'El campo Tipo de muestra es obligatorio';
      esValido = false;
    } else {
      _tipoMuestraError = null;
    }

    if (_laboratorioModelo.conservacion == '--' ||
        _laboratorioModelo.conservacion == null) {
      _conservacionMuestraError =
          'El campo Distribución de la plaga es obligatorio';
      esValido = false;
    } else {
      _conservacionMuestraError = null;
    }

    if (_analisis == '' || _analisis == null) {
      _analisisError = 'Debe seleccionar al menos un tipo de análisis';
      esValido = false;
      _laboratorioModelo.analisisSolicitado = null;
    } else {
      _laboratorioModelo.analisisSolicitado = _analisis;
      _analisisError = '';
    }

    if (esValido) {
      _estadoGuardandoOrdenlaboratorio = true;
      _icono = _iconoCheck;
      completarFormulario();
    }
    notifyListeners();
    return esValido;
  }

  llenarAnalisis() {
    _analisis = '';
    _analisis = _entomologico +
        _nemantologico +
        _fitopatologico +
        _biologiaMolecular +
        _maleza +
        _malacologia;
    _analisis = removerNprimerosCaracteres(
        cadena: _analisis, caracterSeparador: ',', cantidad: 2);
  }

  limpiarOrdenes() {
    _listaOrdenes.clear();
    // notifyListeners();
  }

  limpiarFormulario() {
    _tipoMuestra = null;
    _conservacionMuestra = '';
    _analisis = '';
    _entomologico = '';
    _nemantologico = '';
    _fitopatologico = '';
    _biologiaMolecular = '';
    _maleza = '';
    _malacologia = '';
    _mensajeValidacion = '';

    if (_listaOrdenes.isEmpty) _fechaCodigoTrampa = '';

    _esEntomologico = false;
    _esNematologico = false;
    _esFitopatologico = false;
    _esBiologiaMolecular = false;
    _esMaleza = false;
    _esMalacologia = false;
    _estadoGuardandoOrdenlaboratorio = false;

    _laboratorioModelo.tipoMuestra = null;
    _laboratorioModelo.conservacion = null;

    _tipoMuestraError = null;
    _conservacionMuestraError = null;
    _analisisError = '';
  }

  limpiarCodigoFecha() {
    _fechaCodigoTrampa = '';
  }

  completarFormulario() {
    _listaOrdenes.add(OrdenLaboratorioSvModelo(
        analisisSolicitado: _laboratorioModelo.analisisSolicitado,
        codigoMuestra: _laboratorioModelo.codigoMuestra,
        conservacion: _laboratorioModelo.conservacion,
        tipoMuestra: _laboratorioModelo.tipoMuestra));
    _numeroOrdenesAgregadas++;
    // notifyListeners();
  }

  guardarformulario() async {
    try {
      UsuarioModelo? listaUsuario = UsuarioModelo();
      listaUsuario = await DBHomeProvider.db.getUsuario();

      final LocalizacionModelo? res =
          await servicio.obtenerProvinciaSincronizada();

      final fechaActual = DateTime.now();
      modeloVigilancia.idTablet = random.nextInt(90) + 1;
      modeloVigilancia.tabletId = listaUsuario!.identificador;
      modeloVigilancia.tabletBase = SCHEMA_VERSION;
      modeloVigilancia.usuario = listaUsuario.nombre;
      modeloVigilancia.usuarioId = listaUsuario.identificador;
      modeloVigilancia.fechaInspeccion =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaActual).toString();
      modeloVigilancia.nombreProvincia = res?.nombre;
      modeloVigilancia.codigoProvincia = res?.idGuia.toString();

      modeloVigilancia.cantidadTotal =
          validarDouble(modeloVigilancia.cantidadTotal)
              ? modeloVigilancia.cantidadTotal
              : null;
      modeloVigilancia.cantidadAfectada =
          validarDouble(modeloVigilancia.cantidadAfectada)
              ? modeloVigilancia.cantidadAfectada
              : null;
      modeloVigilancia.incidencia = validarDouble(modeloVigilancia.incidencia)
          ? modeloVigilancia.incidencia
          : null;
      modeloVigilancia.severidad = validarDouble(modeloVigilancia.severidad)
          ? modeloVigilancia.severidad
          : null;
      modeloVigilancia.poblacion = validarDouble(modeloVigilancia.poblacion)
          ? modeloVigilancia.poblacion
          : null;

      await servicio.guardarVigilancia(modeloVigilancia, _listaOrdenes);
      _icono = _iconoCheck;
    } catch (e) {
      _mensajeGuardado = 'Error al guardar los datos: $e';
      _icono = _iconoError;
    }

    notifyListeners();
  }

  obtenerCantidadVigilancia() async {
    final List<VigilanciaModelo> lista = await servicio.obtenerVigilancia();
    _cantidadVigilancia = lista.length;
    notifyListeners();
  }

  sincronizarRegistrosUp() async {
    final List<VigilanciaModelo> listaVigilancia =
        await servicio.obtenerVigilancia();
    final List<OrdenLaboratorioSvModelo> listaOrdenLaboratorio =
        await servicio.obtenerOrdenLaboratorio();

    Map<String, dynamic> datosPost = {
      "detalle": [],
      "ordenes": [],
    };

    List<String> pathImagenes = [];

    if (listaVigilancia.isNotEmpty) {
      for (var e in listaVigilancia) {
        if (e.imagen != null) {
          pathImagenes.add(e.imagen!);
          e.imagen = await base64Archivo(e.imagen);
        }
      }

      datosPost["detalle"] = listaVigilancia;
      debugPrint("monitoreo vigilancia preparado");
    }

    if (listaOrdenLaboratorio.isNotEmpty) {
      datosPost["ordenes"] = listaOrdenLaboratorio;
      debugPrint("ordenes de laboratorio preparadas");
    } else {
      datosPost["ordenes"] = [];
    }

    RespuestaServicio respuesta = await servicio.sincronizarUp(datosPost);

    if (respuesta.estado == 'exito') {
      _icono = _iconoCheck;
      _mensajeSincronizacion =
          'Registros almancenados en el Sistema GUIA exitosamente';
      await servicio.eliminarMonitoreoVigilancia();
      await obtenerCantidadVigilancia();
      eliminarArchivos(pathImagenes);

      debugPrint('Datos guardados con éxito');
    } else {
      _icono = _iconoError;
      _mensajeSincronizacion =
          respuesta.mensaje ?? 'Error inesparado al sincronizar los datos';
      debugPrint('Error al guardar datos');
    }
  }
}
