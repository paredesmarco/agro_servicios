import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';

class TripsModelo {
  int? id;
  int? idTablet;
  String? numeroReporte = '';
  String? ruc = '';
  String? razonSocial = '';
  String? provincia = '';
  String? canton = '';
  String? parroquia = '';
  String? idSitioProduccion = '';
  String? sitioProduccion = '';
  String? representante = '';
  String? resultado = '';
  String? observaciones = '';
  String? fechaInspeccion = '';
  String? usuarioId = '';
  String? usuario = '';
  String? tabletId = '';
  String? tabletVersionBase = '';
  String? fechaIngresoGuia = '';
  String? estadoF09 = '';
  String? observacionF09 = '';
  String? tipoArea = '';
  int? totalResultado = 0;
  int? totalAreas = 0;
  int? idPonderacion = 0;
  List<RespuestasModelo>? listaRespuestas;
  List<RespuestasAreasModelo>? listaAreas;

  TripsModelo(
      {this.id,
      this.idTablet,
      this.numeroReporte,
      this.ruc,
      this.razonSocial,
      this.provincia,
      this.canton,
      this.parroquia,
      this.idSitioProduccion,
      this.sitioProduccion,
      this.representante,
      this.resultado,
      this.observaciones,
      this.fechaInspeccion,
      this.usuarioId,
      this.usuario,
      this.tabletId,
      this.tabletVersionBase,
      this.fechaIngresoGuia,
      this.estadoF09,
      this.observacionF09,
      this.tipoArea,
      this.totalResultado,
      this.totalAreas,
      this.idPonderacion,
      this.listaRespuestas,
      this.listaAreas});

  factory TripsModelo.fromJson(Map<String, dynamic> json) => TripsModelo(
        id: json["id"],
        idTablet: json["id_tablet"],
        numeroReporte: json["numero_reporte"],
        ruc: json["ruc"],
        razonSocial: json["razon_social"],
        provincia: json["provincia"],
        canton: json["canton"],
        parroquia: json["parroquia"],
        idSitioProduccion: json["id_sitio_produccion"],
        sitioProduccion: json["sitio_produccion"],
        representante: json["representante"],
        resultado: json["resultado"],
        observaciones: json["observaciones"],
        fechaInspeccion: json["fecha_inspeccion"],
        usuarioId: json["usuario_id"],
        usuario: json["usuario"],
        tabletId: json["tablet_id"],
        tabletVersionBase: json["tablet_version_base"],
        fechaIngresoGuia: json["fecha_ingreso_guia"],
        estadoF09: json["estado_f09"],
        observacionF09: json["observacion_f09"],
        tipoArea: json["tipo_area"],
        totalResultado: json["total_resultado"],
        totalAreas: json["total_areas"],
        idPonderacion: json["id_ponderacion"],
        listaRespuestas: json["lista_respuestas"] == null
            ? null
            : List<RespuestasModelo>.from(json["lista_respuestas"]
                .map((x) => RespuestasModelo.fromJson(x))),
        listaAreas: json["lista_areas"] == null
            ? null
            : List<RespuestasAreasModelo>.from(json["lista_areas"]
                .map((x) => RespuestasAreasModelo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tablet": idTablet,
        "numero_reporte": numeroReporte,
        "ruc": ruc,
        "razon_social": razonSocial,
        "provincia": provincia,
        "canton": canton,
        "parroquia": parroquia,
        "id_sitio_produccion": idSitioProduccion,
        "sitio_produccion": sitioProduccion,
        "representante": representante,
        "resultado": resultado,
        "observaciones": observaciones,
        "fecha_inspeccion": fechaInspeccion,
        "usuario_id": usuarioId,
        "usuario": usuario,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase,
        "fecha_ingreso_guia": fechaIngresoGuia,
        "estado_f09": estadoF09,
        "observacion_f09": observacionF09,
        "tipo_area": tipoArea,
        "total_resultado": totalResultado,
        "total_areas": totalAreas,
        "id_ponderacion": idPonderacion,
        "listaRespuestas": listaRespuestas == null
            ? null
            : List<dynamic>.from(listaRespuestas!.map((x) => x.toJson())),
        "listaAreas": listaAreas == null
            ? null
            : List<dynamic>.from(listaAreas!.map((x) => x.toJson()))
      };

  // @override
  // String toString() {
  //   return '''
  //   TripsModelo {
  //   id:$id
  //   idTablet:$idTablet
  //   numeroReporte:$numeroReporte
  //   ruc:$ruc
  //   razonSocial:$razonSocial
  //   provincia:$provincia
  //   canton:$canton
  //   parroquia:$parroquia
  //   idSitioProduccion:$idSitioProduccion
  //   sitioProduccion:$sitioProduccion
  //   representante:$representante
  //   resultado:$resultado
  //   observaciones:$observaciones
  //   fechaInspeccion:$fechaInspeccion
  //   usuarioId:$usuarioId
  //   usuario:$usuario
  //   tabletId:$tabletId
  //   tabletVersionBase:$tabletVersionBase
  //   fechaIngresoGuia:$fechaIngresoGuia
  //   estadoF09:$estadoF09
  //   observacionF09:$observacionF09
  //   tipoArea:$tipoArea
  //   idPonderacion:$idPonderacion
  //   totalResultado:$totalResultado
  //   totalAreas:$totalAreas
  //   listaRespuestas: $listaRespuestas
  //   listaAreas:$listaAreas
  //   }
  //   ''';
  // }
}
