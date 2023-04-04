import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/utils/codigos_provincias.dart'
    as codigo_provincia;

String generarCodigoSv({
  required String provincia,
}) {
  String codigoSv;
  String codigo = codigo_provincia.codigoProvincia(provincia);
  final String fechaInicial =
      DateTime.now().toUtc().microsecondsSinceEpoch.toString();
  int? numeroSecuencial = BD_VERSION;
  codigoSv = '$codigo-$fechaInicial-$numeroSecuencial';
  return codigoSv;
}
