import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';
import 'package:agro_servicios/app/data/provider/local/db_trampeo_vigilancia.dart';

class BlocTrampeoLugar {
  List<LocalizacionModelo> _listaCantones = List.empty();

  Future<List<LocalizacionModelo>> getCantonesSincronizados() async {
    _listaCantones = await DBLocalizcion.db.getLocalizacionPorPadre(66);
    return _listaCantones;
  }

  Future<List<LocalizacionModelo>> getProvinciasSincronizadas() async {
    // print("llego a buscar provincias<<<<");
    List<LocalizacionModelo> listaProvinciasSincronizadas = List.empty();
    listaProvinciasSincronizadas =
        await DBTrampeoVigilancia().getProvinciasSincronizadas();
    /* listaProvinciasSincronizadas.forEach((e) {
      print(e.nombre);
    });*/

    return listaProvinciasSincronizadas;
  }
}
