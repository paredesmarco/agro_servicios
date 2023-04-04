import 'dart:convert';
import 'package:agro_servicios/app/data/models/preguntas_sv/ponderacion_modelo.dart';
import 'package:http/http.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';

class PonderacionProvider extends BaseProvider {
  ///Obtine el catalogo de Ponderación para Formularios de  SV del Servidor del Sistema GUIA
  Future<List<PonderacionModelo>> obtenerPonderacionCatalogo(
    Future<String?> tokens,
    idFormulario,
  ) async {
    Response res;
    List<PonderacionModelo> listaPonderacionModelo = [];
    final token = await tokens;
    res = await httpGettWS(
      endPoint: 'RestWsPonderacion/catalogoPonderacion',
      parametros: '$idFormulario',
      token: token,
    ).timeout(const Duration(seconds: 30));

    final lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    if (listaCuerpo != null) {
      listaPonderacionModelo =
          listaCuerpo.map((e) => PonderacionModelo.fromJson(e)).toList();
    }

    return listaPonderacionModelo;
  }
}
