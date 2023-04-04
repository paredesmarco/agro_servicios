import 'package:flutter/foundation.dart';

class VigilanciaModelo {
  int? id;
  String? idTablet;
  String? codigoProvincia;
  String? nombreProvincia;
  String? codigoCanton;
  String? nombreCanton;
  String? codigoParroquia;
  String? nombreParroquia;
  String? nombrePropietarioFinca;
  String? localidadOvia;
  String? coordenadaX;
  String? coordenadaY;
  String? coordenadaZ;
  String? denuncia = 'No';
  String? nombreDenunciante;
  String? telefonoDenunciante;
  String? direccionDenunciante;
  String? correoDenunciante;
  String? especie;
  String? cantidadTotal;
  String? cantidadVigilancia;
  String? unidad;
  String? sitioOperacion;
  String? condicionProduccion;
  String? etapaCultivo;
  String? actividad;
  String? manejoSitioOperacion;
  String? presenciaPlagas = 'No';
  String? plagaPrediagnostico;
  String? cantidadAfectada;
  String? incidencia;
  String? severidad;
  String? tipoPlaga;
  String? fasePlaga;
  String? organoAfectado;
  String? distribucionPlaga;
  String? poblacion;
  String? diagnosticoVisual;
  String? descripcionSintoma;
  String? envioMuestra;
  String? observaciones;
  String? fechaInspeccion;
  String? usuarioId;
  String? usuario;
  String? tabletId;
  String? tabletBase;
  String? imagen;
  String? longitudImagen;
  String? latitudImagen;
  String? alturaImagen;

  VigilanciaModelo({
    this.id,
    this.idTablet,
    this.codigoProvincia,
    this.nombreProvincia,
    this.codigoCanton,
    this.nombreCanton,
    this.codigoParroquia,
    this.nombreParroquia,
    this.nombrePropietarioFinca,
    this.localidadOvia,
    this.coordenadaX,
    this.coordenadaY,
    this.coordenadaZ,
    this.denuncia = 'No',
    this.nombreDenunciante,
    this.telefonoDenunciante,
    this.direccionDenunciante,
    this.correoDenunciante,
    this.especie,
    this.cantidadTotal,
    this.cantidadVigilancia,
    this.unidad,
    this.sitioOperacion,
    this.condicionProduccion,
    this.etapaCultivo,
    this.actividad,
    this.manejoSitioOperacion,
    this.presenciaPlagas = 'No',
    this.plagaPrediagnostico,
    this.cantidadAfectada,
    this.incidencia,
    this.severidad,
    this.tipoPlaga,
    this.fasePlaga,
    this.organoAfectado,
    this.distribucionPlaga,
    this.poblacion,
    this.diagnosticoVisual,
    this.descripcionSintoma,
    this.envioMuestra,
    this.observaciones,
    this.fechaInspeccion,
    this.usuarioId,
    this.usuario,
    this.tabletId,
    this.tabletBase,
    this.imagen,
    this.longitudImagen,
    this.latitudImagen,
    this.alturaImagen,
  });

  encerarModelo() {
    id = null;
    idTablet = null;
    codigoProvincia = null;
    nombreProvincia = null;
    codigoCanton = null;
    nombreCanton = null;
    codigoParroquia = null;
    nombreParroquia = null;
    nombrePropietarioFinca = null;
    localidadOvia = null;
    coordenadaX = null;
    coordenadaY = null;
    coordenadaZ = null;
    denuncia = 'No';
    nombreDenunciante = null;
    telefonoDenunciante = null;
    direccionDenunciante = null;
    correoDenunciante = null;
    especie = null;
    cantidadTotal = null;
    cantidadVigilancia = null;
    unidad = null;
    sitioOperacion = null;
    condicionProduccion = null;
    etapaCultivo = null;
    actividad = null;
    manejoSitioOperacion = null;
    presenciaPlagas = 'No';
    plagaPrediagnostico = null;
    cantidadAfectada = null;
    incidencia = null;
    severidad = null;
    tipoPlaga = null;
    fasePlaga = null;
    organoAfectado = null;
    distribucionPlaga = null;
    poblacion = null;
    diagnosticoVisual = null;
    descripcionSintoma = null;
    envioMuestra = null;
    observaciones = null;
    fechaInspeccion = null;
    usuarioId = null;
    usuario = null;
    tabletId = null;
    tabletBase = null;
    imagen = null;
    longitudImagen = null;
    latitudImagen = null;
    alturaImagen = null;
  }

  factory VigilanciaModelo.fromJson(Map<String, dynamic> json) =>
      VigilanciaModelo(
          id: json['id'],
          idTablet: json['idTablet'],
          codigoProvincia: json['codigoProvincia'],
          nombreProvincia: json['nombreProvincia'],
          codigoCanton: json['codigoCanton'],
          nombreCanton: json['nombreCanton'],
          codigoParroquia: json['codigoParroquia'],
          nombreParroquia: json['nombreParroquia'],
          nombrePropietarioFinca: json['nombrePropietarioFinca'],
          localidadOvia: json['localidadOvia'],
          coordenadaX: json['coordenadaX'],
          coordenadaY: json['coordenadaY'],
          coordenadaZ: json['coordenadaZ'],
          denuncia: json['denuncia'],
          nombreDenunciante: json['nombreDenunciante'],
          telefonoDenunciante: json['telefonoDenunciante'],
          direccionDenunciante: json['direccionDenunciante'],
          correoDenunciante: json['correoDenunciante'],
          especie: json['especie'],
          cantidadTotal: json['cantidadTotal'].toString(),
          cantidadVigilancia: json['cantidadVigilancia'].toString(),
          unidad: json['unidad'],
          sitioOperacion: json['sitioOperacion'],
          condicionProduccion: json['condicionProduccion'],
          etapaCultivo: json['etapaCultivo'],
          actividad: json['actividad'],
          manejoSitioOperacion: json['manejoSitioOperacion'],
          presenciaPlagas: json['presenciaPlagas'],
          plagaPrediagnostico: json['plagaPrediagnostico'],
          cantidadAfectada: json['cantidadAfectada']?.toString(),
          incidencia: json['incidencia'].toString(),
          severidad: json['severidad']?.toString(),
          tipoPlaga: json['tipoPlaga'],
          fasePlaga: json['fasePlaga'],
          organoAfectado: json['organoAfectado'],
          distribucionPlaga: json['distribucionPlaga'],
          poblacion: json['poblacion']?.toString(),
          diagnosticoVisual: json['diagnosticoVisual'],
          descripcionSintoma: json['descripcionSintoma'],
          envioMuestra: json['envioMuestra'],
          observaciones: json['observaciones'],
          fechaInspeccion: json['fechaInspeccion'],
          usuarioId: json['usuarioId'],
          usuario: json['usuario'],
          tabletId: json['tabletId'],
          tabletBase: json['tabletBase'],
          imagen: json['imagen'],
          longitudImagen: json['longitudImagen'],
          latitudImagen: json['latitudImagen'],
          alturaImagen: json['alturaImagen']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "idTablet": idTablet,
        "codigoProvincia": codigoProvincia,
        "nombreProvincia": nombreProvincia,
        "codigoCanton": codigoCanton,
        "nombreCanton": nombreCanton,
        "codigoParroquia": codigoParroquia,
        "nombreParroquia": nombreParroquia,
        "nombrePropietarioFinca": nombrePropietarioFinca,
        "localidadOvia": localidadOvia,
        "coordenadaX": coordenadaX,
        "coordenadaY": coordenadaY,
        "coordenadaZ": coordenadaZ,
        "denuncia": denuncia,
        "nombreDenunciante": nombreDenunciante,
        "telefonoDenunciante": telefonoDenunciante,
        "direccionDenunciante": direccionDenunciante,
        "correoDenunciante": correoDenunciante,
        "especie": especie,
        "cantidadTotal": cantidadTotal,
        "cantidadVigilancia": cantidadVigilancia,
        "unidad": unidad,
        "sitioOperacion": sitioOperacion,
        "condicionProduccion": condicionProduccion,
        "etapaCultivo": etapaCultivo,
        "actividad": actividad,
        "manejoSitioOperacion": manejoSitioOperacion,
        "presenciaPlagas": presenciaPlagas,
        "plagaPrediagnostico": plagaPrediagnostico,
        "cantidadAfectada": cantidadAfectada,
        "incidencia": incidencia,
        "severidad": severidad,
        "tipoPlaga": tipoPlaga,
        "fasePlaga": fasePlaga,
        "organoAfectado": organoAfectado,
        "distribucionPlaga": distribucionPlaga,
        "poblacion": poblacion,
        "diagnosticoVisual": diagnosticoVisual,
        "descripcionSintoma": descripcionSintoma,
        "envioMuestra": envioMuestra,
        "observaciones": observaciones,
        "fechaInspeccion": fechaInspeccion,
        "usuarioId": usuarioId,
        "usuario": usuario,
        "tabletId": tabletId,
        "tabletBase": tabletBase,
        "imagen": imagen,
        "longitudImagen": longitudImagen,
        "latitudImagen": latitudImagen,
        "alturaImagen": alturaImagen,
      };

  imprimirModelo() {
    debugPrint('''
    id: $id
    idTablet: $idTablet
    codigoProvincia: $codigoProvincia
    nombreProvincia: $nombreProvincia
    codigoCanton: $codigoCanton
    nombreCanton: $nombreCanton
    codigoParroquia: $codigoParroquia
    nombreParroquia: $nombreParroquia
    nombrePropietarioFinca: $nombrePropietarioFinca
    localidadOvia: $localidadOvia
    coordenadaX: $coordenadaX
    coordenadaY: $coordenadaY
    coordenadaZ: $coordenadaZ
    denuncia: $denuncia
    nombreDenunciante: $nombreDenunciante
    telefonoDenunciante: $telefonoDenunciante
    direccionDenunciante: $direccionDenunciante
    correoDenunciante: $correoDenunciante
    especie: $especie
    cantidadTotal: $cantidadTotal
    cantidadVigilancia: $cantidadVigilancia
    unidad: $unidad
    sitioOperacion: $sitioOperacion
    condicionProduccion: $condicionProduccion
    etapaCultivo: $etapaCultivo
    actividad: $actividad
    manejoSitioOperacion: $manejoSitioOperacion
    presenciaPlagas: $presenciaPlagas
    plagaPrediagnostico: $plagaPrediagnostico
    cantidadAfectada: $cantidadAfectada
    incidencia: $incidencia
    severidad: $severidad
    tipoPlaga: $tipoPlaga
    fasePlaga: $fasePlaga
    organoAfectado: $organoAfectado
    distribucionPlaga: $distribucionPlaga
    poblacion: $poblacion
    diagnosticoVisual: $diagnosticoVisual
    descripcionSintoma: $descripcionSintoma
    envioMuestra: $envioMuestra
    observaciones: $observaciones
    fechaInspeccion: $fechaInspeccion
    usuarioId: $usuarioId
    usuario: $usuario
    tabletId: $tabletId
    tabletBase: $tabletBase
    imagen: $imagen
    longitudImagen: $longitudImagen
    latitudImagen: $latitudImagen
    alturaImagen: $alturaImagen
    ''');
  }

  @override
  String toString() {
    return '{id : $id, '
        'idTablet : $idTablet, '
        'codigoProvincia : $codigoProvincia, '
        'nombreProvincia : $nombreProvincia, '
        'codigoCanton : $codigoCanton, '
        'nombreCanton : $nombreCanton, '
        'codigoParroquia : $codigoParroquia, '
        'nombreParroquia : $nombreParroquia, '
        'nombrePropietarioFinca : $nombrePropietarioFinca, '
        'localidadOvia : $localidadOvia, '
        'coordenadaX : $coordenadaX, '
        'coordenadaY : $coordenadaY, '
        'coordenadaZ : $coordenadaZ, '
        'denuncia : $denuncia, '
        'nombreDenunciante : $nombreDenunciante, '
        'telefonoDenunciante : $telefonoDenunciante, '
        'direccionDenunciante : $direccionDenunciante, '
        'correoDenunciante : $correoDenunciante, '
        'especie : $especie, '
        'cantidadTotal : $cantidadTotal, '
        'cantidadVigilancia : $cantidadVigilancia, '
        'unidad : $unidad, '
        'sitioOperacion : $sitioOperacion, '
        'condicionProduccion : $condicionProduccion, '
        'etapaCultivo : $etapaCultivo, '
        'actividad : $actividad, '
        'manejoSitioOperacion : $manejoSitioOperacion, '
        'presenciaPlagas : $presenciaPlagas, '
        'plagaPrediagnostico : $plagaPrediagnostico, '
        'cantidadAfectada : $cantidadAfectada, '
        'incidencia : $incidencia, '
        'severidad : $severidad, '
        'tipoPlaga : $tipoPlaga, '
        'fasePlaga : $fasePlaga, '
        'organoAfectado : $organoAfectado, '
        'distribucionPlaga : distribucionPlaga, '
        'poblacion : $poblacion, '
        'diagnosticoVisual : $diagnosticoVisual, '
        'descripcionSintoma : $descripcionSintoma, '
        'envioMuestra : $envioMuestra, '
        'observaciones : $observaciones, '
        'fechaInspeccion : $fechaInspeccion, '
        'usuarioId : $usuarioId, '
        'usuario : $usuario, '
        'tabletId : $tabletId, '
        'tabletBase : $tabletBase, '
        'imagen : $imagen, '
        'longitudImagen : $longitudImagen, '
        'latitudImagen : $latitudImagen, '
        'alturaImagen : $alturaImagen}';
  }
}
