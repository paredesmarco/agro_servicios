///Obejeto utilizado para manejar la respuesta de la función Ejecutar Consulta del BaseProvider
class RespuestaProvider {
  final dynamic cuerpo;
  final String? mensaje;
  final String? estado;

  RespuestaProvider({this.cuerpo, this.mensaje, this.estado});

  @override
  String toString() {
    return ''' RespuestaProvider{
      cuerpo: $cuerpo
      mensaje: $mensaje
      estado: $estado
    }
    ''';
  }
}
