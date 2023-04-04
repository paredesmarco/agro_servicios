import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/utils/db/db_catalogos_sql.dart';
import 'package:agro_servicios/app/utils/db/db_transito_ingreso_sql.dart';
import 'package:agro_servicios/app/utils/db/db_caracterizacion_fr_mf_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_muestreo_mf_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_trampeo_mf_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_home_sql.dart';
import 'package:agro_servicios/app/utils/db/db_trampeo_vi_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_vigilancia_vi_vs_sql.dart';
import 'package:agro_servicios/app/utils/db/db_embalaje_control_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_seguimiento_cuarentenario_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_transito_salida_sql.dart';
import 'package:agro_servicios/app/utils/db/db_productos_importados_sql.dart';
import 'package:agro_servicios/app/utils/db/db_preguntas_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_respuestas_sv_sql.dart';
import 'package:agro_servicios/app/utils/db/db_trips_sql.dart';
import 'package:agro_servicios/app/utils/db/db_minador_sql.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get dataBase async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    var direccionDocumentos = await getDatabasesPath();
    String path = join(direccionDocumentos, 'agrodb2.db');
    debugPrint('Entro a iniciar base');

    return await openDatabase(
      path,
      version: BD_VERSION,
      onOpen: (db) {},
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    // var direccionDocumentos = await getDatabasesPath();
    // String path = join(direccionDocumentos, 'agrodb2.db');
    // await deleteDatabase(path);
    debugPrint('Entro a crear base');
    List<List<String>> scripts = [
      DBHomeSql.script,
      DBTrampeoViSvSql.script,
      DBVigilanciaViSvSql.script,
      DBTrampeoMfSvSql.script,
      DBMuestreoMfSvSql.script,
      DBCaracterizacionFrMfSv.script,
      DBCatalogosSql.script,
      DBTransitoIngresoSql.script,
      DBTransitoSalidaSql.script,
      DBEmbalajeControlSql.script,
      DBSeguimientoCuarentenarioSvSql.script,
      DBProductosImportadosSql.script,
      DBPreguntasSvSql.script,
      DBRespuestasSvSql.script,
      DBTripSql.script,
      DBMinadorSql.script,
    ];

    for (var script in scripts) {
      for (var e in script) {
        log(e);
        await db.execute(e);
      }
    }
  }

  void _onUpgrade(Database db, int oldVersion, int version) async {
    debugPrint('ENTRO A UPGRADE DE BASE');
    // if (oldVersion == 1) {
    //   List<List<String>> scripts = [DBTrampeoViSvSql.updateV2];

    //   for (var e in scripts) {
    //     for (var script in e) {
    //       await db.execute(script);
    //     }
    //   }
    // }

    // if (oldVersion == 3) {
    //   List<List<String>> scripts = [DBHomeSql.updateV4];

    //   for (var e in scripts) {
    //     for (var script in e) {
    //       await db.execute(script);
    //     }
    //   }
    // }

    // if (oldVersion == 4) {
    //   debugPrint('Actualizacion BD V5');

    //   List<List<String>> scripts = [DBVigilanciaViSvSql().updateV5()];

    //   for (var e in scripts) {
    //     for (var script in e) {
    //       await db.execute(script);
    //     }
    //   }
    // }

    // if (oldVersion < version) {
    //   List<List<String>> scripts = [
    //     DBHomeSql.script,
    //     DBTrampeoViSvSql.script,
    //     DBVigilanciaViSvSql().script(),
    //     DBTrampeoMfSvSql.script,
    //     DBMuestreoMfSvSql.script,
    //     DBCaracterizacionFrMfSv.script,
    //     DBCatalogosSql.script,
    //     DBTransitoIngresoSql.script,
    //     DBTransitoSalidaSql.script,
    //     DBEmbalajeControlSql.script,
    //     DBSeguimientoCuarentenarioSvSql.script,
    //     DBProductosImportadosSql.script,
    //   ];

    //   for (var e in scripts) {
    //     for (var script in e) {
    //       await db.execute(script);
    //     }
    //   }
    // }
  }
}
