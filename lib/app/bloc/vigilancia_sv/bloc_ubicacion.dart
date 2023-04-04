import 'dart:convert';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:agro_servicios/app/bloc/bloc_base.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/respuesta_servicio.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo_singleton.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';
import 'package:agro_servicios/app/data/provider/ws/vigilancia_sv_provider.dart';
import 'package:get/get.dart';

class UbicacionBloc extends BlocBase with ChangeNotifier {
  Geolocator geolocator = Geolocator();
  final VigilanciaModeloSingleton modeloVigilancia =
      VigilanciaModeloSingleton();
  final servicio = VigilanciaSvProvider();

  TextEditingController coordenadaXcontrolador = TextEditingController();
  TextEditingController coordenadaYcontrolador = TextEditingController();
  //TextEditingController coordenadaZcontrolador = TextEditingController();

  List<LocalizacionModelo> listaProvincias = [];
  List<LocalizacionModelo> listaProvinciasDropDown = [
    LocalizacionModelo(idGuia: 0, nombre: '--')
  ];

  List<LocalizacionModelo> listaCantonesUbicacion = [
    LocalizacionModelo(idGuia: 0, nombre: '--')
  ];

  List<LocalizacionModelo> listaParroquiasUbicacion = [
    LocalizacionModelo(idGuia: 0, nombre: '--')
  ];

  late Position localizacionActual;

  int? _provinciaSincronizacion;
  int lenghtProvincias = 0;
  int _idParroquia = 1;

  bool _estaObteniendoProvincia = false;
  bool obteniendoCoordenadas = false;

  String _mensajeSincronizacion = '';
  String _nombreProvinciaSincronizada = '';
  String _mensajeGuardado = '';

  String? _mensajeUbicacionError;
  String? _errorCanton;
  String? _errorParroquia;
  String? _errorNombrePropiedadFinca;
  String? _errorLocalidadOvia;
  String? _errorCordenadaX;
  String? _errorCordenadaY;
  //String _errorCordenadaZ;
  String? _errorNombreDenunciante;
  String? _errorTelefonoDenunciante;
  String? _errorDireccionDenunciante;
  String? _errorCorreoDenunciante;

  bool esDenunciaRadioVacio = false;

  Icon? _icono;

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

  get provinciaSincronizacion => _provinciaSincronizacion;
  get nombreProvinciaSincronizada => _nombreProvinciaSincronizada;
  get estaObteniendoProvincia => _estaObteniendoProvincia;
  get mensajeSincronizacion => _mensajeSincronizacion;
  get mensajeGuardado => _mensajeGuardado;
  get mensajeUbicacionError => _mensajeUbicacionError;
  get icono => _icono;
  get coordenadaX => modeloVigilancia.coordenadaX;
  get coordenadaY => modeloVigilancia.coordenadaY;
  get coordenadaZ => modeloVigilancia.coordenadaZ;
  get denunciaFitosanitaria => modeloVigilancia.denuncia;
  get nombreDenunciante => modeloVigilancia.nombreDenunciante;
  get telefonoDenunciante => modeloVigilancia.telefonoDenunciante;
  get direccionDenunciante => modeloVigilancia.direccionDenunciante;
  get correoDenunciante => modeloVigilancia.correoDenunciante;

  get errorNombrePropiedadFinca => _errorNombrePropiedadFinca;
  get errorCanton => _errorCanton;
  get errorParroquia => _errorParroquia;
  get errorLocalidadovia => _errorLocalidadOvia;
  get errorCordenadaX => _errorCordenadaX;
  get errorCordenadaY => _errorCordenadaY;
  //get errorCordenadaZ => _errorCordenadaZ;
  get errorNombreDenunciante => _errorNombreDenunciante;
  get errorTelefonoDenunciante => _errorTelefonoDenunciante;
  get errorDireccionDenunciante => _errorDireccionDenunciante;
  get errorCorreoDenunciante => _errorCorreoDenunciante;

  set setProvinciaSincronizacion(valor) {
    _provinciaSincronizacion = valor;
  }

  set setObteniendoProvincia(valor) {
    _estaObteniendoProvincia = valor;
  }

  set setGrupoRadio(valor) {
    esDenunciaRadioVacio = false;
    modeloVigilancia.denuncia = valor;
    notifyListeners();
  }

  setCanton(valor) async {
    LocalizacionModelo localizacion =
        await servicio.obtenerLocalizacionDatos(int.parse(valor));
    modeloVigilancia.codigoCanton = localizacion.idGuia.toString();
    modeloVigilancia.nombreCanton = localizacion.nombre;
  }

  setParroquia(valor) async {
    LocalizacionModelo localizacion =
        await servicio.obtenerLocalizacionDatos(valor);
    modeloVigilancia.codigoParroquia = localizacion.idGuia.toString();
    modeloVigilancia.nombreParroquia = localizacion.nombre;
  }

  set setProvincia(String valor) {
    modeloVigilancia.nombrePropietarioFinca = valor;
  }

  set setPropiedadFinca(String valor) {
    modeloVigilancia.nombrePropietarioFinca = valor;
  }

  set setLocalidad(String valor) {
    modeloVigilancia.localidadOvia = valor;
  }

  set setCoordenadaX(String valor) {
    modeloVigilancia.coordenadaX = valor;
  }

  set setCoordenadaY(String valor) {
    modeloVigilancia.coordenadaY = valor;
  }

  set setCoordenadaZ(String valor) {
    modeloVigilancia.coordenadaZ = valor;
  }

  set setDenuncia(String? valor) {
    modeloVigilancia.denuncia = valor;

    if (valor == 'Si') {
      esDenunciaRadioVacio = true;
    } else {
      esDenunciaRadioVacio = false;
      _limpiarValidacionOpcionales();
    }

    notifyListeners();
  }

  set setNombreDenunciante(String valor) {
    modeloVigilancia.nombreDenunciante = valor;
  }

  set setTelefonoDenunciante(String valor) {
    modeloVigilancia.telefonoDenunciante = valor;
  }

  set setDireccionDenunciante(String valor) {
    modeloVigilancia.direccionDenunciante = valor;
  }

  set setCorreoDenunciante(String valor) {
    modeloVigilancia.correoDenunciante = valor;
  }

  getProvinciaUbicacion() async {
    final LocalizacionModelo? res =
        await servicio.obtenerProvinciaSincronizada();
    if (res != null) {
      _nombreProvinciaSincronizada = res.nombre ?? '';
      getCantonesUbicacion(res.idGuia);
      modeloVigilancia.codigoProvincia = res.codigo ?? '';
      modeloVigilancia.nombreProvincia = res.nombre ?? '';
      notifyListeners();
      return res.idGuia;
    } else {
      _nombreProvinciaSincronizada = '';
      listaCantonesUbicacion.clear();
      listaParroquiasUbicacion.clear();
    }

    notifyListeners();
  }

  getCantonesUbicacion(provincia) async {
    final List<LocalizacionModelo> lista =
        await servicio.obtenerCantonesSincronizados(provincia);
    listaCantonesUbicacion = lista;
    listaParroquiasUbicacion.clear();
    listaParroquiasUbicacion.add(LocalizacionModelo(idGuia: 0, nombre: '--'));
    notifyListeners();
  }

  getParroquiasUbicacion(canton) async {
    final List<LocalizacionModelo> lista =
        await servicio.obtenerParroquiasSincronizados(canton);

    listaParroquiasUbicacion = [
      LocalizacionModelo(idGuia: _idParroquia--, nombre: '--')
    ];
    modeloVigilancia.codigoParroquia = null;
    listaParroquiasUbicacion.addAll(lista);
    notifyListeners();
  }

  getProvinciaSincronizacion() async {
    listaProvinciasDropDown.clear();
    listaProvinciasDropDown.add(LocalizacionModelo(idGuia: 0, nombre: '--'));

    listaProvincias.clear();
    listaProvincias = await DBLocalizcion.db.getTodosProvincias(1);
    listaProvincias.insert(0, LocalizacionModelo(idGuia: 0, nombre: '--'));
    listaProvinciasDropDown.addAll(listaProvincias);
    listaProvinciasDropDown = listaProvincias;
    _provinciaSincronizacion = 0;

    lenghtProvincias = listaProvinciasDropDown.length;
    notifyListeners();
  }

  getCatalogoLocalizacion(valor) async {
    LoginProvider loginProvider = Get.find<LoginProvider>();
    final RespuestaServicio res = await servicio.obtenerCatalogoLocalizacion(
        valor, loginProvider.obtenerToken());

    if (res.estado != 'error') {
      try {
        var lista = json.decode(res.respuesta);
        List listaProvincias = lista['cuerpo']['localizacioncatalogo'];
        List listaCantones = listaProvincias[0]['cantonlist'];
        List<LocalizacionCatalogo> listaLocalizacionCantones;

        listaLocalizacionCantones =
            listaCantones.map((e) => LocalizacionCatalogo.fromJson(e)).toList();

        for (var e in listaLocalizacionCantones) {
          await servicio.guardarLocalizacionCatalogo(e);

          List<LocalizacionCatalogo> listaParroquias =
              e.parroquialist!.toList();

          for (var element in listaParroquias) {
            await servicio.guardarLocalizacionCatalogo(element);
          }
        }

        await servicio.eliminarProvinciaSincronizada();
        // await servicio.eliminarMonitoreoVigilancia();
        await servicio.guardarProvinciasinronizada(LocalizacionCatalogo(
          idguia: listaProvincias[0]['idguia'],
          codigo: listaProvincias[0]['codigo'],
          nombre: listaProvincias[0]['nombre'],
          idGuiaPadre: listaProvincias[0]['idguiapadre'],
          categoria: listaProvincias[0]['idguiapadre'],
        ));
        _estaObteniendoProvincia = false;
        _icono = _iconoCheck;
        _mensajeSincronizacion = 'Se sincronizó el catálogo de la provincia';
      } catch (e) {
        _estaObteniendoProvincia = false;
        _icono = _iconoError;
        _mensajeSincronizacion = 'Error al sincronizar datos';
        debugPrint("hubo un error $e");
      }
    } else {
      _estaObteniendoProvincia = false;
      _icono = _iconoError;
      _mensajeSincronizacion = res.mensaje!;
    }

    notifyListeners();
  }

  Future getPosicion() async {
    var permisos = await _checkPermisoLocalizacion();
    _mensajeUbicacionError = '';
    obteniendoCoordenadas = true;

    notifyListeners();
    if (permisos['estadoPermiso']) {
      try {
        localizacionActual = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        double lt = localizacionActual.latitude;
        double lg = localizacionActual.longitude;
        //double z = localizacionActual.altitude;

        modeloVigilancia.coordenadaX = '$lg';
        modeloVigilancia.coordenadaY = '$lt';
        //modeloVigilancia.coordenadaZ = '$z';

        coordenadaXcontrolador.text = '$lg';
        coordenadaYcontrolador.text = '$lt';
        //coordenadaZcontrolador.text = '$z';

        // notifyListeners();
      } catch (e) {
        debugPrint('Error: $e');
        _mensajeUbicacionError =
            'Asegurate de usar el GPS del dispositivo como modo de ubicación o activar la Presición de ubicación de Google';
        // notifyListeners();
      }
    } else {
      _mensajeUbicacionError = permisos['error'];
    }
    obteniendoCoordenadas = false;
    notifyListeners();
  }

  Future<Map> _checkPermisoLocalizacion() async {
    bool estadoPermiso = true;
    LocationPermission permission;
    String error = '';

    var serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      estadoPermiso = false;
      error = 'Asegurate de activar el GPS e intenta nuevamente';
      return {'estadoPermiso': estadoPermiso, 'error': error};
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      estadoPermiso = false;
      error =
          'Los permisos de ubicación fueron denegados permanentemente.  \n\nVe a los ajustes de aplicaciones para otorgar los permisos';
      return {'estadoPermiso': estadoPermiso, 'error': error};
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        estadoPermiso = false;
        error = 'No se otorgaron permisos para acceder a tu ubicación';
        return {'estadoPermiso': estadoPermiso, 'error': error};
      }
    }

    return {'estadoPermiso': estadoPermiso, 'error': error};
  }

  bool validarFormulario() {
    bool esValido = true;

    if (modeloVigilancia.codigoCanton == '' ||
        modeloVigilancia.codigoCanton == null) {
      _errorCanton = 'El campo Cantón es obligatorio';
      esValido = false;
    } else {
      _errorCanton = null;
    }

    if (modeloVigilancia.codigoParroquia == '' ||
        modeloVigilancia.codigoParroquia == null) {
      _errorParroquia = 'El campo Parroquia es obligatorio';
      esValido = false;
    } else {
      _errorParroquia = null;
    }

    if (modeloVigilancia.nombrePropietarioFinca == '' ||
        modeloVigilancia.nombrePropietarioFinca == null) {
      _errorNombrePropiedadFinca =
          'El campo Nombre del propietario / Finca es obligatorio';
      esValido = false;
    } else {
      _errorNombrePropiedadFinca = null;
    }

    if (modeloVigilancia.localidadOvia == '' ||
        modeloVigilancia.localidadOvia == null) {
      _errorLocalidadOvia = 'El campo Localidad o vía es obligatorio';
      esValido = false;
    } else {
      _errorLocalidadOvia = null;
    }

    if (modeloVigilancia.coordenadaX == '' ||
        modeloVigilancia.coordenadaX == null) {
      _errorCordenadaX = 'El campo Coordenada X es obligatorio';
      esValido = false;
    } else {
      _errorCordenadaX = null;
    }

    if (modeloVigilancia.coordenadaY == '' ||
        modeloVigilancia.coordenadaY == null) {
      _errorCordenadaY = 'El campo Coordenada Y es obligatorio';
      esValido = false;
    } else {
      _errorCordenadaY = null;
    }

    /* if (modeloVigilancia.coordenadaZ == '' ||
        modeloVigilancia.coordenadaZ == null) {
      _errorCordenadaZ = 'El campo Coordenada Z es obligatorio';
      _esValido = false;
    } else {
      _errorCordenadaZ = null;
    } */

    if ((modeloVigilancia.nombreDenunciante == '' ||
            modeloVigilancia.nombreDenunciante == null) &&
        modeloVigilancia.denuncia == 'Si') {
      _errorNombreDenunciante =
          'El campo Nombre del denunciante es obligatorio';
      esValido = false;
    } else {
      _errorNombreDenunciante = null;
    }

    if ((modeloVigilancia.telefonoDenunciante == '' ||
            modeloVigilancia.telefonoDenunciante == null) &&
        modeloVigilancia.denuncia == 'Si') {
      _errorTelefonoDenunciante =
          'El campo Teléfono del denunciante es obligatorio';
      esValido = false;
    } else {
      _errorTelefonoDenunciante = null;
    }

    if ((modeloVigilancia.direccionDenunciante == '' ||
            modeloVigilancia.direccionDenunciante == null) &&
        modeloVigilancia.denuncia == 'Si') {
      _errorDireccionDenunciante =
          'El campo Dirección del denunciante es obligatorio';
      esValido = false;
    } else {
      _errorDireccionDenunciante = null;
    }

    if ((modeloVigilancia.telefonoDenunciante == '' ||
            modeloVigilancia.telefonoDenunciante == null) &&
        modeloVigilancia.denuncia == 'Si') {
      _errorTelefonoDenunciante =
          'El campo Teléfono del denunciante es obligatorio';
      esValido = false;
    } else {
      _errorTelefonoDenunciante = null;
    }

    if ((modeloVigilancia.correoDenunciante == '' ||
            modeloVigilancia.correoDenunciante == null) &&
        modeloVigilancia.denuncia == 'Si') {
      _errorCorreoDenunciante = 'El campo Correo electrónico es obligatorio';
      esValido = false;
    } else {
      _errorCorreoDenunciante = null;
    }

    // _guardarformulario();
    notifyListeners();
    return esValido;
  }

  _limpiarValidacionOpcionales() {
    _errorNombreDenunciante = null;
    _errorTelefonoDenunciante = null;
    _errorDireccionDenunciante = null;
    _errorTelefonoDenunciante = null;

    modeloVigilancia.nombreDenunciante = null;
    modeloVigilancia.telefonoDenunciante = null;
    modeloVigilancia.direccionDenunciante = null;
    modeloVigilancia.correoDenunciante = null;

    notifyListeners();
  }

  disposeControladores() {
    coordenadaXcontrolador.dispose();
    coordenadaYcontrolador.dispose();
    //coordenadaZcontrolador.dispose();
  }

  encerarValidaciones() {
    _errorCanton = null;
    _errorParroquia = null;
    _errorNombrePropiedadFinca = null;
    _errorLocalidadOvia = null;
    _errorCordenadaX = null;
    _errorCordenadaY = null;
    //_errorCordenadaZ = null;
    _errorNombreDenunciante = null;
    _errorTelefonoDenunciante = null;
    _errorDireccionDenunciante = null;
    _errorCorreoDenunciante = null;
  }

  void encerarModelo() {
    coordenadaXcontrolador.text = '';
    coordenadaYcontrolador.text = '';
    //coordenadaZcontrolador.text = '';
    modeloVigilancia.encerarModelo();
    _mensajeUbicacionError = '';
  }

  void encerarSincronizacion() {
    lenghtProvincias = 0;
    _mensajeSincronizacion = '';
    _mensajeGuardado = '';
  }

  void encerarMensajeSincronizacion() {
    _mensajeSincronizacion = '';
  }

  void imprimirModelo() {
    modeloVigilancia.imprimirModelo();
  }
}
