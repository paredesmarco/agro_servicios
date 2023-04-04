import 'dart:convert';
import 'package:agro_servicios/app/data/models/trips_sv/trips_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_sitio_modelo.dart';
import 'package:http/http.dart';
import 'package:agro_servicios/app/data/provider/ws/base_provider.dart';
import 'package:logger/logger.dart';

class TripsProvider extends BaseProvider {
  //Obtiene el Catalogo de Sitios del Servidor del Sistema GUIA
  Future<List<TripsSitioModelo>> obtenerSitioCatalogo(
      String provincia, Future<String?> tokens) async {
    Response res;
    List<TripsSitioModelo> listaSitioModelo = [];
    final token = await tokens;

    res = await httpGettWS(
      endPoint: 'RestWsTrips/catalogoSitioProduccionFlores',
      parametros: provincia,
      token: token,
    ).timeout(const Duration(seconds: 30));

    final lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    if (listaCuerpo != null) {
      listaSitioModelo =
          listaCuerpo.map((e) => TripsSitioModelo.fromJson(e)).toList();
    }
    return listaSitioModelo;
  }

  //Obtiene el Catalogo de Productores del Servidor del Sistema GUIA
  Future<List<TripsProductorModelo>> obtenerProductorCatalogo(
      String provincia, Future<String?> tokens) async {
    Response res;
    List<TripsProductorModelo> listaProductorModelo = [];
    final token = await tokens;
    res = await httpGettWS(
      endPoint: 'RestWsTrips/catalogoProductoresProduccionFlores',
      parametros: provincia,
      token: token,
    ).timeout(const Duration(seconds: 30));

    final lista = json.decode(res.body);

    List? listaCuerpo = lista['cuerpo'] ?? [];

    if (listaCuerpo != null) {
      listaProductorModelo =
          listaCuerpo.map((e) => TripsProductorModelo.fromJson(e)).toList();
    }
    return listaProductorModelo;
  }

  Future sincronizacionSubir(
      Map<String, dynamic> inspeccion, Future<String?> tokens) async {
    final token = await tokens;
    final Response res;
    var logger = Logger();
    // logger.d(inspeccion);
    // print(inspeccion);
    res = await httpPostWS(
      endPoint: 'RestWsTrips/guardarTrips',
      parametrosJson: jsonEncode(inspeccion),
      token: token,
    ).timeout(const Duration(seconds: 30));
    logger.d(res.body);
    return res;
  }
}
