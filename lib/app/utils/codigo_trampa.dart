import 'package:agro_servicios/app/utils/codigos_provincias.dart'
    as codigo_provincia;

String generarCodigoMuestra(
    {int? secuencia,
    required String provincia,
    String fechaInicial = '',
    required String codigoFormulario}) {
  int? numeroSecuencial = secuencia;
  String codigoMuestra;
  String codigo = codigo_provincia.codigoProvincia(provincia);

  numeroSecuencial = numeroSecuencial ?? 0;
  numeroSecuencial += 1;

  codigoMuestra = '$codigoFormulario$codigo-$fechaInicial-$numeroSecuencial';

  return codigoMuestra;
}
