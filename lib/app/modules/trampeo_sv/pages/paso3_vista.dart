import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/boton_foto.dart';
import 'package:agro_servicios/app/core/widgets/camara.dart';
import 'package:agro_servicios/app/core/widgets/vista_previa_imagen.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class FotoTrampa extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const FotoTrampa({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Medidas().init(context);
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const Espaciador(alto: 15),
                        const Text(
                          'Finalizar Trampa',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF69949C)),
                        ),
                        const Espaciador(alto: 15),
                        _buildMensajeInicial(),
                        const Espaciador(alto: 15),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: anchoPantalla * 0.04,
                        right: anchoPantalla * 0.04),
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  _buildFoto(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMensajeInicial() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: anchoPantalla * 0.04),
      child: Text(
        'Puede tomar un fotografía o guarde la información ingresada',
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }

  Widget _buildFoto(context) {
    Medidas().init(context);
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Espaciador(alto: 20),
        const Center(child: Text('Tome una fotografía (Opcional)')),
        const Espaciador(alto: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Center(
            child: Selector<TrampeoBloc, int?>(
              selector: (_, provider) => provider.numeroFotosTrampa,
              builder: (_, data, w) {
                return InkWell(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: provider.imagen == null
                        ? Image.asset(IMAGEN_PREVIA)
                        : _buildImagenPrevia(context),
                  ),
                  onTap: () async {
                    if (provider.imagen != null) {
                      await Get.to(
                        () => VistaImagen(
                          imagen: provider.imagen!,
                          onTap: (esEliminar) {
                            provider.eliminarImagen();
                          },
                        ),
                      );
                    } else {
                      _mensajeImagen(context);
                    }
                  },
                );
              },
            ),
          ),
        ),
        const Espaciador(
          alto: 20,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: anchoPantalla * 0.04, right: anchoPantalla * 0.04),
          child: BotonFoto(
            onPress: (_) async {
              var xFile = await Get.to(() => const Camara());

              if (xFile != null) {
                provider.setImagen = xFile.path;
                provider.setNumeroFotosTrampa = provider.numeroFotosTrampa + 1;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImagenPrevia(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Hero(
      tag: 'imgprevia',
      child: Image.file(provider.imagen!),
    );
  }

  void _mensajeImagen(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sin imagen'),
          content: const Text('Primero añada una imagen'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
