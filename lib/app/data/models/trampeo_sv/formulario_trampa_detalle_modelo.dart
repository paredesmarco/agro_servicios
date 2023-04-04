// To parse this JSON data, do
//
//     final trampaDetallemodelo = trampaDetallemodeloFromJson(jsonString);

import 'dart:convert';

List<TrampaDetallemodelo> trampaDetalleModeloFromJson(String str) =>
    List<TrampaDetallemodelo>.from(
        json.decode(str).map((x) => TrampaDetallemodelo.fromJson(x)));

String trampaDetallemodeloToJson(List<TrampaDetallemodelo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrampaDetallemodelo {
  TrampaDetallemodelo(
      {this.id,
      this.idTablet,
      this.fechaInstalacion,
      this.codigoTrampa,
      this.tipoTrampa,
      this.idProvincia,
      this.nombreProvincia,
      this.idCanton,
      this.nombreCanton,
      this.idParroquia,
      this.nombreParroquia,
      this.estadoTrampa,
      this.coordenadaX,
      this.coordenadaY,
      this.coordenadaZ,
      this.idLugarInstalacion,
      this.nombreLugarInstalacion,
      this.numeroLugarInstalacion,
      this.fechaInspeccion,
      this.semana,
      this.usuarioId,
      this.usuario,
      this.propiedadFinca,
      this.condicionTrampa,
      this.especie,
      this.procedencia,
      this.condicionCultivo,
      this.etapaCultivo,
      this.exposicion,
      this.cambioFeromona,
      this.cambioPapel,
      this.cambioAceite,
      this.cambioTrampa,
      this.numeroEspecimenes,
      this.diagnosticoVisual,
      this.fasePlaga,
      this.observaciones,
      this.envioMuestra,
      this.tabletId,
      this.tabletVersionBase,
      this.foto,
      this.idPadre});

  int? id;
  int? idTablet;
  DateTime? fechaInstalacion;
  String? codigoTrampa;
  String? tipoTrampa;
  String? idProvincia;
  String? nombreProvincia;
  String? idCanton;
  String? nombreCanton;
  String? idParroquia;
  String? nombreParroquia;
  String? estadoTrampa;
  String? coordenadaX;
  String? coordenadaY;
  String? coordenadaZ;
  String? idLugarInstalacion;
  String? nombreLugarInstalacion;
  int? numeroLugarInstalacion;
  DateTime? fechaInspeccion;
  String? semana;
  String? usuarioId;
  String? usuario;
  String? propiedadFinca;
  String? condicionTrampa;
  String? especie;
  String? procedencia;
  String? condicionCultivo;
  String? etapaCultivo;
  String? exposicion;
  String? cambioFeromona;
  String? cambioPapel;
  String? cambioAceite;
  String? cambioTrampa;
  int? numeroEspecimenes;
  String? diagnosticoVisual;
  String? fasePlaga;
  String? observaciones;
  String? envioMuestra;
  String? tabletId;
  String? tabletVersionBase;
  String? foto;
  int? idPadre;
  bool? llenado;

  factory TrampaDetallemodelo.fromJson(Map<String, dynamic> json) =>
      TrampaDetallemodelo(
        id: json["id"],
        idTablet: json["id_tablet"],
        fechaInstalacion: DateTime.parse(json["fecha_instalacion"]),
        codigoTrampa: json["codigo_trampa"],
        tipoTrampa: json["tipo_trampa"],
        idProvincia: json["id_provincia"].toString(),
        nombreProvincia: json["nombre_provincia"],
        idCanton: json["id_canton"].toString(),
        nombreCanton: json["nombre_canton"],
        idParroquia: json["id_parroquia"].toString(),
        nombreParroquia: json["nombre_parroquia"],
        estadoTrampa: json["estado_trampa"],
        coordenadaX: json["coordenada_x"],
        coordenadaY: json["coordenada_y"],
        coordenadaZ: json["coordenada_z"],
        idLugarInstalacion: json["id_lugar_instalacion"],
        nombreLugarInstalacion: json["nombre_lugar_instalacion"],
        numeroLugarInstalacion: json["numero_lugar_instalacion"],
        fechaInspeccion: DateTime.parse(json["fecha_inspeccion"]),
        semana: json["semana"],
        usuarioId: json["usuario_id"],
        usuario: json["usuario"],
        propiedadFinca: json["propiedad_finca"],
        condicionTrampa: json["condicion_trampa"],
        especie: json["especie"],
        procedencia: json["procedencia"],
        condicionCultivo: json["condicion_cultivo"],
        etapaCultivo: json["etapa_cultivo"],
        exposicion: json["exposicion"],
        cambioFeromona: json["cambio_feromona"],
        cambioPapel: json["cambio_papel"],
        cambioAceite: json["cambio_aceite"],
        cambioTrampa: json["cambio_trampa"],
        numeroEspecimenes: json["numero_especimenes"],
        diagnosticoVisual: json["diagnostico_visual"],
        fasePlaga: json["fase_plaga"],
        observaciones: json["observaciones"],
        envioMuestra: json["envio_muestra"],
        tabletId: json["tablet_id"],
        tabletVersionBase: json["tablet_version_base"],
        foto: json["foto"],
        idPadre: json["id_padre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tablet": idTablet,
        "fecha_instalacion": fechaInstalacion!.toIso8601String(),
        "codigo_trampa": codigoTrampa,
        "tipo_trampa": tipoTrampa,
        "id_provincia": idProvincia,
        "nombre_provincia": nombreProvincia,
        "id_canton": idCanton,
        "nombre_canton": nombreCanton,
        "id_parroquia": idParroquia,
        "nombre_parroquia": nombreParroquia,
        "estado_trampa": estadoTrampa,
        "coordenada_x": coordenadaX,
        "coordenada_y": coordenadaY,
        "coordenada_z": coordenadaZ,
        "id_lugar_instalacion": idLugarInstalacion,
        "nombre_lugar_instalacion": nombreLugarInstalacion,
        "numero_lugar_instalacion": numeroLugarInstalacion,
        "fecha_inspeccion": fechaInspeccion!.toIso8601String(),
        "semana": semana,
        "usuario_id": usuarioId,
        "usuario": usuario,
        "propiedad_finca": propiedadFinca,
        "condicion_trampa": condicionTrampa,
        "especie": especie,
        "procedencia": procedencia,
        "condicion_cultivo": condicionCultivo,
        "etapa_cultivo": etapaCultivo,
        "exposicion": exposicion,
        "cambio_feromona": cambioFeromona,
        "cambio_papel": cambioPapel,
        "cambio_aceite": cambioAceite,
        "cambio_trampa": cambioTrampa,
        "numero_especimenes": numeroEspecimenes,
        "diagnostico_visual": diagnosticoVisual,
        "fase_plaga": fasePlaga,
        "observaciones": observaciones,
        "envio_muestra": envioMuestra,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase,
        "foto": foto,
        "id_padre": idPadre,
      };

  // @override
  // String toString() {
  //   return '''{
  //     'id' : $id,
  //     'id_tablet' : $idTablet,
  //     'fecha_instalacion' : $fechaInstalacion,
  //     'codigo_trampa' : $codigoTrampa,
  //     'tipo_trampa' : $tipoTrampa,
  //     'id_provincia' : $idProvincia,
  //     'nombre_provincia' : $nombreProvincia,
  //     'id_canton' : $idCanton,
  //     'nombre_canton' : $nombreCanton,
  //     'id_parroquia' : $idParroquia,
  //     'nombre_parroquia' : $nombreParroquia,
  //     'estado_trampa' : $estadoTrampa,
  //     'coordenada_x' : $coordenadaX,
  //     'coordenada_y' : $coordenadaY,
  //     'coordenada_z' : $coordenadaZ,
  //     'id_lugar_instalacion' : $idLugarInstalacion,
  //     'nombre_lugar_instalacion' : $nombreLugarInstalacion,
  //     'numero_lugar_instalacion' : $numeroLugarInstalacion,
  //     'fecha_inspeccion' : $fechaInspeccion,
  //     'semana' : $semana,
  //     'usuario_id' : $usuarioId,
  //     'usuario' : $usuario,
  //     'propiedad_finca' : $propiedadFinca,
  //     'condicion_trampa' : $condicionTrampa,
  //     'especie' : $especie,
  //     'procedencia' : $procedencia,
  //     'condicion_cultivo' : $condicionCultivo,
  //     'etapa_cultivo' : $etapaCultivo,
  //     'exposicion' : $exposicion,
  //     'cambio_feromona' : $cambioFeromona,
  //     'cambio_papel' : $cambioPapel,
  //     'cambio_aceite' : $cambioAceite,
  //     'cambio_trampa' : $cambioTrampa,
  //     'numero_especimenes' : $numeroEspecimenes,
  //     'diagnostico_visual' : $diagnosticoVisual,
  //     'fase_plaga' : $fasePlaga,
  //     'observaciones' : $observaciones,
  //     'envio_muestra' : $envioMuestra,
  //     'tablet_id' : $tabletId,
  //     'tablet_version_base' : $tabletVersionBase,
  //     'foto' : $foto,
  //     'id_padre' : $idPadre,
  //    }''';
  // }
}
