import 'package:flutter/foundation.dart';

class VigilanciaModeloSingleton {
  int? id;
  int? idTablet;
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
  String? envioMuestra = 'No';
  String? observaciones;
  String? fechaInspeccion;
  String? usuarioId;
  String? usuario;
  String? tabletId;
  String? tabletBase;
  String? imagen;
  String? longitudImagen;
  String? latitudImagen;
  String? alturaImagen = '0.0';

  static final VigilanciaModeloSingleton vigilancia =
      VigilanciaModeloSingleton._internal();

  VigilanciaModeloSingleton._internal();

  static final _instancia = VigilanciaModeloSingleton._internal();

  factory VigilanciaModeloSingleton() {
    return _instancia;
  }

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
    envioMuestra = "No";
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

  // fromJson(Map<String, dynamic> json) => {
  //       id = json['id'],
  //       idTablet = json['id_tablet'],
  //       codigoProvincia = json['codigo_provincia'],
  //       nombreProvincia = json['nombre_provincia'],
  //       codigoCanton = json['codigo_canton'],
  //       nombreCanton = json['nombre_canton'],
  //       codigoParroquia = json['codigo_parroquia'],
  //       nombreParroquia = json['nombre_parroquia'],
  //       nombrePropietarioFinca = json['nombre_propietario_finca'],
  //       localidadOvia = json['localidad_via'],
  //       coordenadaX = json['coordenada_x'],
  //       coordenadaY = json['coordenada_y'],
  //       coordenadaZ = json['coordenada_z'],
  //       denuncia = json['denuncia_fitosanitaria'],
  //       nombreDenunciante = json['nombre_denunciante'],
  //       telefonoDenunciante = json['telefono_denunciante'],
  //       direccionDenunciante = json['direccion_denunciante'],
  //       correoDenunciante = json['correo_electronico_denunciante'],
  //       especie = json['especie_vegetal'],
  //       cantidadTotal = json['cantidad_total'].toString(),
  //       cantidadVigilancia = json['cantidad_vigilada'].toString(),
  //       unidad = json['unidad'],
  //       sitioOperacion = json['sitio_operacion'],
  //       condicionProduccion = json['condicion_produccion'],
  //       etapaCultivo = json['etapa_cultivo'],
  //       actividad = json['actividad'],
  //       manejoSitioOperacion = json['manejo_sitio_operacion'],
  //       presenciaPlagas = json['ausencia_plaga'],
  //       plagaPrediagnostico = json['plaga_diagnostico_visual_prediagnostico'],
  //       cantidadAfectada = json['cantidad_afectada'].toString(),
  //       incidencia = json['porcentaje_incidencia'].toString(),
  //       severidad = json['porcentaje_severidad'].toString(),
  //       tipoPlaga = json['tipo_plaga'],
  //       fasePlaga = json['fase_desarrollo_plaga'],
  //       organoAfectado = json['organo_afectado'],
  //       distribucionPlaga = json['distribucion_plaga'],
  //       poblacion = json['poblacion'].toString(),
  //       diagnosticoVisual = json['diagnostico_visual'],
  //       descripcionSintoma = json['descripcion_sintomas'],
  //       envioMuestra = json['envio_muestra'],
  //       fechaInspeccion = json['fecha_inspeccion'],
  //       usuarioId = json['usuario_id'],
  //       usuario = json['usuario'],
  //       tabletId = json['tablet_id'],
  //       tabletBase = json['tablet_version_base'],
  //       imagen = json['imagen'],
  //       longitudImagen = json['longitud_imagen'],
  //       latitudImagen = json['latitud_imagen'],
  //       alturaImagen = json['altura_imagen'],
  //     };

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
    debugPrint('id $id');
    debugPrint('idTablet $idTablet');
    debugPrint('codigoProvincia $codigoProvincia');
    debugPrint('nombreProvincia $nombreProvincia');
    debugPrint('codigoCanton $codigoCanton');
    debugPrint('nombreCanton $nombreCanton');
    debugPrint('codigoParroquia $codigoParroquia');
    debugPrint('nombreParroquia $nombreParroquia');
    debugPrint('nombrePropietarioFinca $nombrePropietarioFinca');
    debugPrint('localidadOvia $localidadOvia');
    debugPrint('coordenadaX $coordenadaX');
    debugPrint('coordenadaY $coordenadaY');
    debugPrint('coordenadaZ $coordenadaZ');
    debugPrint('denuncia $denuncia');
    debugPrint('nombreDenunciante $nombreDenunciante');
    debugPrint('telefonoDenunciante $telefonoDenunciante');
    debugPrint('direccionDenunciante $direccionDenunciante');
    debugPrint('correoDenunciante $correoDenunciante');
    debugPrint('especie $especie');
    debugPrint('cantidadTotal $cantidadTotal');
    debugPrint('cantidadVigilancia $cantidadVigilancia');
    debugPrint('unidad $unidad');
    debugPrint('sitioOperacion $sitioOperacion');
    debugPrint('condicionProduccion $condicionProduccion');
    debugPrint('etapaCultivo $etapaCultivo');
    debugPrint('actividad $actividad');
    debugPrint('manejoSitioOperacion $manejoSitioOperacion');
    debugPrint('presenciaPlagas $presenciaPlagas');
    debugPrint('plagaPrediagnostico $plagaPrediagnostico');
    debugPrint('cantidadAfectada $cantidadAfectada');
    debugPrint('incidencia $incidencia');
    debugPrint('severidad $severidad');
    debugPrint('tipoPlaga $tipoPlaga');
    debugPrint('fasePlaga $fasePlaga');
    debugPrint('organoAfectado $organoAfectado');
    debugPrint('distribucionPlaga $distribucionPlaga');
    debugPrint('poblacion $poblacion');
    debugPrint('diagnosticoVisual $diagnosticoVisual');
    debugPrint('descripcionSintoma $descripcionSintoma');
    debugPrint('envioMuestra $envioMuestra');
    debugPrint('fechaInspeccion $fechaInspeccion');
    debugPrint('usuarioId $usuarioId');
    debugPrint('usuario $usuario');
    debugPrint('tabletId $tabletId');
    debugPrint('tabletBase $tabletBase');
    debugPrint('imagen $imagen');
    debugPrint('longitudImagen $longitudImagen');
    debugPrint('latitudImagen $latitudImagen');
    debugPrint('alturaImagen $alturaImagen');
  }
}
