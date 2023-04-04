class SeguimientoCuarentenarioSvModelo {
  SeguimientoCuarentenarioSvModelo(
      {this.id,
      this.idSeguimientoCuarentenario,
      this.rucOperador,
      this.razonSocial,
      this.codigoPaisOrigen,
      this.paisOrigen,
      this.producto,
      this.subtipo,
      this.peso,
      this.numeroPlantasIngreso,
      this.codigoProvincia,
      this.provincia,
      this.codigoCanton,
      this.canton,
      this.codigoParroquia,
      this.parroquia,
      this.nombreScpe,
      this.tipoOperacion,
      this.tipoCuarentenaCondicionProduccion,
      this.faseSeguimiento,
      this.codigoLote,
      this.numeroSeguimientosPlanificados,
      this.cantidadTotal,
      this.cantidadVigilada,
      this.actividad,
      this.etapaCultivo,
      this.registroMonitoreoPlagas,
      this.ausenciaPlagas,
      this.cantidadAfectada,
      this.porcentajeIncidencia,
      this.porcentajeSeveridad,
      this.faseDesarrolloPlaga,
      this.organoAfectado,
      this.distribucionPlaga,
      this.poblacion,
      this.descripcionSintomas,
      this.envioMuestra,
      this.resultadoInspeccion,
      this.numeroPlantasInspeccion,
      this.observaciones,
      this.usuario,
      this.usuarioId,
      this.fechaCreacion,
      this.idTablet,
      this.tabletId,
      this.tabletVersionBase});

  int? id;
  int? idSeguimientoCuarentenario;
  String? rucOperador;
  String? razonSocial;
  int? codigoPaisOrigen;
  String? paisOrigen;
  String? producto;
  String? subtipo;
  String? peso;
  int? numeroPlantasIngreso;
  int? codigoProvincia;
  String? provincia;
  int? codigoCanton;
  String? canton;
  int? codigoParroquia;
  String? parroquia;
  String? nombreScpe;
  String? tipoOperacion;
  String? tipoCuarentenaCondicionProduccion;
  String? faseSeguimiento;
  String? codigoLote;
  int? numeroSeguimientosPlanificados;
  String? cantidadTotal;
  String? cantidadVigilada;
  String? actividad;
  String? etapaCultivo;
  String? registroMonitoreoPlagas;
  String? ausenciaPlagas;
  String? cantidadAfectada;
  String? porcentajeIncidencia;
  String? porcentajeSeveridad;
  String? faseDesarrolloPlaga;
  String? organoAfectado;
  String? distribucionPlaga;
  String? poblacion;
  String? descripcionSintomas;
  String? envioMuestra;
  String? resultadoInspeccion;
  String? numeroPlantasInspeccion;
  String? observaciones;
  String? usuario;
  String? usuarioId;
  String? fechaCreacion;
  int? idTablet;
  String? tabletId;
  String? tabletVersionBase;

  factory SeguimientoCuarentenarioSvModelo.fromJson(
          Map<String, dynamic> json) =>
      SeguimientoCuarentenarioSvModelo(
        id: json["id"],
        idSeguimientoCuarentenario: json["id_seguimiento_cuarentenario"],
        rucOperador: json["ruc_operador"],
        razonSocial: json["razon_social"],
        codigoPaisOrigen: json["codigo_pais_origen"],
        paisOrigen: json["pais_origen"],
        producto: json["producto"],
        subtipo: json["subtipo"],
        peso: json["peso"],
        numeroPlantasIngreso: json["numero_plantas_ingreso"],
        codigoProvincia: json["codigo_provincia"],
        provincia: json["provincia"],
        codigoCanton: json["codigo_canton"],
        canton: json["canton"],
        codigoParroquia: json["codigo_parroquia"],
        parroquia: json["parroquia"],
        nombreScpe: json["nombre_scpe"],
        tipoOperacion: json["tipo_operacion"],
        tipoCuarentenaCondicionProduccion:
            json["tipo_cuarentena_condicion_produccion"],
        faseSeguimiento: json["fase_seguimiento"],
        codigoLote: json["codigo_lote"],
        numeroSeguimientosPlanificados:
            json["numero_seguimientos_planificados"],
        cantidadTotal: json["cantidad_total"].toString(),
        cantidadVigilada: json["cantidad_vigilada"].toString(),
        actividad: json["actividad"],
        etapaCultivo: json["etapa_cultivo"],
        registroMonitoreoPlagas: json["registro_monitoreo_plagas"],
        ausenciaPlagas: json["ausencia_plagas"],
        cantidadAfectada: json["cantidad_afectada"].toString(),
        porcentajeIncidencia: json["porcentaje_incidencia"].toString(),
        porcentajeSeveridad: json["porcentaje_severidad"].toString(),
        faseDesarrolloPlaga: json["fase_desarrollo_plaga"],
        organoAfectado: json["organo_afectado"],
        distribucionPlaga: json["distribucion_plaga"],
        poblacion: json["poblacion"].toString(),
        descripcionSintomas: json["descripcion_sintomas"],
        envioMuestra: json["envio_muestra"],
        resultadoInspeccion: json["resultado_inspeccion"],
        numeroPlantasInspeccion: json["numero_plantas_inspeccion"],
        observaciones: json["observaciones"],
        usuario: json["usuario"],
        usuarioId: json["usuario_id"],
        fechaCreacion: json["fecha_creacion"],
        idTablet: json['id_tablet'],
        tabletId: json['tablet_id'],
        tabletVersionBase: json['tablet_version_base'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_seguimiento_cuarentenario": idSeguimientoCuarentenario,
        "ruc_operador": rucOperador,
        "razon_social": razonSocial,
        "codigo_pais_origen": codigoPaisOrigen,
        "pais_origen": paisOrigen,
        "producto": producto,
        "subtipo": subtipo,
        "peso": peso,
        "numero_plantas_ingreso": numeroPlantasIngreso,
        "codigo_provincia": codigoProvincia,
        "provincia": provincia,
        "codigo_canton": codigoCanton,
        "canton": canton,
        "codigo_parroquia": codigoParroquia,
        "parroquia": parroquia,
        "nombre_scpe": nombreScpe,
        "tipo_operacion": tipoOperacion,
        "tipo_cuarentena_condicion_produccion":
            tipoCuarentenaCondicionProduccion,
        "fase_seguimiento": faseSeguimiento,
        "codigo_lote": codigoLote,
        "numero_seguimientos_planificados": numeroSeguimientosPlanificados,
        "cantidad_total": cantidadTotal,
        "cantidad_vigilada": cantidadVigilada,
        "actividad": actividad,
        "etapa_cultivo": etapaCultivo,
        "registro_monitoreo_plagas": registroMonitoreoPlagas,
        "ausencia_plagas": ausenciaPlagas,
        "cantidad_afectada": cantidadAfectada,
        "porcentaje_incidencia": porcentajeIncidencia,
        "porcentaje_severidad": porcentajeSeveridad,
        "fase_desarrollo_plaga": faseDesarrolloPlaga,
        "organo_afectado": organoAfectado,
        "distribucion_plaga": distribucionPlaga,
        "poblacion": poblacion,
        "descripcion_sintomas": descripcionSintomas,
        "envio_muestra": envioMuestra,
        "resultado_inspeccion": resultadoInspeccion,
        "numero_plantas_inspeccion": numeroPlantasInspeccion,
        "observaciones": observaciones,
        "usuario": usuario,
        "usuario_id": usuarioId,
        "fecha_creacion": fechaCreacion,
        "id_tablet": idTablet,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase,
      };

  @override
  String toString() {
    return ''' SeguimientoCuarentenarioSvModelo{
    id: $id,
    id_seguimiento_cuarentenario: $idSeguimientoCuarentenario,
    ruc_operador: $rucOperador,
    razon_social: $razonSocial,
    codigo_pais_origen: $codigoPaisOrigen,
    pais_origen: $paisOrigen,
    producto: $producto,
    subtipo: $subtipo,
    peso: $peso,
    numero_plantas_ingreso: $numeroPlantasIngreso,
    codigo_provincia: $codigoProvincia,
    provincia: $provincia,
    codigo_canton: $codigoCanton,
    canton: $canton,
    codigo_parroquia: $codigoParroquia,
    parroquia: $parroquia,
    nombre_scpe: $nombreScpe,
    tipo_operacion: $tipoOperacion,
    tipo_cuarentena_condicion_produccion: $tipoCuarentenaCondicionProduccion,
    fase_seguimiento: $faseSeguimiento,
    codigo_lote: $codigoLote,
    numero_seguimientos_planificados: $numeroSeguimientosPlanificados,
    cantidad_total: $cantidadTotal,
    cantidad_vigilada: $cantidadVigilada,
    actividad: $actividad,
    etapa_cultivo: $etapaCultivo,
    registro_monitoreo_plagas: $registroMonitoreoPlagas,
    ausencia_plagas: $ausenciaPlagas,
    cantidad_afectada: $cantidadAfectada,
    porcentaje_incidencia: $porcentajeIncidencia,
    porcentaje_severidad: $porcentajeSeveridad,
    fase_desarrollo_plaga: $faseDesarrolloPlaga,
    organo_afectado: $organoAfectado,
    distribucion_plaga: $distribucionPlaga,
    poblacion: $poblacion,
    descripcion_sintomas: $descripcionSintomas,
    envio_muestra: $envioMuestra,
    resultado_inspeccion: $resultadoInspeccion,
    numero_plantas_inspeccion: $numeroPlantasInspeccion,
    observaciones: $observaciones,
    usuario: $usuario,
    usuario_id: $usuarioId,
    fecha_creacion: $fechaCreacion,
    id_tablet: $idTablet,
    tablet_id: $tabletId,
    tablet_version_base: $tabletVersionBase,
    }''';
  }
}
