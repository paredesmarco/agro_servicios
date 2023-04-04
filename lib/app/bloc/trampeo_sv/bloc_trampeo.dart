import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_trampa_detalle_completado_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_trampa_inspeccion_padre.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_orden_trabajo_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_trampa_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_trampa_nueva_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/trampas_modelo.dart';
import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo_lugar.dart';
import 'package:agro_servicios/app/bloc/bloc_base.dart';
import 'package:agro_servicios/app/data/provider/local/db_trampeo_vigilancia.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';

class TrampeoBloc extends BlocBase with ChangeNotifier {
  List<LocalizacionModelo> listaProvincias = [];
  List<LocalizacionModelo> listaProvinciasDropDown = [
    LocalizacionModelo(idGuia: 0, nombre: '--')
  ];
  List<LocalizacionModelo> listaProvincias2 = [];
  List<LocalizacionModelo> _listaLocalizacion = [];

  TrampasModelo _trampasModelo = TrampasModelo();
  final BlocTrampeoLugar _trampeoLugar = BlocTrampeoLugar();

  int? _provinciaUno;
  int? _provinciaDos;
  int _cantidadTrampasSincronizadas = 0;
  int? _numeroSecuencial;

  String _mensajeValidacion = '';

  bool _estaValidado = false;
  bool _comboActivo = false;

  Random random = Random();
  int? _idTablet;
  int lenghtProvincias = 0;

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

  final Icon _iconoSinDatos = Icon(
    Icons.cloud_off,
    size: 75.0,
    color: Colors.grey[350],
  );

  Icon? _icon;

  bool get estaValidando => _estaValidado;

  bool get comboActivo => _comboActivo;

  Icon? get icono => _icon;

  String get mensajeValidacion => _mensajeValidacion;

  int? get provinciaUno => _provinciaUno;

  int? get provinciaDos => _provinciaDos;

  int get cantidadTrampasSincronizadas => _cantidadTrampasSincronizadas;

  set setValidando(bool valor) => _estaValidado = valor;

  set setProvinciaUno(int? valor) => _provinciaUno = valor;

  set setProvinciaDos(int? valor) => _provinciaDos = valor;

  set setcomboActivo(bool valor) {
    _comboActivo = valor;
    notifyListeners();
  }

  getProvincias() async {
    //listaProvincias2.clear();
    listaProvinciasDropDown.clear();
    listaProvinciasDropDown.add(LocalizacionModelo(idGuia: 0, nombre: '--'));
    //if (listaProvincias.length == 0) {
    listaProvincias.clear();
    listaProvincias = await DBLocalizcion.db.getTodosProvincias(1);
    listaProvinciasDropDown.addAll(listaProvincias);
    _provinciaUno = 0;
    _provinciaDos = 0;
    lenghtProvincias = listaProvinciasDropDown.length;
    //notifyListeners();
    //}
    notifyListeners();
  }

  getSegundaProvincia() async {
    if (_comboActivo == false) {
      List<LocalizacionModelo> lista = [];
      listaProvincias2.clear();
      lista = await DBLocalizcion.db.getTodosProvincias(1);
      listaProvincias2.add(LocalizacionModelo(idGuia: 0, nombre: '--'));
      listaProvincias2.addAll(lista);
      _comboActivo = true;
      notifyListeners();
    }
  }

  getCantidadTrampasSincronizadas() async {
    List cantidadTrampas = await (DBTrampeoVigilancia().getTrampasMax());
    _cantidadTrampasSincronizadas = cantidadTrampas[0]['cantidad'] ?? 0;

    notifyListeners();
  }

  limpiarTrampas() async {
    await DBTrampeoVigilancia().limpiarTrampas();
    notifyListeners();
  }

  limpiarProvincia() async {
    listaProvincias2.clear();
    _provinciaDos = 0;
    _comboActivo = false;
    notifyListeners();
  }

  void reset() {
    _estaValidado = false;
    _mensajeValidacion = '';
    _estaCargando = false;
    _listaTrampasDetalle.clear();
    listaTrampasCompletadas.clear();
  }

  getCantonesBajada(int? provincia) async {
    try {
      final http.Response res = await httpRequestWS(
              endPoint: 'RestWsLocalizacion/obtenerCantones',
              parametros: provincia.toString())
          .timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        List lista = json.decode(res.body);
        _listaLocalizacion =
            lista.map((model) => LocalizacionModelo.fromJson(model)).toList();

        for (var item in _listaLocalizacion) {
          await DBLocalizcion.db.guardarLocalizacionSincronizadasRaw(item);
        }
        await guardarProvinciaSincronizada(provincia);
        _icon = _iconoCheck;
      } else {
        _mensajeValidacion = 'Error al sincroniar datos';
      }
    } on TimeoutException catch (e) {
      _icon = _iconoError;
      _mensajeValidacion =
          'El servidor se está tardando en responder, intentalo mas tarde';
      debugPrint(e.toString());
    } on SocketException catch (e) {
      _icon = _iconoError;
      _mensajeValidacion =
          'Error en la Red: Por favor verifica que tengas acceso a internet';
      debugPrint(e.toString());
    } on HttpException catch (e) {
      debugPrint('Error en la petición del servicio web $e');
    } on FormatException catch (e) {
      debugPrint('Error en el formato de respuesta $e');
    } on Exception catch (e) {
      debugPrint('Error $e');
    }
  }

  getRutasTrampeoBajada(String provincia) async {
    final LoginProvider loginPorvider = Get.find<LoginProvider>();

    final token = await loginPorvider.obtenerToken();

    try {
      final http.Response res = await httpRequestWS(
              endPoint: 'RestWsTrampeoVigilancia/obtenerRutasTrampasVigilancia',
              parametros:
                  removerUltimoCaracter(cadena: provincia, caracter: ','),
              token: token)
          .timeout(
        const Duration(seconds: 30),
      );

      final body = json.decode(res.body);
      if (res.statusCode == 200) {
        await DBTrampeoVigilancia().limpiarTrampas();
        await DBTrampeoVigilancia().limpiarTrampasDetalle();
        await DBTrampeoVigilancia().limpiarOrdenLaboratorio();
        await DBTrampeoVigilancia().limpiarProvinciasSincronizadas();

        await getCantidadTrampasDetalle();
        await getCantidadTrampasUtilizadas();

        await getCantonesBajada(provinciaUno);
        await getCantonesBajada(provinciaDos);

        final lista = json.decode(res.body);

        if (lista['cuerpo'] != null) {
          _trampasModelo = TrampasModelo.fromJson(lista);

          List? lis = [];

          lis =
              lista['cuerpo'].map((model) => Trampas.fromJson(model)).toList();

          for (var e in lis!) {
            await DBTrampeoVigilancia().guardarNuevaTrampa(e);
          }

          _icon = _iconoCheck;
          _mensajeValidacion =
              'Se sincronizaron ${_trampasModelo.cuerpo!.length} registros';
        } else {
          _icon = _iconoSinDatos;
          _mensajeValidacion = 'No se encontraron registros para sincronizar';
        }
      } else {
        _icon = _iconoError;
        _mensajeValidacion = 'Error: ${body['mensaje']}';
      }
    } on TimeoutException catch (e) {
      _icon = _iconoError;
      _mensajeValidacion =
          'El servidor se está tardando en responder, intentalo mas tarde';
      debugPrint(e.toString());
    } on SocketException catch (e) {
      _icon = _iconoError;
      _mensajeValidacion =
          'Error en la Red: Por favor verifica que tengas acceso a internet';
      debugPrint(e.toString());
    } on HttpException catch (e) {
      debugPrint('Error en la petición del servicio web $e');
    } on FormatException catch (e) {
      debugPrint('Error en el formato de respuesta $e');
    } on Exception catch (e) {
      debugPrint('Error $e');
    }
  }

  guardarProvinciaSincronizada(int? provincia) async {
    await DBTrampeoVigilancia().guardarProvinicasSincronizadas(provincia);
  }

  sincronizar() async {
    await getRutasTrampeoBajada('$provinciaUno,$provinciaDos,');
    _estaValidado = true;

    notifyListeners();
  }

  //************************************************
  // formulario de selección del lugar de trampeo  *
  //************************************************

  int? _provinciaSincronizada = 0;
  int? _cantonSincronizado = 0;
  int? _lugarInstalacion = 0;
  int? _parroquiaInstalacion = 0;
  int _numeroLugarInstalacion = 0;
  bool _esparroquia = false;

  List<LocalizacionModelo> _listaProvinciasSincronizadas = [
    LocalizacionModelo(idGuia: 0, nombre: '--')
  ];
  List<LocalizacionModelo> _listaCantonesLugarInstalacion = [];
  List<Trampas> _listaLugarInstalacion = [];
  List<LocalizacionModelo> _listaParroquia = [];
  List<Trampas> _listaNumeroLugarInstalacion = [];

  // List<LocalizacionModelo> nuevaListaCantones = List();

  List<LocalizacionModelo> get listaProvinciasSincronizadas =>
      _listaProvinciasSincronizadas;

  List<LocalizacionModelo> get listaCantonesLugarInstalacion =>
      _listaCantonesLugarInstalacion;

  List<Trampas> get listaLugarInstalacion => _listaLugarInstalacion;

  List<Trampas> get listaNumeroLugarInstalacion => _listaNumeroLugarInstalacion;

  List<LocalizacionModelo> get listaParroquia => _listaParroquia;

  int? get cantonLugarTrampa => _cantonSincronizado;

  int? get provinciaSincronizada => _provinciaSincronizada;

  bool get esParroquia => _esparroquia;

  set setProvinciaSincronizada(int valor) => _provinciaSincronizada = valor;

  set setCantonLugarTrampa(int? valor) => _cantonSincronizado = valor;

  set setParroquiaLugarInstalacion(int? valor) => _parroquiaInstalacion = valor;

  set setNumeroLugarInstalacion(int valor) => _numeroLugarInstalacion = valor;

  getProvinciasSincronizadas() async {
    _listaProvinciasSincronizadas =
        await _trampeoLugar.getProvinciasSincronizadas();
    _listaProvinciasSincronizadas.insert(
        0, LocalizacionModelo(idGuia: 0, nombre: '--'));

    notifyListeners();
  }

  getCantonesSincronizados(int? provincia) async {
    _provinciaSincronizada = provincia;
    if (provincia != 0) {
      _listaCantonesLugarInstalacion =
          await DBTrampeoVigilancia().getCantonesSincronizadas(provincia);
      _listaCantonesLugarInstalacion.insert(
          0, LocalizacionModelo(idGuia: 0, nombre: '--'));
      limpiarDesdeLugar();
    } else {
      limpiarDesdeCanton();
    }
  }

  getLugarInstalacion(int? canton) async {
    _cantonSincronizado = canton;
    if (canton != 0) {
      _listaLugarInstalacion =
          await DBTrampeoVigilancia().getLugarInstalacion(canton);
      _listaLugarInstalacion.insert(
          0, Trampas(idlugarinstalacion: 0, lugarinstalacion: '--'));
      limpiarDesdeNumeroYParroquia();
    } else {
      limpiarDesdeLugar();
    }
  }

  verificarLugarInstalacion(int? lugarInstalacion) async {
    if (lugarInstalacion != 0) {
      _parroquiaInstalacion = 0;
      _numeroLugarInstalacion = 0;
      Trampas? lugar;
      lugar = await DBTrampeoVigilancia()
          .getNombreInstalacion(_cantonSincronizado, lugarInstalacion);

      if (lugar!.lugarinstalacion == 'Sitio de producción') {
        _esparroquia = true;
        getParroquiaSincronizada(lugarInstalacion);
      } else {
        _esparroquia = false;
        getNumeroLugarInstalacion(lugarInstalacion);
      }
    } else {
      limpiarDesdeNumeroYParroquia();
    }
  }

  getNumeroLugarInstalacion(int? lugarInstalacion) async {
    _lugarInstalacion = lugarInstalacion;
    if (lugarInstalacion != 0 && lugarInstalacion != null) {
      _listaNumeroLugarInstalacion = await DBTrampeoVigilancia()
          .getNumeroLugarIsntalacion(_cantonSincronizado, lugarInstalacion);
      _listaNumeroLugarInstalacion.insert(
          0, Trampas(idlugarinstalacion: 0, numerolugarinstalacion: '--'));
    }
    _listaParroquia = [];
    notifyListeners();
  }

  getParroquiaSincronizada(int? lugarInstalacion) async {
    _lugarInstalacion = lugarInstalacion;
    if (lugarInstalacion != 0) {
      _listaParroquia = await DBTrampeoVigilancia()
          .getParroquias(_cantonSincronizado, lugarInstalacion);
      _listaParroquia.insert(0, LocalizacionModelo(idGuia: 0, nombre: '--'));
    }
    _listaNumeroLugarInstalacion = [];
    notifyListeners();
  }

  limpiarDesdeCanton() async {
    _cantonSincronizado = 0;
    _lugarInstalacion = 0;
    _parroquiaInstalacion = 0;
    _numeroLugarInstalacion = 0;
    _listaCantonesLugarInstalacion = [];
    _listaLugarInstalacion = [];
    _listaNumeroLugarInstalacion = [];
    _listaParroquia = [];
    notifyListeners();
  }

  limpiarDesdeLugar() async {
    _lugarInstalacion = 0;
    _parroquiaInstalacion = 0;
    _numeroLugarInstalacion = 0;
    _listaLugarInstalacion = [];
    _listaNumeroLugarInstalacion = [];
    _listaParroquia = [];
    notifyListeners();
  }

  limpiarDesdeNumeroYParroquia() async {
    _numeroLugarInstalacion = 0;
    _parroquiaInstalacion = 0;
    _listaNumeroLugarInstalacion = [];
    _listaParroquia = [];
    notifyListeners();
  }

  resetLugarTrampeoFormulario() {
    _provinciaSincronizada = 0;
    _cantonSincronizado = 0;
    _lugarInstalacion = 0;
    _parroquiaInstalacion = 0;
    _numeroLugarInstalacion = 0;
    _esparroquia = false;
    _listaCantonesLugarInstalacion = [];
    _listaLugarInstalacion = [];
    _listaNumeroLugarInstalacion = [];
    _listaParroquia = [];
  }

  resetLugarTrampeoFormularioNotificar() {
    _provinciaSincronizada = 0;
    _cantonSincronizado = 0;
    _lugarInstalacion = 0;
    _parroquiaInstalacion = 0;
    _numeroLugarInstalacion = 0;
    _esparroquia = false;
    _listaCantonesLugarInstalacion = [];
    _listaLugarInstalacion = [];
    _listaNumeroLugarInstalacion = [];
    _listaParroquia = [];
    // _listaProvinciasSincronizadas.clear();
    notifyListeners();
  }

  void resetListaProvinciaSincronizadas() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _listaProvinciasSincronizadas = [];
    _listaProvinciasSincronizadas.clear();
    _listaProvinciasSincronizadas
        .add(LocalizacionModelo(idGuia: 10, nombre: '--'));
    notifyListeners();
  }

  verificarFormulario() {
    bool valido = true;
    if (_provinciaSincronizada == 0) valido = false;
    if (_cantonSincronizado == 0) valido = false;
    if (_lugarInstalacion == 0) valido = false;
    if (_esparroquia) {
      if (_parroquiaInstalacion == 0) valido = false;
    } else {
      if (_numeroLugarInstalacion == 0) valido = false;
    }

    return valido;
  }

  getFormatoFechaDate(DateTime fecha) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(fecha);
  }

  //************************************************
  // FORMULARIO NUEVO REGISTRO DE TRAMPA           *
  //************************************************

  List<Trampas> _listaTrampas = [];
  List<Trampas> _listaTrampasAux = [];
  List<TrampaDetallemodelo> _listaTrampasDetalle = [];
  int _cantidadTrampasLlenadas = 0;
  int _cantidadTrampasInactivadas = 0;
  int? _trampaSeleccionada = 0;
  int _indexTrampaGuardado = 0;
  String? _cambioFeromonas = '';
  String? _cambioPapelAbsorbente = '';
  String? _cambioAceite = '';
  String? _cambioTrampa = '';
  String? _muestraLaboratorio = '';
  final String _condicionTrampa = '--';
  String _mensajeValidacionTrampa = '';
  bool esCambioFeromonaVacio = false;
  bool esCambioPapelVacio = false;
  bool esCambioAceiteVacio = false;
  bool esCambioTrampaVacio = false;
  bool esMuestraLaboratorioVacio = false;
  bool _estaGuardando = true;
  final _formKey = GlobalKey<FormState>();
  List<TrampasCompletadasModelo> listaTrampasCompletadas = [];

  GlobalKey<FormState> get formkey => _formKey;

  List<Trampas> get listaTrampas => _listaTrampas;

  List<TrampaDetallemodelo> get listaTrampasDetalle => _listaTrampasDetalle;

  int get cantidadTrampasLlenadas => _cantidadTrampasLlenadas;

  int get cantidadTrampasInactivadas => _cantidadTrampasInactivadas;

  int? get trampaSeleccionada => _trampaSeleccionada;

  int get indexTrampaGuardado => _indexTrampaGuardado;

  String? get cambioFeromonas => _cambioFeromonas;

  String? get cambioPapelAbsorbente => _cambioPapelAbsorbente;

  String? get cambioAceite => _cambioAceite;

  String? get cambioTrampa => _cambioTrampa;

  String? get muestraLaboratorio => _muestraLaboratorio;

  String get condicionTrampa => _condicionTrampa;

  String get mensajeValidacionTrampa => _mensajeValidacionTrampa;

  bool get estaGuardando => _estaGuardando;

  set setTrampaSeleccionada(valor) => _trampaSeleccionada = valor;

  set setCambioFeromonas(valor) {
    _cambioFeromonas = valor;
    notifyListeners();
  }

  set setCambioPapelAbsorbente(valor) {
    _cambioPapelAbsorbente = valor;
    notifyListeners();
  }

  set setCambioAceite(valor) {
    _cambioAceite = valor;
    notifyListeners();
  }

  set setCambioTrampa(valor) {
    _cambioTrampa = valor;
    notifyListeners();
  }

  set setMuestraLaboratorio(valor) {
    _muestraLaboratorio = valor;
    notifyListeners();
  }

  set setCantidadTrampasInactivadas(valor) {
    _cantidadTrampasInactivadas = valor;
    notifyListeners();
  }

  set setMensajeValidacionTrampa(valor) {
    _mensajeValidacionTrampa = valor;
    notifyListeners();
  }

  set setEstaGuardando(bool valor) => _estaGuardando = valor;

  bool verificarFormularioNuevaTrampa() {
    bool esFormularioCompleto = false;

    cambioFeromonas!.isEmpty
        ? esCambioFeromonaVacio = true
        : esCambioFeromonaVacio = false;

    cambioPapelAbsorbente!.isEmpty
        ? esCambioPapelVacio = true
        : esCambioPapelVacio = false;

    cambioAceite!.isEmpty
        ? esCambioAceiteVacio = true
        : esCambioAceiteVacio = false;

    cambioTrampa == ''
        ? esCambioTrampaVacio = true
        : esCambioTrampaVacio = false;

    muestraLaboratorio == ''
        ? esMuestraLaboratorioVacio = true
        : esMuestraLaboratorioVacio = false;

    if (!esCambioFeromonaVacio &&
        !esCambioPapelVacio &&
        !esCambioAceiteVacio &&
        !esCambioTrampaVacio &&
        !esMuestraLaboratorioVacio) {
      esFormularioCompleto = true;
    }

    notifyListeners();

    return esFormularioCompleto;
  }

  guardarFormularioNuevaTrampa() async {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();

    UsuarioModelo? listaUsuario = UsuarioModelo();
    listaUsuario = await DBHomeProvider.db.getUsuario();

    if (modeloFormulario.numeroEspecimen == '') {
      modeloFormulario.numeroEspecimen = '0';
    }

    //Comprobar si la trampa ya fue llenada
    if (_listaTrampas[_trampaSeleccionada!].actualizado == true) {
      listaTrampasCompletadas.asMap().forEach((i, value) {
        if (value.index == _trampaSeleccionada) {
          _indexTrampaGuardado = i;
        }
      });

      _listaTrampasDetalle[_indexTrampaGuardado].propiedadFinca =
          modeloFormulario.propiedad;
      _listaTrampasDetalle[_indexTrampaGuardado].condicionTrampa =
          modeloFormulario.condicionTrampa;
      _listaTrampasDetalle[_indexTrampaGuardado].especie =
          modeloFormulario.especie;
      _listaTrampasDetalle[_indexTrampaGuardado].procedencia =
          modeloFormulario.procedencia;
      _listaTrampasDetalle[_indexTrampaGuardado].condicionCultivo =
          modeloFormulario.condicionCultivo;
      _listaTrampasDetalle[_indexTrampaGuardado].etapaCultivo =
          modeloFormulario.etapaCultivo;
      _listaTrampasDetalle[_indexTrampaGuardado].exposicion =
          modeloFormulario.exposicion;
      _listaTrampasDetalle[_indexTrampaGuardado].cambioFeromona =
          modeloFormulario.cambioFeromona;
      _listaTrampasDetalle[_indexTrampaGuardado].cambioPapel =
          modeloFormulario.cambioPapel;
      _listaTrampasDetalle[_indexTrampaGuardado].cambioAceite =
          modeloFormulario.cambioAceite;
      _listaTrampasDetalle[_indexTrampaGuardado].cambioTrampa =
          modeloFormulario.cambioTrampa;
      _listaTrampasDetalle[_indexTrampaGuardado].numeroEspecimenes =
          int.parse(modeloFormulario.numeroEspecimen!);
      _listaTrampasDetalle[_indexTrampaGuardado].diagnosticoVisual =
          modeloFormulario.diagnosticoVisual;
      _listaTrampasDetalle[_indexTrampaGuardado].fasePlaga =
          modeloFormulario.etapaPlaga;
      _listaTrampasDetalle[_indexTrampaGuardado].observaciones =
          modeloFormulario.observaciones;
      _listaTrampasDetalle[_indexTrampaGuardado].envioMuestra =
          modeloFormulario.muestraLaboratorio;
      _listaTrampasDetalle[_indexTrampaGuardado].llenado = true;
      _listaTrampas[_trampaSeleccionada!].llenado = true;
      listaTrampasCompletadas[_indexTrampaGuardado].idTrampa =
          _listaTrampas[_trampaSeleccionada!].idTrampa;
      listaTrampasCompletadas[_indexTrampaGuardado].muestraLaboratorio =
          modeloFormulario.muestraLaboratorio;
    } else {
      TrampaDetallemodelo trampaDetalle = TrampaDetallemodelo(
        idTablet: _idTablet,
        fechaInstalacion: _listaTrampas[_trampaSeleccionada!].fechainstalacion,
        codigoTrampa: _listaTrampas[_trampaSeleccionada!].codigotrampa,
        tipoTrampa: _listaTrampas[_trampaSeleccionada!].tipotrampa,
        idProvincia: _listaTrampas[_trampaSeleccionada!].idprovincia.toString(),
        nombreProvincia: _listaTrampas[_trampaSeleccionada!].provincia,
        idCanton: _listaTrampas[_trampaSeleccionada!].idcanton.toString(),
        nombreCanton: _listaTrampas[_trampaSeleccionada!].canton,
        idParroquia: _listaTrampas[_trampaSeleccionada!].idparroquia.toString(),
        nombreParroquia: _listaTrampas[_trampaSeleccionada!].parroquia,
        estadoTrampa: _listaTrampas[_trampaSeleccionada!].estadotrampa,
        coordenadaX: _listaTrampas[_trampaSeleccionada!].coordenadax,
        coordenadaY: _listaTrampas[_trampaSeleccionada!].coordenaday,
        coordenadaZ: _listaTrampas[_trampaSeleccionada!].coordenadaz,
        idLugarInstalacion:
            _listaTrampas[_trampaSeleccionada!].idlugarinstalacion.toString(),
        nombreLugarInstalacion:
            _listaTrampas[_trampaSeleccionada!].lugarinstalacion,
        numeroLugarInstalacion: int.parse(
            _listaTrampas[_trampaSeleccionada!].numerolugarinstalacion!),
        fechaInspeccion: DateTime.now(),
        semana: '${Jiffy().week}',
        usuarioId: listaUsuario?.identificador,
        usuario: listaUsuario?.nombre,
        propiedadFinca: modeloFormulario.propiedad,
        condicionTrampa: modeloFormulario.condicionTrampa,
        especie: modeloFormulario.especie,
        procedencia: modeloFormulario.procedencia,
        condicionCultivo: modeloFormulario.condicionCultivo,
        etapaCultivo: modeloFormulario.etapaCultivo,
        exposicion: modeloFormulario.exposicion,
        cambioFeromona: modeloFormulario.cambioFeromona,
        cambioPapel: modeloFormulario.cambioPapel,
        cambioAceite: modeloFormulario.cambioAceite,
        cambioTrampa: modeloFormulario.cambioTrampa,
        numeroEspecimenes: int.parse(modeloFormulario.numeroEspecimen!),
        diagnosticoVisual: modeloFormulario.diagnosticoVisual,
        fasePlaga: modeloFormulario.etapaPlaga,
        observaciones: modeloFormulario.observaciones,
        envioMuestra: modeloFormulario.muestraLaboratorio,
        tabletId: listaUsuario?.identificador,
        tabletVersionBase: SCHEMA_VERSION,
      );

      trampaDetalle.llenado = true;
      //seleccionarTrampa(_trampaSeleccionada);
      _listaTrampasDetalle.add(trampaDetalle);
      _listaTrampas[_trampaSeleccionada!].llenado = true;
      _listaTrampas[_trampaSeleccionada!].actualizado = true;
      listaTrampasCompletadas.add(TrampasCompletadasModelo(
          index: _trampaSeleccionada,
          idTrampa: _listaTrampas[_trampaSeleccionada!].idTrampa,
          codigoTrampa: trampaDetalle.codigoTrampa,
          muestraLaboratorio: trampaDetalle.envioMuestra));
    }

    _cantidadTrampasLlenadas += 1;

    await Future.delayed(const Duration(seconds: 1));
    _estaGuardando = false;
    _estaCargando = false;
    _icon = _iconoCheck;

    notifyListeners();
  }

  guardarFormularioInactivo() async {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();

    UsuarioModelo? listaUsuario = UsuarioModelo();
    listaUsuario = await DBHomeProvider.db.getUsuario();

    if (modeloFormulario.numeroEspecimen == '') {
      modeloFormulario.numeroEspecimen = '0';
    }

    // verificar si la trampa ya fue llenada
    if (_listaTrampas[_trampaSeleccionada!].llenado == true) {
      listaTrampasCompletadas.asMap().forEach((i, value) {
        if (value.index == _trampaSeleccionada) {
          _indexTrampaGuardado = i;
        }
      });

      _listaTrampasDetalle[_indexTrampaGuardado].estadoTrampa = 'inactivo';

      for (var e in listaTrampasCompletadas) {
        if (e.index == _indexTrampaGuardado) {
          e.muestraLaboratorio = modeloFormulario.muestraLaboratorio;
        }
      }
    } else {
      TrampaDetallemodelo trampaDetalle = TrampaDetallemodelo(
        idTablet: _idTablet,
        fechaInstalacion: _listaTrampas[_trampaSeleccionada!].fechainstalacion,
        codigoTrampa: _listaTrampas[_trampaSeleccionada!].codigotrampa,
        tipoTrampa: _listaTrampas[_trampaSeleccionada!].tipotrampa,
        idProvincia: _listaTrampas[_trampaSeleccionada!].idprovincia.toString(),
        nombreProvincia: _listaTrampas[_trampaSeleccionada!].provincia,
        idCanton: _listaTrampas[_trampaSeleccionada!].idcanton.toString(),
        nombreCanton: _listaTrampas[_trampaSeleccionada!].canton,
        idParroquia: _listaTrampas[_trampaSeleccionada!].idparroquia.toString(),
        nombreParroquia: _listaTrampas[_trampaSeleccionada!].parroquia,
        estadoTrampa: _listaTrampas[_trampaSeleccionada!].estadotrampa,
        coordenadaX: _listaTrampas[_trampaSeleccionada!].coordenadax,
        coordenadaY: _listaTrampas[_trampaSeleccionada!].coordenaday,
        coordenadaZ: _listaTrampas[_trampaSeleccionada!].coordenadaz,
        idLugarInstalacion:
            _listaTrampas[_trampaSeleccionada!].idlugarinstalacion.toString(),
        nombreLugarInstalacion:
            _listaTrampas[_trampaSeleccionada!].lugarinstalacion,
        numeroLugarInstalacion: int.parse(
            _listaTrampas[_trampaSeleccionada!].numerolugarinstalacion!),
        fechaInspeccion: DateTime.now(),
        semana: '${Jiffy().week}',
        usuarioId: listaUsuario?.identificador,
        usuario: listaUsuario?.nombre,
        propiedadFinca: '',
        condicionTrampa: '--',
        especie: '--',
        procedencia: '--',
        condicionCultivo: '--',
        etapaCultivo: '--',
        exposicion: '',
        cambioFeromona: '',
        cambioPapel: '',
        cambioAceite: '',
        cambioTrampa: '',
        numeroEspecimenes: 0,
        diagnosticoVisual: '--',
        fasePlaga: '--',
        observaciones: '',
        envioMuestra: '',
        tabletId: listaUsuario?.identificador,
        tabletVersionBase: SCHEMA_VERSION,
      );

      trampaDetalle.llenado = false;
      _listaTrampasDetalle.add(trampaDetalle);

      _listaTrampas[_trampaSeleccionada!].llenado = false;
      seleccionarTrampa(_trampaSeleccionada);
      listaTrampasCompletadas.add(TrampasCompletadasModelo(
          index: _trampaSeleccionada,
          codigoTrampa: trampaDetalle.codigoTrampa,
          muestraLaboratorio: trampaDetalle.envioMuestra));
    }

    _estaGuardando = false;
    _icon = _iconoCheck;
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  encerarCamposNuevaTrampa() {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    esCambioFeromonaVacio = false;
    esCambioPapelVacio = false;
    esCambioAceiteVacio = false;
    esCambioTrampaVacio = false;
    esMuestraLaboratorioVacio = false;

    _cambioFeromonas = '';
    _cambioPapelAbsorbente = '';
    _cambioAceite = '';
    _cambioTrampa = '';
    _muestraLaboratorio = '';
    _mensajeValidacionTrampa = '';

    listaTrampasCompletadas.asMap().forEach((i, value) {
      // debugPrint('sleecionado=$_trampaSeleccionada, index=${value.index}');
      if (value.index == _trampaSeleccionada) {
        // debugPrint('sleecionado=$_trampaSeleccionada, indexDetalle=$i');
        _indexTrampaGuardado = i;
      }
    });

    if (listaTrampas[trampaSeleccionada!].actualizado == true) {
      _cambioFeromonas =
          listaTrampasDetalle[_indexTrampaGuardado].cambioFeromona;
      _cambioPapelAbsorbente =
          listaTrampasDetalle[_indexTrampaGuardado].cambioPapel;
      _cambioAceite = listaTrampasDetalle[_indexTrampaGuardado].cambioAceite;
      _cambioTrampa = listaTrampasDetalle[_indexTrampaGuardado].cambioTrampa;
      _muestraLaboratorio =
          listaTrampasDetalle[_indexTrampaGuardado].envioMuestra;

      modeloFormulario.cambioFeromona =
          listaTrampasDetalle[_indexTrampaGuardado].cambioFeromona;
      modeloFormulario.cambioPapel =
          listaTrampasDetalle[_indexTrampaGuardado].cambioPapel;
      modeloFormulario.cambioAceite =
          listaTrampasDetalle[_indexTrampaGuardado].cambioAceite;
      modeloFormulario.cambioTrampa =
          listaTrampasDetalle[_indexTrampaGuardado].cambioTrampa;
      modeloFormulario.muestraLaboratorio =
          listaTrampasDetalle[_indexTrampaGuardado].envioMuestra;
    }
  }

  getTrampasFiltradas() async {
    if (_esparroquia) {
      debugPrint('es parroquia');
      _listaTrampasAux = await DBTrampeoVigilancia().getTrampasPorParroquia(
        _cantonSincronizado,
        _lugarInstalacion,
        _parroquiaInstalacion,
      );
    } else {
      debugPrint('es numero de lugar');
      _listaTrampasAux = await DBTrampeoVigilancia().getTrampasPorNumero(
        _cantonSincronizado,
        _lugarInstalacion,
        _numeroLugarInstalacion.toString(),
      );
    }

    _listaTrampas = _listaTrampasAux;
    listaTrampasCompletadas.clear();
    notifyListeners();
  }

  seleccionarTrampa(index) {
    _listaTrampas[index].actualizado = true;
    _cantidadTrampasLlenadas += 1;
    notifyListeners();
  }

  calcularDiasExposicion(fecha) {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();

    if (fecha != '' && fecha != null) {
      DateTime fechaParseada = DateTime.parse(fecha);

      int dias = disTranscurridosDesde(fechaParseada, DateTime.now());

      modeloFormulario.exposicion = '$dias días';
    } else {
      modeloFormulario.exposicion = '1 día';
    }
  }

  inactivarTrampa(index) {
    debugPrint('index inactivar $index');
    _listaTrampas[index].estadotrampa = 'inactivo';
    _listaTrampas[index].activo = false;
    _cantidadTrampasInactivadas += 1;
    guardarFormularioInactivo();
    notifyListeners();
  }

  obtenerIndexTrampa<int>(codigoTrampa) {
    var valor = 0;
    _listaTrampas.asMap().forEach((i, value) {
      if (value.codigotrampa == codigoTrampa) {
        valor = i;
      }
    });

    return valor;
  }

  activarTrampa(index) {
    if (!_listaTrampas[index].activo!) {
      listaTrampasCompletadas.asMap().forEach((i, value) {
        if (value.index == _trampaSeleccionada) {
          _indexTrampaGuardado = i;
        }
      });

      if (_listaTrampas[index].llenado == false) {
        listaTrampasCompletadas.removeAt(_indexTrampaGuardado);
        _listaTrampas[index].actualizado = null;
      }

      _listaTrampasDetalle[_indexTrampaGuardado].estadoTrampa = 'activo';
      _listaTrampas[index].estadotrampa = 'activo';

      _listaTrampas[index].activo = true;

      if (_listaTrampasDetalle[_indexTrampaGuardado].llenado != true) {
        _listaTrampasDetalle.removeAt(_indexTrampaGuardado);
      }
    }
    _cantidadTrampasInactivadas -= 1;

    notifyListeners();
  }

  validarRadioButtons() {
    if (cambioFeromonas!.isEmpty) {
      esCambioFeromonaVacio = true;
    }
    notifyListeners();
  }

  generarIdTablet() {
    _idTablet = random.nextInt(90) + 1;
  }

//************************************************
// FORMULARIO ORDEN DE TRABAJO DE LABORATORIO    *
//************************************************

  String? _productoDestinoOrdenLaboratorio = '--';

  String? _codigoTrampaParaOrdenLaboratorio = '';

  String trampaParaOrden = '--';

  String? _prediagnostico = '';

  String? _productoQuimico = '';

  final String _codigoCampoMuestra = '--';

  String _codigoMuestraParaOrdenLaboratorio = '--';

  String _mensajeValidacionlaboratorio = '';

  bool _analisisOrdenLaboratorioInsectos = false;

  bool _analisisOrdenLaboratorioPlagas = false;

  bool _esProductoQuimicoVacio = false;

  bool _esEntomologicoVacio = false;

  bool _estadoGuardandoOrdenlaboratorio = false;

  int? _indexCodigoTrampaLaboratorio;

  int _numeroMuestrasLaboratorioAgregadas = 0;

  final List<TrampasCompletadasModelo> _listaTrampasParaLaboratorio = [];

  final List<OrdenTrabajoLaboratorioModelo> _listaMuestraLaboratorio = [];

  int? _numeroFotosTrampa = 0;

  String? get productoOrdenLaboratorio => _productoDestinoOrdenLaboratorio;

  String? get codigoTrampaParaOrdenLaboratorio =>
      _codigoTrampaParaOrdenLaboratorio;

  int? get indexCodigoTrampaLaboratorios => _indexCodigoTrampaLaboratorio;

  get productoQuimico => _productoQuimico;

  get esEntomologicoVacio => _esEntomologicoVacio;

  get analisisOrdenLaboratorioInsectos => _analisisOrdenLaboratorioInsectos;

  get analisisOrdenLaboratorioPlagas => _analisisOrdenLaboratorioPlagas;

  get esProductoQuimicoVacio => _esProductoQuimicoVacio;

  get codigoCampoMuestra => _codigoCampoMuestra;

  get codigoMuestraParaOrdenLaboratorio => _codigoMuestraParaOrdenLaboratorio;

  get prediagnostico => _prediagnostico;

  get estadoGuardandoOrdenlaboratorio => _estadoGuardandoOrdenlaboratorio;

  get numeroMuestrasLaboratorioAgregadas => _numeroMuestrasLaboratorioAgregadas;

  List<TrampasCompletadasModelo> get listaTrampasParaLaboratorio =>
      _listaTrampasParaLaboratorio;

  List<OrdenTrabajoLaboratorioModelo> get listaMuestraLaboratorio =>
      _listaMuestraLaboratorio;

  get numeroFotosTrampa => _numeroFotosTrampa;

  get mensajeValidacionlaboratorio => _mensajeValidacionlaboratorio;

  set codigoTrampaParaOrdenLaboratorio(valor) {
    _codigoTrampaParaOrdenLaboratorio = valor;
  }

  set productoOrdenLaboratorio(valor) =>
      _productoDestinoOrdenLaboratorio = valor;

  set setAnalisisOrdenLaboratorioInsectos(valor) {
    _analisisOrdenLaboratorioInsectos = valor;
    notifyListeners();
  }

  set setAnalisisOrdenLaboratorioPlagas(valor) {
    _analisisOrdenLaboratorioPlagas = valor;
    notifyListeners();
  }

  set setPrediagnostico(valor) => _prediagnostico = valor;

  set setPoductoQuimico(valor) {
    _productoQuimico = valor;
    notifyListeners();
  }

  set setCodigoMuestraParaOrdenLaboratorio(valor) {
    _codigoMuestraParaOrdenLaboratorio = valor;
    notifyListeners();
  }

  set setEstadoGuardandoOrdenlaboratorio(valor) =>
      _estadoGuardandoOrdenlaboratorio = valor;

  set setNumeroFotosTrampa(valor) {
    _numeroFotosTrampa = valor;
    notifyListeners();
  }

  set setMensajeValidacionlaboratorio(valor) {
    _mensajeValidacionlaboratorio = valor;
    notifyListeners();
  }

  getTrampasParaLabortorio() {
    int index = 0;
    List<TrampasCompletadasModelo> listaAux = [];

    listaAux.clear();
    listaAux.addAll(_listaTrampasParaLaboratorio);

    _listaTrampasParaLaboratorio.clear();
    _listaTrampasParaLaboratorio.add(TrampasCompletadasModelo(
        index: index, codigoTrampa: '--', muestraLaboratorio: 'No'));

    for (var item in listaTrampasCompletadas) {
      index++;
      if (item.muestraLaboratorio == 'Si') {
        _listaTrampasParaLaboratorio.add(TrampasCompletadasModelo(
            index: index,
            idTrampa: item.idTrampa,
            codigoTrampa: item.codigoTrampa,
            muestraLaboratorio: item.muestraLaboratorio));
      }
    }

    listaAux.asMap().forEach((i, value) {
      if (value.codigoTrampa == _listaTrampasParaLaboratorio[i].codigoTrampa) {
        _listaTrampasParaLaboratorio[i].secuencialTrampa =
            value.secuencialTrampa;
      }
    });
  }

  void encerarTrampasParaLaboratorio() {
    _listaTrampasParaLaboratorio.clear();
  }

  Future<String> generarCodigoMuestra(String? codigoTrampa) async {
    List numeroTrampas;
    int? numeroSecuencial;

    List<TrampasCompletadasModelo> listaIndexCodigoTrampa =
        _listaTrampasParaLaboratorio
            .where((e) => e.codigoTrampa!.contains(codigoTrampa!))
            .toList();

    if (listaIndexCodigoTrampa[0].secuencialTrampa == null) {
      numeroTrampas =
          await DBTrampeoVigilancia().getSecuencialOrden(codigoTrampa);
      numeroSecuencial = numeroTrampas[0]['secuencialorden'];
    } else {
      numeroSecuencial = listaIndexCodigoTrampa[0].secuencialTrampa;
    }

    numeroSecuencial = numeroSecuencial ?? 0;

    numeroSecuencial += 1;

    _numeroSecuencial = numeroSecuencial;

    String secuencia = numeroSecuencial.toString().padLeft(5, "0");

    String codigoMuestra = 'TVF-$secuencia';

    return codigoMuestra;
  }

  bool verificarFormularioOrdenLaboratorio() {
    bool esFormularioCompleto = true;

    if (_productoQuimico!.isEmpty) {
      esFormularioCompleto = false;
      _esProductoQuimicoVacio = true;
    } else {
      esFormularioCompleto = true;
      _esProductoQuimicoVacio = false;
    }

    notifyListeners();

    return esFormularioCompleto;
  }

  guardarOrdenLaboratorio() {
    _listaMuestraLaboratorio.add(
      OrdenTrabajoLaboratorioModelo(
        idTablet: _idTablet,
        actividadOrigen: 'Vigilancia fitosanitaria',
        analisis: 'Entomológico',
        codigoMuestra: _codigoMuestraParaOrdenLaboratorio,
        conservacion: 'Envase apropiado',
        tipoMuestra: 'Insectos en alcohol',
        descripcionSintomas: 'N/A',
        faseFenologica: 'N/A',
        nombreProducto: _productoDestinoOrdenLaboratorio,
        pesoMuestra: 0,
        prediagnostico: _prediagnostico,
        tipoCliente: 'Interno',
        aplicacionProductoQuimico: _productoQuimico,
        codigoTrampa: _codigoTrampaParaOrdenLaboratorio,
      ),
    );

    int? index;
    _listaTrampasParaLaboratorio.asMap().forEach((i, value) {
      if (value.codigoTrampa == _codigoTrampaParaOrdenLaboratorio) {
        index = i;
      }
    });

    _listaTrampasParaLaboratorio[index!].secuencialTrampa = _numeroSecuencial;

    _icon = _iconoCheck;
    _estadoGuardandoOrdenlaboratorio = false;
    _numeroMuestrasLaboratorioAgregadas += 1;
    notifyListeners();
  }

  ///Elimina la orden seleccionada y reorganiza los códigos de las muestras por trampa
  eliminarOrdenLaboratorio({required index, codigoTrampa}) async {
    List numeroTrampas;
    int? numeroSecuencial;

    _listaMuestraLaboratorio.removeAt(index);

    List<OrdenTrabajoLaboratorioModelo> listaIndexCodigoTrampa =
        _listaMuestraLaboratorio
            .where((e) => e.codigoTrampa!.contains(codigoTrampa))
            .toList();

    numeroTrampas =
        await DBTrampeoVigilancia().getSecuencialOrden(codigoTrampa);
    numeroSecuencial = numeroTrampas[0]['secuencialorden'];
    numeroSecuencial = numeroSecuencial ?? 0;

    for (var e in listaIndexCodigoTrampa) {
      numeroSecuencial = numeroSecuencial! + 1;
      String secuencia = numeroSecuencial.toString().padLeft(5, "0");
      String codigoMuestra = 'TVF-$secuencia';
      e.codigoMuestra = codigoMuestra;
    }

    List<TrampasCompletadasModelo> listaIndexCodigoTrampasCompletadas =
        _listaTrampasParaLaboratorio
            .where((e) => e.codigoTrampa!.contains(codigoTrampa))
            .toList();

    _listaTrampasParaLaboratorio[listaIndexCodigoTrampasCompletadas[0].index!]
        .secuencialTrampa = numeroSecuencial;

    _numeroMuestrasLaboratorioAgregadas--;
    notifyListeners();
  }

  limpiarOrdenLaboratorio() {
    _esProductoQuimicoVacio = false;
    _esEntomologicoVacio = false;
    _analisisOrdenLaboratorioInsectos = false;
    _analisisOrdenLaboratorioPlagas = false;
    _productoDestinoOrdenLaboratorio = '--';
    _productoQuimico = '';
    _estadoGuardandoOrdenlaboratorio = false;
    _codigoTrampaParaOrdenLaboratorio = '';
    _codigoMuestraParaOrdenLaboratorio = '--';
    _mensajeValidacionlaboratorio = '';
  }

  limpiarListaOrdenesLaboratorio() {
    _listaMuestraLaboratorio.clear();
    _numeroMuestrasLaboratorioAgregadas = 0;
  }

  eliminarImagen() async {
    await _image?.delete();
    _image = null;
    _imagenPath = null;
    notifyListeners();
  }

//************************************************
// FINALIZAR TRAMPA                              *
//************************************************

  File? _image;

  String? _imagenPath;

  // ignore: unused_field
  File? _imagenFile;

  // ignore: unused_field
  String? _base64Iage;

  int? _cantidadTrampasUtilizadas = 0;

  int? cantidadTrampasDetalle = 0;

  File? get imagen => _image;

  bool _estaCargando = false;

  get estaCargando => _estaCargando;

  get cantidadTrampasUtilizadas => _cantidadTrampasUtilizadas;

  set setImagenBase64(valor) => _base64Iage = valor;

  set setImagen(valor) {
    _image = File(valor);
    _imagenPath = valor;
  }

  set setImagenFile(valor) {
    _imagenFile = File(valor);
  }

  set setEstaCargnado(valor) {
    _estaCargando = valor;
    notifyListeners();
  }

  bool verificarTrampasLlenadas() {
    if (_listaTrampasDetalle.isNotEmpty) return true;
    return false;
  }

  finalizarProcesoGuardado() async {
    DateTime fechaActual = DateTime.now();
    InspeccionPadreModelo inspeccionPadre = InspeccionPadreModelo();

    int? idInspeccionPadre;

    try {
      inspeccionPadre.idTablet = _listaTrampasDetalle[0].idTablet;
      inspeccionPadre.fechaInspeccion = fechaActual;
      inspeccionPadre.usuarioId = _listaTrampasDetalle[0].usuarioId;
      inspeccionPadre.usuario = _listaTrampasDetalle[0].usuario;
      inspeccionPadre.tabletId = _listaTrampasDetalle[0].tabletId;
      inspeccionPadre.tabletVersionBase =
          _listaTrampasDetalle[0].tabletVersionBase;

      if (_image != null && _listaTrampasDetalle.isNotEmpty) {
        debugPrint("asignando fotografía");
        for (var e in _listaTrampasDetalle) {
          debugPrint(_imagenPath);
          e.foto = _imagenPath;
        }
      }

      if (_listaTrampasDetalle.isNotEmpty) {
        debugPrint("Guardando inspeccion padre");
        idInspeccionPadre =
            await DBTrampeoVigilancia().guardarInspeccionPadre(inspeccionPadre);
      }

      if (_listaTrampasDetalle.isNotEmpty) {
        for (var e in _listaTrampasDetalle) {
          debugPrint("Guardando detalles de trampa");
          e.idPadre = idInspeccionPadre;
          e.fechaInspeccion = fechaActual;

          await DBTrampeoVigilancia().guardarDetalleTrampa(e);
          await DBTrampeoVigilancia().updateTrampaCompletada(1, e.codigoTrampa);
        }
      }

      if (_listaMuestraLaboratorio.isNotEmpty) {
        for (var e in _listaMuestraLaboratorio) {
          debugPrint("Guardando ordenes de laboratorio");
          e.idPadre = idInspeccionPadre;
          await DBTrampeoVigilancia().guardarMuestralaboratorio(e);
        }
      }

      _mensajeValidacion = 'Los registros fueron almacenados';
      _estaCargando = false;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      Get.back();
    } catch (e) {
      _mensajeValidacion = 'Error: $e';
      _estaCargando = false;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 4));
      Get.back();
      throw 'Hubo un error: $e';
    }
  }

  getCantidadTrampasUtilizadas() async {
    final res = await DBTrampeoVigilancia().getCantidadTrampasUtilizadas();
    _cantidadTrampasUtilizadas = res[0]['cantidad'];
    notifyListeners();
  }

  getCantidadTrampasDetalle() async {
    final res = await DBTrampeoVigilancia().getCantidadTrampasDetalle();
    cantidadTrampasDetalle = res[0]['cantidad'];
    notifyListeners();
  }

  sincronizarRegistrosUp() async {
    List<InspeccionPadreModelo> inspeccionPadre = [];
    List<TrampaDetallemodelo> trampasDetalle = [];
    List<OrdenTrabajoLaboratorioModelo> ordenLaboratorio = [];

    inspeccionPadre = await DBTrampeoVigilancia().getInspeccionPadre();
    trampasDetalle = await DBTrampeoVigilancia().getTrampasDetalle();
    ordenLaboratorio = await DBTrampeoVigilancia().getOrdeneslaboratorio();

    Map<String, dynamic> datosPost = {
      "inspeccion": [],
      "detalle": [],
      "ordenes": [],
    };

    if (inspeccionPadre.isNotEmpty) {
      datosPost["inspeccion"] = inspeccionPadre;
      debugPrint("Agregando inspección padre");
    }

    List<String> pathImagenes = [];

    if (trampasDetalle.isNotEmpty) {
      for (var e in trampasDetalle) {
        if (e.foto != null) {
          pathImagenes.add(e.foto!);
          e.foto = await base64Archivo(e.foto);
        }
      }
      datosPost["detalle"] = trampasDetalle;
      debugPrint("Agregando detalle trampa");
    }

    if (ordenLaboratorio.isNotEmpty) {
      datosPost["ordenes"] = ordenLaboratorio;
      debugPrint("Agregando detalle orden laboratorio");
    } else {
      datosPost["ordenes"] = [];
    }

    LoginProvider loginProvider = Get.find<LoginProvider>();

    var token = await loginProvider.obtenerToken();

    try {
      final http.Response res = await httpPostWS(
        endPoint: 'RestWsTrampeoVigilancia/guardarTrampas',
        parametros: jsonEncode(datosPost),
        token: token,
      ).timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        _listaTrampasDetalle = await DBTrampeoVigilancia().getTrampasDetalle();

        var jsonValido = false;
        try {
          json.decode(res.body) as Map<String, dynamic>;
          jsonValido = true;
        } on FormatException catch (e) {
          debugPrint('Error en el formato de respuesta $e');
        }

        if (jsonValido) {
          await DBTrampeoVigilancia().limpiarTrampasPadre();
          await DBTrampeoVigilancia().limpiarTrampas();
          await DBTrampeoVigilancia().limpiarTrampasDetalle();
          await DBTrampeoVigilancia().limpiarOrdenLaboratorio();
          await DBTrampeoVigilancia().limpiarProvinciasSincronizadas();
          eliminarArchivos(pathImagenes);

          for (var e in _listaTrampasDetalle) {
            await DBTrampeoVigilancia()
                .updateTrampaCompletada(2, e.codigoTrampa);
          }

          _icon = _iconoCheck;
          _mensajeValidacion =
              'Se sincronizaron ${trampasDetalle.length} trampas';
          await getCantidadTrampasDetalle();
        } else {
          _icon = _iconoError;
          _mensajeValidacion = 'Ocurrió un error al guardar los registros';
        }
      } else {
        var body = jsonDecode(res.body);
        _icon = _iconoError;
        _mensajeValidacion = body['mensaje'];
      }
    } on TimeoutException catch (e) {
      _icon = _iconoError;
      _mensajeValidacion =
          'El servidor se está tardando en responder, intentalo mas tarde';
      debugPrint(e.toString());
    } on SocketException catch (e) {
      _icon = _iconoError;
      _mensajeValidacion =
          'Error en la Red: Por favor verifica que tengas acceso a internet';
      debugPrint(e.toString());
    } on HttpException catch (e) {
      debugPrint('Error en la petición del servicio web $e');
      _icon = _iconoError;
      _mensajeValidacion = 'Error en la petición del servicio web';
    } on FormatException catch (e) {
      debugPrint('Error en el formato de respuesta $e');
      _icon = _iconoError;
      _mensajeValidacion = 'Error en el formato de respuesta';
    } on Exception catch (e) {
      debugPrint('Error $e');
      _icon = _iconoError;
      _mensajeValidacion = 'Error $e';
    } catch (e) {
      debugPrint('Error $e');
      _icon = _iconoError;
      _mensajeValidacion = 'Error $e';
    }

    _estaValidado = true;
    await getCantidadTrampasUtilizadas();
  }

  limpiarImagen() {
    _image = null;
    // notifyListeners();
  }
}
