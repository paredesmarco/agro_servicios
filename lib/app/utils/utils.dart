import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';

/// Devuelve la semana del año actual
///
/// Tipo de dato de respuesta String
String semanaDelAnio() {
  return '${Jiffy().week}';
}

String fechaFormateada(String formato, DateTime fecha) {
  final f = DateFormat(formato);
  return f.format(fecha);
}

///Devuelve el ID del dispostivo
// Future<String> idDispositivo() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   late String idDispositivo;
//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     idDispositivo = '${androidInfo.androidId}';
//   } else if (Platform.isIOS) {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     idDispositivo = '${iosInfo.identifierForVendor}';
//   }
//   return idDispositivo;
// }

/// Devuelve un [String] con los días transcurridos entre una fecha determinada y la fecha actual
///
/// Si las fecha recibida es null devuelve "1"
String calcularDiasEntreFechas(fecha) {
  if (fecha != '' && fecha != null) {
    DateTime fechaTime = DateTime.parse(fecha.toString());

    int dias = _disTranscurridosDesde(fechaTime, DateTime.now());

    return dias.toString();
  } else {
    return '1';
  }
}

int _disTranscurridosDesde(DateTime desde, DateTime hasta) {
  desde = DateTime(desde.year, desde.month, desde.day);
  hasta = DateTime(hasta.year, hasta.month, hasta.day);

  return hasta.difference(desde).inDays;
}

// Recibe una cadena[String] de texto y un caracter[String] y remueve este caracter si coincide con el enviado por el usuario
/// Remueve el último caracter de una cadena[String] de texto
///
/// Si el parámetro caracter[String] es enviado se remueve el último caracter de la cadena
/// si este concide con el caracter enviado
String removerUltimoCaracter({required String cadena, String? caracter}) {
  String result = cadena;
  String ultimoCaracter;

  if (cadena.isNotEmpty) {
    ultimoCaracter = cadena.substring(cadena.length - 1);
    if (caracter == null) {
      result = cadena.substring(0, cadena.length - 1);
    } else {
      if (ultimoCaracter == caracter) {
        result = cadena.substring(0, cadena.length - 1);
      }
    }
  }

  return result;
}

/// Retorna [true] si el dispositivo es iphone y tiene como lector biométrico Face ID
Future<bool> tieneFaceID() async {
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> a = await auth.getAvailableBiometrics();
  if (Platform.isIOS) {
    if (a.contains(BiometricType.face)) {
      return true;
    }
  }
  return false;
}

/// Recibe una cadena[String] un caracterSeparador[String] y la cantidad[int] de caracteres ha ser removidos
///
/// Si el primer caracter de la cadena coincide con el caracter separador recibido, se
/// elimina el número de caracteres indicado en el parámetro cantidad desde el caractercter separador hacia la izquierda
String? removerNprimerosCaracteres(
    {String? cadena, String? caracterSeparador, int? cantidad = 1}) {
  String? result = cadena;
  String ultimoCaracter;

  if ((cadena != null) && (cadena.isNotEmpty)) {
    ultimoCaracter = cadena.substring(0, 1);
    if (ultimoCaracter == caracterSeparador) {
      result = cadena.substring(cantidad!, cadena.length);
    }
  }

  return result;
}

/// Recibe una cadena[String] y valida si es un tipo de dato [double]
///
/// Si la cadena enviada es quivalente a un double devulve [true] caso contrario devuelve [false]
bool validarDouble(String? valor) {
  if (valor == null) {
    return false;
  }

  return double.tryParse(valor) != null;
}

/// Recibe una cadena[String] y valida si es un tipo de dato [int]
///
/// Si la cadena enviada es quivalente a un int devulve [true] caso contrario devuelve [false]
bool validarInt(String? valor) {
  if (valor == null) {
    return false;
  }

  return int.tryParse(valor) != null;
}

Future<void> limpiarCache() async {
  var cacheDir = (await getTemporaryDirectory()).path;
  debugPrint('path cache: $cacheDir');
  debugPrint('limpiando la cache de la aplicación');
  Directory(cacheDir).deleteSync(recursive: true);

  // final cacheDir = await getTemporaryDirectory();
  // if (cacheDir.existsSync()) {
  //   cacheDir.deleteSync(recursive: true);
  //   debugPrint('limpiando la cache de la aplicación');
  // }
}

/// FUNCION: PERMITE ESPERAR ALGUNOS SEGUNDO ANTES DE GUARDAR CADA LETRA QUE SE GUARDA EN UN TEXT
final debouncer = Debouncer(delay: const Duration(milliseconds: 400));

/// Covierte un archivo en base64
///
/// Recibe un [String] con la ruta de los archivo.
/// Si el archivo existe, devuelve el archivo en base64[String].
/// Si el archivo no existe devuelve [null]
Future<String?> base64Archivo(String? archivo) async {
  String? base64Image;
  File? imagen;
  if (archivo == null) {
    return null;
  }

  if (File(archivo).existsSync()) {
    imagen = File(archivo);
    base64Image = base64Encode(imagen.readAsBytesSync());
  } else {
    base64Image = null;
  }

  return base64Image;
}

/// Sincronicamente elimina una lista de archivos
///
/// Recibe un List[String] con las rutas de los archivos.
/// Si el archivo existe es eliminado.
Future<void> eliminarArchivos(List<String> archivos) async {
  for (var e in archivos) {
    if (File(e).existsSync()) {
      await File(e).delete();
    }
  }
}
