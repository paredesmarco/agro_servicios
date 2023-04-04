import 'dart:io';

import 'package:agro_servicios/app/bloc/bloc_base.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo_singleton.dart';
import 'package:agro_servicios/app/utils/coordenadas.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_sv.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_vigilancia_sv.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';

class CaracteristicasBloc extends BlocBase with ChangeNotifier {
  final VigilanciaModeloSingleton _modeloVigilancia =
      VigilanciaModeloSingleton();

  File? _image;

  String? productoQuimico;
  String? _especie;
  String? medida;
  String? sitiooperacion;

  bool _camposActivos = true;

  static const ruta = "img/previo-carga.png";

  //Estados validación formulario
  String? _errorEspecieVegetal = '';
  String? _errorCantidadTotal = '';
  String? _errorCantidadVigilancia = '';
  String? _errorUnidad = '';
  String? _errorSitioOperacion = '';
  String? _errorCondicionProduccion = '';
  String? _errorEtapaCultivo = '';
  String? _errorActividad = '';
  String? _errorManejoOperacion = '';
  String? _errorPresenciaPlaga = '';
  String? _errorPlagaPredianostico = '';
  String? _errorCantidadAfectada = '';
  String? _errorIncidencia = '';
  String? _errorSeveridad = '';
  String? _errorTipoPlaga = '';
  String? _errorFasePlaga = '';
  String? _errorOrganoAfectado = '';
  String? _errorDistribucionPlaga = '';
  String? _errorPoblacion = '';
  String? _errorDiagnostioVisual = '';
  String? _errorDescripcionSintomas = '';
  String? _errorLongitudImagen = '';
  String? _errorLatitudimagen = '';
  //String _errorAlturaImagen = '';

  int? _numeroFotosTrampa = 0;

  final List<String> _listaPrediagnostico =
      CatalogosVigilanciaSV().getDiagnosticoVisual();

  //Getters
  get rutaFoto => ruta;
  get imagen => _image;
  get especie => _especie;
  get valoresCombos => CatalogosTrampasSv();
  get especies => _modeloVigilancia.especie;
  get cantidad => _modeloVigilancia.cantidadTotal;
  get vigilancia => _modeloVigilancia.cantidadVigilancia;
  get sitioOperacion => _modeloVigilancia.sitioOperacion;
  get numeroFotosTrampa => _numeroFotosTrampa;
  get presenciaPlaga => _modeloVigilancia.presenciaPlagas;
  get cantidadAfectada => _modeloVigilancia.cantidadAfectada;
  get incidencia => _modeloVigilancia.incidencia;
  get severidad => _modeloVigilancia.severidad;
  get poblacion => _modeloVigilancia.poblacion;
  get diagnosticoVisual => _modeloVigilancia.diagnosticoVisual;
  get descripcionSintomas => _modeloVigilancia.descripcionSintoma;
  get longitudImagen => _modeloVigilancia.longitudImagen;
  get latitudImagen => _modeloVigilancia.latitudImagen;
  get alturaImagen => _modeloVigilancia.alturaImagen;
  get camposActivos => _camposActivos;
  get plagaPrediagnostico => _modeloVigilancia.plagaPrediagnostico;
  List<String> get listaPlagaPrediagnostico => _listaPrediagnostico;

  get especieError => _errorEspecieVegetal;
  get errorCantidadTotal => _errorCantidadTotal;
  get errorCantidadVigilancia => _errorCantidadVigilancia;
  get errorUnidad => _errorUnidad;
  get errorSitioOperacion => _errorSitioOperacion;
  get errorCondicionProduccion => _errorCondicionProduccion;
  get errorEtapaCultivo => _errorEtapaCultivo;
  get errorActividad => _errorActividad;
  get errorManejoOperacion => _errorManejoOperacion;
  get errorPresenciaPlaga => _errorPresenciaPlaga;
  get errorPlagaPredianostico => _errorPlagaPredianostico;
  get errorCantidadAfectada => _errorCantidadAfectada;
  get errorIncidencia => _errorIncidencia;
  get errorSeveridad => _errorSeveridad;
  get errorTipoPlaga => _errorTipoPlaga;
  get errorFasePlaga => _errorFasePlaga;
  get errorOrganoAfectado => _errorOrganoAfectado;
  get errorDistribucionPlaga => _errorDistribucionPlaga;
  get errorPoblacion => _errorPoblacion;
  get errorDiagnostioVisual => _errorDiagnostioVisual;
  get errorDescripcionSintomas => _errorDescripcionSintomas;
  get errorLongitudImagen => _errorLongitudImagen;
  get errorLatitudimagen => _errorLatitudimagen;
  //get errorAlturaImagen => _errorAlturaImagen;

  //Setters
  set setEspecie(String valor) => _modeloVigilancia.especie = valor;
  set setCantidadTotal(String valor) => _modeloVigilancia.cantidadTotal = valor;
  set setCantidadVigilancia(String valor) {
    _modeloVigilancia.cantidadVigilancia = valor;
    calcularIncidencia(valor);
  }

  set setUnidad(String valor) => _modeloVigilancia.unidad = valor;
  set setSitioOperacion(String valor) =>
      _modeloVigilancia.sitioOperacion = valor;
  set setCondicionProduccion(String valor) =>
      _modeloVigilancia.condicionProduccion = valor;
  set setEtapaCultivo(String valor) => _modeloVigilancia.etapaCultivo = valor;
  set setActividad(String valor) => _modeloVigilancia.actividad = valor;
  set setManejoSitioOperacion(String valor) =>
      _modeloVigilancia.manejoSitioOperacion = valor;

  set setPlagaDiagnostico(String valor) {
    _modeloVigilancia.plagaPrediagnostico = valor;
    double valorIncidencia = _modeloVigilancia.incidencia != null
        ? double.parse(_modeloVigilancia.incidencia!)
        : 0;
    if (valorIncidencia > 0) {
      _modeloVigilancia.diagnosticoVisual =
          _modeloVigilancia.plagaPrediagnostico;
      notifyListeners();
    }
  }

  set setCantidadAfectada(String valor) {
    _modeloVigilancia.cantidadAfectada = valor;
    calcularIncidencia(valor);
  }

  set setIncidencia(String valor) => _modeloVigilancia.incidencia = valor;
  set setSeveridad(String valor) => _modeloVigilancia.severidad = valor;
  set setTipoPlaga(String valor) => _modeloVigilancia.tipoPlaga = valor;
  set setFasePlaga(String valor) => _modeloVigilancia.fasePlaga = valor;
  set setOrganoAfectado(String valor) =>
      _modeloVigilancia.organoAfectado = valor;
  set setDistribucionPlaga(String valor) =>
      _modeloVigilancia.distribucionPlaga = valor;
  set setPoblacion(String valor) => _modeloVigilancia.poblacion = valor;
  set setDiagnosticoVisual(String valor) =>
      _modeloVigilancia.diagnosticoVisual = valor;
  set setDescripcionSintoma(String valor) =>
      _modeloVigilancia.descripcionSintoma = valor;

  set setImagenFile(String valor) {
    // String base64Image = '';
    _image = File(valor);
    // base64Image = base64Encode(_image!.readAsBytesSync());
    _modeloVigilancia.imagen = valor;
  }

  set setLongitudImagen(String valor) =>
      _modeloVigilancia.longitudImagen = valor;
  set setLatitudImagen(String valor) => _modeloVigilancia.latitudImagen = valor;
  set setAlturaImagen(String valor) => _modeloVigilancia.alturaImagen = valor;

  set setNumeroFotosTrampa(valor) {
    _numeroFotosTrampa = valor;
    notifyListeners();
  }

  set setPresenciaPlaga(valor) {
    _modeloVigilancia.presenciaPlagas = valor;
    notifyListeners();
  }

  set setCamposActivos(valor) {
    _errorPlagaPredianostico = null;
    _errorCantidadAfectada = null;
    _errorIncidencia = null;
    _errorSeveridad = null;
    _errorTipoPlaga = null;
    _errorFasePlaga = null;
    _errorOrganoAfectado = null;
    _errorDistribucionPlaga = null;
    _errorPoblacion = null;
    _errorDiagnostioVisual = null;
    _errorDescripcionSintomas = null;

    _modeloVigilancia.plagaPrediagnostico = null;
    _modeloVigilancia.tipoPlaga = null;
    _modeloVigilancia.fasePlaga = null;
    _modeloVigilancia.organoAfectado = null;
    _modeloVigilancia.distribucionPlaga = null;

    _camposActivos = valor;
    limpiarCamposOpcionales();
    notifyListeners();
  }

  limpiarCamposOpcionales() {
    _modeloVigilancia.cantidadAfectada = null;
    _modeloVigilancia.incidencia = null;
    _modeloVigilancia.severidad = null;
    _modeloVigilancia.poblacion = null;
    _modeloVigilancia.diagnosticoVisual = null;
    _modeloVigilancia.descripcionSintoma = null;
    // _modeloVigilancia.longitudImagen = null;
    // _modeloVigilancia.latitudImagen = null;
    // _modeloVigilancia.alturaImagen = null;
    eliminarImagen();
    notifyListeners();
  }

  encerarValidaciones() {
    _errorEspecieVegetal = null;
    _errorCantidadTotal = null;
    _errorCantidadVigilancia = null;
    _errorUnidad = null;
    _errorSitioOperacion = null;
    _errorCondicionProduccion = null;
    _errorEtapaCultivo = null;
    _errorActividad = null;
    _errorManejoOperacion = null;
    _errorPresenciaPlaga = null;
    _errorPlagaPredianostico = null;
    _errorCantidadAfectada = null;
    _errorIncidencia = null;
    _errorSeveridad = null;
    _errorTipoPlaga = null;
    _errorFasePlaga = null;
    _errorOrganoAfectado = null;
    _errorDistribucionPlaga = null;
    _errorPoblacion = null;
    _errorDiagnostioVisual = null;
    _errorDescripcionSintomas = null;
    _errorLongitudImagen = null;
    _errorLatitudimagen = null;
    //_errorAlturaImagen = null;
  }

  calcularIncidencia(valor) {
    double inciencia;
    try {
      double? vigilancia =
          double.parse(_modeloVigilancia.cantidadVigilancia ?? '');
      double? cantidadAfectada =
          double.parse(_modeloVigilancia.cantidadAfectada ?? '');
      if (cantidadAfectada != 0) {
        inciencia = (cantidadAfectada / vigilancia) * 100;
      } else {
        inciencia = 0;
      }
    } catch (e) {
      inciencia = 0;
    }
    if (inciencia > 0) {
      _modeloVigilancia.diagnosticoVisual =
          _modeloVigilancia.plagaPrediagnostico;
    } else {
      _modeloVigilancia.diagnosticoVisual = '';
    }
    _modeloVigilancia.incidencia = inciencia.toStringAsFixed(2);
    notifyListeners();
  }

  obtenerCoordenadas() async {
    Coordenadas coordenadas = Coordenadas();
    await coordenadas.getLocalizacion();

    if (coordenadas.error == null) {
      _modeloVigilancia.latitudImagen = coordenadas.latitud.toString();
      _modeloVigilancia.longitudImagen = coordenadas.longitud.toString();
      //_modeloVigilancia.alturaImagen = coordenadas.altura.toString();
      notifyListeners();
    }
  }

  validarFormulario() async {
    bool esValido = true;

    if (_modeloVigilancia.especie == '' || _modeloVigilancia.especie == null) {
      _errorEspecieVegetal = 'El campo Especie vegetal es obligatorio';
      esValido = false;
    } else {
      _errorEspecieVegetal = null;
    }

    if (!validarDouble(_modeloVigilancia.cantidadTotal)) {
      _errorCantidadTotal = CAMPO_NUMERICO_VALIDO;
      esValido = false;
    } else {
      _errorCantidadTotal = null;
    }

    if (!validarDouble(_modeloVigilancia.cantidadVigilancia)) {
      _errorCantidadVigilancia = CAMPO_NUMERICO_VALIDO;
      esValido = false;
    } else {
      _errorCantidadVigilancia = null;
    }

    if (_modeloVigilancia.unidad == '--' || _modeloVigilancia.unidad == null) {
      _errorUnidad = 'El campo Unidad es obligatorio';
      esValido = false;
    } else {
      _errorUnidad = null;
    }

    if (_modeloVigilancia.sitioOperacion == '--' ||
        _modeloVigilancia.sitioOperacion == null) {
      _errorSitioOperacion = 'El campo Sitio de operación es obligatorio';
      esValido = false;
    } else {
      _errorSitioOperacion = null;
    }

    if (_modeloVigilancia.condicionProduccion == '--' ||
        _modeloVigilancia.condicionProduccion == null) {
      _errorCondicionProduccion =
          'El campo Condición de la producción es obligatorio';
      esValido = false;
    } else {
      _errorCondicionProduccion = null;
    }

    if (_modeloVigilancia.etapaCultivo == '--' ||
        _modeloVigilancia.etapaCultivo == null) {
      _errorEtapaCultivo = 'El campo Etapa del cultivo es obligatorio';
      esValido = false;
    } else {
      _errorEtapaCultivo = null;
    }

    if (_modeloVigilancia.actividad == '--' ||
        _modeloVigilancia.actividad == null) {
      _errorActividad = 'El campo Actividad es obligatorio';
      esValido = false;
    } else {
      _errorActividad = null;
    }

    if (_modeloVigilancia.manejoSitioOperacion == '--' ||
        _modeloVigilancia.manejoSitioOperacion == null) {
      _errorManejoOperacion =
          'El campo Manejo del sitio de operación es obligatorio';
      esValido = false;
    } else {
      _errorManejoOperacion = null;
    }

    if ((_modeloVigilancia.cantidadAfectada?.trim() != '' &&
            _modeloVigilancia.cantidadAfectada != null) &&
        !validarDouble(_modeloVigilancia.cantidadAfectada)) {
      _errorCantidadAfectada = CAMPO_NUMERICO_VALIDO;
      esValido = false;
    } else {
      _errorCantidadAfectada = null;
    }

    if ((_modeloVigilancia.severidad?.trim() != '' &&
            _modeloVigilancia.severidad != null) &&
        !validarDouble(_modeloVigilancia.severidad)) {
      _errorSeveridad = CAMPO_NUMERICO_VALIDO;
      esValido = false;
    } else {
      _errorSeveridad = null;
    }

    /* 
    
    if ((_modeloVigilancia.plagaPrediagnostico == '--' ||
            _modeloVigilancia.plagaPrediagnostico == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorPlagaPredianostico =
          'El campo Plaga/Diagnóstico visual es obligatorio';
      esValido = false;
    } else {
      _errorPlagaPredianostico = null;
    }
    
    if ((_modeloVigilancia.incidencia == '' ||
            _modeloVigilancia.incidencia == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorIncidencia = 'El campo Incidencia es obligatorio';
      _esValido = false;
    } else {
      _errorIncidencia = null;
    }

    if ((!validarDouble(_modeloVigilancia.severidad)) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorSeveridad = CAMPO_NUMERICO_VALIDO;
      _esValido = false;
    } else {
      _errorSeveridad = null;
    }

    if ((_modeloVigilancia.tipoPlaga == '--' ||
            _modeloVigilancia.tipoPlaga == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorTipoPlaga = 'El campo Tipo de plaga es obligatorio';
      _esValido = false;
    } else {
      _errorTipoPlaga = null;
    }

    if ((_modeloVigilancia.fasePlaga == '--' ||
            _modeloVigilancia.fasePlaga == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorFasePlaga =
          'El campo Fase de desarrollo de la plaga es obligatorio';
      _esValido = false;
    } else {
      _errorFasePlaga = null;
    }

    if ((_modeloVigilancia.organoAfectado == '--' ||
            _modeloVigilancia.organoAfectado == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorOrganoAfectado = 'El campo Órgano afectado es obligatorio';
      _esValido = false;
    } else {
      _errorOrganoAfectado = null;
    }

    if ((_modeloVigilancia.distribucionPlaga == '--' ||
            _modeloVigilancia.distribucionPlaga == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorDistribucionPlaga =
          'El campo Distribución de la plaga es obligatorio';
      _esValido = false;
    } else {
      _errorDistribucionPlaga = null;
    }

    if ((_modeloVigilancia.poblacion == '' ||
            _modeloVigilancia.poblacion == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorPoblacion = 'El campo Población es obligatorio';
      _esValido = false;
    } else {
      _errorPoblacion = null;
    }

    if ((_modeloVigilancia.descripcionSintoma == '' ||
            _modeloVigilancia.descripcionSintoma == null) &&
        _modeloVigilancia.presenciaPlagas == 'Si') {
      _errorDescripcionSintomas =
          'El campo Descripción de síntomas es obligatorio';
      _esValido = false;
    } else {
      _errorDescripcionSintomas = null;
    } */

    notifyListeners();
    return esValido;
  }

  eliminarImagen() async {
    await _image?.delete();
    _image = null;
    _modeloVigilancia.imagen = null;
    _modeloVigilancia.longitudImagen = null;
    _modeloVigilancia.latitudImagen = null;
    _modeloVigilancia.alturaImagen = null;
    notifyListeners();
  }

  eliminarImagenSinNotifier() {
    _image = null;
  }
}
