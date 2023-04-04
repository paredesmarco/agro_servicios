import 'dart:convert';
import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:http/http.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class PreguntasProvider extends BaseProvider {
  //Obtiene el Catalogo de Productores
  Future<List<PreguntasModelo>> obtenerPreguntasCatalogo(
      Future<String?> tokens, codificacionAplicacion) async {
    Response res;
    List<PreguntasModelo> listaPreguntasModelo = [];
    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsPreguntas/catalogoPreguntas',
      parametros: '$codificacionAplicacion',
      token: token,
    ).timeout(const Duration(seconds: 30));

    final lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    if (listaCuerpo != null) {
      listaPreguntasModelo =
          listaCuerpo.map((e) => PreguntasModelo.fromJson(e)).toList();
    }

    return listaPreguntasModelo;
  }
}
