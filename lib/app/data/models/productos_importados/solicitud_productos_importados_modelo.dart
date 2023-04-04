class SolicitudProductosImportadosModelo {
  int? id;
  String? pfi;
  String? estado;
  String? dda;
  String? razonSocial;
  String? paisOrigen;
  String? tipoCertificado;
  List<ProductoImportadoModelo>? productos;

  SolicitudProductosImportadosModelo({
    this.id,
    this.pfi,
    this.estado,
    this.dda,
    this.razonSocial,
    this.paisOrigen,
    this.tipoCertificado,
    this.productos,
  });

  factory SolicitudProductosImportadosModelo.fromJson(
      Map<String, dynamic> json) {
    return SolicitudProductosImportadosModelo(
        id: json['id'],
        pfi: json['pfi'],
        estado: json['estado'],
        dda: json['dda'],
        razonSocial: json['razon_social'],
        paisOrigen: json['pais_origen'],
        tipoCertificado: json['tipo_certificado'],
        productos: json["productos"] != null
            ? List<ProductoImportadoModelo>.from(json["productos"]
                .map((x) => ProductoImportadoModelo.fromJson(x)))
            : []);
  }

  Map<String, dynamic> toJson() {
    return {
      "pfi": pfi,
      "estado": estado,
      "dda": dda,
      "razon_social": razonSocial,
      "pais_origen": paisOrigen,
      "tipo_certificado": tipoCertificado,
    };
  }

  @override
  String toString() {
    return ''' SolicitudProductosImportadosModelo {
      pfi : $pfi
      estado : $estado
      dda : $dda
      razon_social : $razonSocial
      pais_origen : $paisOrigen
      tipo_certificado : $tipoCertificado
      }
    ''';
  }
}

class ProductoImportadoModelo {
  int? id;
  String? nombre;
  String? cantidad;
  String? cantidadIngresada;
  String? unidad;
  String? subtipo;
  int? controlF01Id;
  int? idTablet;

  ProductoImportadoModelo({
    this.id,
    this.nombre,
    this.cantidad,
    this.cantidadIngresada,
    this.unidad,
    this.subtipo,
    this.controlF01Id,
  });

  factory ProductoImportadoModelo.fromJson(Map<String, dynamic> json) =>
      ProductoImportadoModelo(
        nombre: json["nombre"],
        cantidad: json["cantidad_declarada"],
        cantidadIngresada: json["cantidad_ingresada"] ?? '',
        unidad: json["unidad"],
        subtipo: json["subtipo"],
        controlF01Id: json["control_f01_id"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cantidad_declarada": cantidad,
        "cantidad_ingresada": cantidadIngresada,
        "unidad": unidad,
        "subtipo": subtipo,
        "control_f01_id": controlF01Id,
        "id_tablet": idTablet,
      };

  @override
  String toString() {
    return ''' ProductoImportado{
      nombre : $nombre,
      cantidad_declarada : $cantidad,
      cantidad_ingresada : $cantidadIngresada,
      unidad : $unidad,
      subtipo : $subtipo,
      control_f01_id : $controlF01Id,
      id_tablet : $idTablet,
      }
    ''';
  }
}
