class TransitoIngresoProductoSvModelo {
  TransitoIngresoProductoSvModelo({
    this.id,
    this.partidaArancelaria,
    this.descripcionProducto,
    this.subtipo,
    this.cantidad,
    this.tipoEnvase,
    this.controlF02Id,
    this.idTablet,
  });

  int? id;
  String? partidaArancelaria;
  String? descripcionProducto;
  String? subtipo;
  double? cantidad;
  String? tipoEnvase;
  int? controlF02Id;
  int? idTablet;

  factory TransitoIngresoProductoSvModelo.fromJson(Map<String, dynamic> json) =>
      TransitoIngresoProductoSvModelo(
        id: json["id"],
        partidaArancelaria: json["partida_arancelaria"],
        descripcionProducto: json["descripcion_producto"],
        subtipo: json["subtipo"],
        cantidad: json["cantidad"],
        tipoEnvase: json["tipo_envase"],
        controlF02Id: json["control_f02_id"],
        idTablet: json["id_tablet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "partida_arancelaria": partidaArancelaria,
        "descripcion_producto": descripcionProducto,
        "subtipo": subtipo,
        "cantidad": cantidad,
        "tipo_envase": tipoEnvase,
        "control_f02_id": controlF02Id,
        "id_tablet": idTablet,
      };

  @override
  String toString() {
    return '''
        {
        id: $id,
        partida_arancelaria: $partidaArancelaria,
        descripcion_producto: $descripcionProducto,
        subtipo: $subtipo,
        cantidad: $cantidad,
        tipo_envase: $tipoEnvase,
        control_f02_id: $controlF02Id
        id_tablet: $idTablet,
      }
    ''';
  }
}
