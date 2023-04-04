import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_ubicacion.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';

class Ubicacion extends StatefulWidget {
  const Ubicacion({super.key});

  @override
  State<Ubicacion> createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion>
    with AutomaticKeepAliveClientMixin {
  _UbicacionState();

  TextEditingController? _nombreDenuncianteControlador;
  TextEditingController? _telefonoControlador;
  TextEditingController? _direccionControlador;
  TextEditingController? _correoControlador;

  @override
  void initState() {
    final p = context.read<UbicacionBloc>();
    p.encerarModelo();
    p.encerarValidaciones();
    super.initState();
  }

  @override
  void dispose() {
    // final p = context.read<UbicacionBloc>();
    // p.disposeControladores();
    _nombreDenuncianteControlador!.dispose();
    _telefonoControlador!.dispose();
    _direccionControlador!.dispose();
    _correoControlador!.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Medidas().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          const Espaciador(
            alto: 10,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Espaciador(
                      alto: altoPantalla * 0.02,
                    ),
                    const Center(
                      child: Text(
                        'Ubicación',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF69949C)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: anchoPantalla * 0.04,
                          right: anchoPantalla * 0.04),
                      child: Column(
                        children: [
                          const Espaciador(alto: 15),
                          _campoProvincia('Provincia', null),
                          _buildCantonces(),
                          _buildParroquias(),
                          _buildNombrePropietario(),
                          _buildLocalidad(),
                          _buildCoordenadasX(),
                          _buildCoordenadasY(),
                          //_buildCoordenadasZ(),
                          const Espaciador(alto: 15),
                          const Center(
                            child: Text(
                              'Notificación fitosanitaria',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF69949C)),
                            ),
                          ),
                          _buildDenunciaFitosanitaria(context),
                          _buildNombreDenunciante(),
                          _buildTelefonoDenunciante(),
                          _buildDireccionDenunciante(),
                          _buildCorreoDenunciante(),
                          const Espaciador(alto: 75)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoProvincia(String etiqueta, dynamic valor) {
    return Selector<UbicacionBloc, String>(
      selector: (_, provider) => provider.nombreProvinciaSincronizada,
      builder: (_, data, w) {
        return CampoDescripcionBorde(
          etiqueta: etiqueta,
          valor: data,
        );
      },
    );
  }

  Widget _buildCantonces() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    return Selector<UbicacionBloc, Tuple2<List<LocalizacionModelo>, String?>>(
      selector: (_, provider) =>
          Tuple2(provider.listaCantonesUbicacion, provider.errorCanton),
      builder: (_, data, w) {
        return Combo(
          items: provider.listaCantonesUbicacion
              .map((e) => DropdownMenuItem(
                  value: e.idGuia.toString(), child: Text(e.nombre!)))
              .toList(),
          label: 'Cantones',
          errorText: data.item2,
          onChanged: (valor) {
            if (valor != null) {
              provider.getParroquiasUbicacion(int.parse(valor));
              provider.setCanton(valor);
            }
          },
        );
      },
    );
  }

  int idParroquia = 1;

  Widget _buildParroquias() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    return Selector<UbicacionBloc, Tuple2<List<LocalizacionModelo>, String?>>(
      selector: (_, provider) =>
          Tuple2(provider.listaParroquiasUbicacion, provider.errorParroquia),
      builder: (_, data, w) {
        return Combo(
          value: data.item1.isNotEmpty ? data.item1[0].idGuia : null,
          // value: null,
          // key: UniqueKey(),
          items: data.item1
              .map((e) =>
                  DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!)))
              .toList(),
          label: 'Parroquias',
          errorText: data.item2,
          onChanged: (valor) {
            if (valor > 1) provider.setParroquia(valor);
          },
        );
      },
    );
  }

  Widget _buildNombrePropietario() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    return Selector<UbicacionBloc, String?>(
      selector: (_, provider) => provider.errorNombrePropiedadFinca,
      builder: (_, data, w) {
        return CampoTexto(
          label: 'Nombre del propietario / Finca',
          errorText: data,
          maxLength: 256,
          onChanged: (valor) {
            provider.setPropiedadFinca = valor;
          },
        );
      },
    );
  }

  Widget _buildLocalidad() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);

    return Selector<UbicacionBloc, String?>(
      selector: (_, provider) => provider.errorLocalidadovia,
      builder: (_, data, w) {
        return CampoTexto(
          label: 'Localidad o vía',
          errorText: data,
          maxLength: 256,
          onChanged: (valor) {
            provider.setLocalidad = valor;
          },
        );
      },
    );
  }

  Widget _buildCoordenadasX() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    return Selector<UbicacionBloc, Tuple2<TextEditingController, String?>>(
      selector: (_, provider) =>
          Tuple2(provider.coordenadaXcontrolador, provider.errorCordenadaX),
      builder: (_, data, w) {
        return CampoTexto(
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          label: 'Coordenada X',
          maxLength: 32,
          controller: data.item1,
          errorText: data.item2,
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          onChanged: (valor) {
            provider.setCoordenadaX = valor;
          },
        );
      },
    );
  }

  Widget _buildCoordenadasY() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    return Selector<UbicacionBloc, Tuple2<TextEditingController, String?>>(
      selector: (_, provider) =>
          Tuple2(provider.coordenadaYcontrolador, provider.errorCordenadaY),
      builder: (_, data, w) {
        return CampoTexto(
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          label: 'Coordenada Y',
          controller: data.item1,
          errorText: data.item2,
          maxLength: 32,
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          onChanged: (valor) {
            provider.setCoordenadaY = valor;
          },
        );
      },
    );
  }

  /* Widget _buildCoordenadasZ() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    return Selector<UbicacionBloc, Tuple2<TextEditingController, String>>(
      selector: (_, _provider) =>
          Tuple2(_provider.coordenadaZcontrolador, _provider.errorCordenadaZ),
      builder: (_, data, w) {
        return CampoTexto(
          keyboardType: TextInputType.number,
          label: 'Coordenada Z',
          controller: data.item1,
          errorText: data.item2,
          onChange: (valor) {
            provider.setCoordenadaZ = valor;
          },
        );
      },
    );
  } */

  Widget _buildDenunciaFitosanitaria(context) {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 15),
        const Text('Denuncia Fitosanitaria',
            style: EstilosTextos.etiquetasInputs),
        Selector<UbicacionBloc, Tuple2<String?, bool>>(
          selector: (_, provider) => Tuple2(
              provider.denunciaFitosanitaria, provider.esDenunciaRadioVacio),
          builder: (_, data, w) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Si',
                      groupValue: provider.denunciaFitosanitaria,
                      onChanged: (dynamic valor) {
                        provider.setDenuncia = valor;
                      },
                    ),
                    const Text('Si', style: EstilosTextos.radioYcheckbox),
                    Radio(
                      value: 'No',
                      groupValue: provider.denunciaFitosanitaria,
                      onChanged: (dynamic valor) {
                        provider.setDenuncia = valor;
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const Text('No', style: EstilosTextos.radioYcheckbox),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildNombreDenunciante() {
    final provider = Provider.of<UbicacionBloc>(context, listen: true);
    _nombreDenuncianteControlador =
        TextEditingController(text: provider.nombreDenunciante);
    return Selector<UbicacionBloc, Tuple2<String?, bool>>(
      selector: (_, provider) => Tuple2(
          provider.errorNombreDenunciante, provider.esDenunciaRadioVacio),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _nombreDenuncianteControlador,
          label: 'Nombre del denunciante',
          errorText: data.item1,
          enable: data.item2,
          maxLength: 256,
          onChanged: (valor) {
            provider.setNombreDenunciante = valor;
          },
        );
      },
    );
  }

  Widget _buildTelefonoDenunciante() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    _telefonoControlador = TextEditingController(
      text: provider.telefonoDenunciante,
    )..selection = TextSelection.collapsed(
        offset: provider.telefonoDenunciante?.length ?? 0);
    return Selector<UbicacionBloc, Tuple2<String?, bool>>(
      selector: (_, provider) => Tuple2(
          provider.errorTelefonoDenunciante, provider.esDenunciaRadioVacio),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _telefonoControlador,
          keyboardType: TextInputType.number,
          label: 'Teléfono del denunciante',
          errorText: data.item1,
          maxLength: 32,
          enable: data.item2,
          onChanged: (valor) {
            provider.setTelefonoDenunciante = valor.toString();
          },
        );
      },
    );
  }

  Widget _buildDireccionDenunciante() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    _direccionControlador =
        TextEditingController(text: provider.direccionDenunciante);
    return Selector<UbicacionBloc, Tuple2<String?, bool>>(
      selector: (_, provider) => Tuple2(
          provider.errorDireccionDenunciante, provider.esDenunciaRadioVacio),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _direccionControlador,
          label: 'Dirección del denunciante',
          errorText: data.item1,
          enable: data.item2,
          maxLength: 32,
          onChanged: (valor) {
            provider.setDireccionDenunciante = valor;
          },
        );
      },
    );
  }

  Widget _buildCorreoDenunciante() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    _correoControlador =
        TextEditingController(text: provider.correoDenunciante);
    return Selector<UbicacionBloc, Tuple2<String?, bool>>(
      selector: (_, provider) => Tuple2(
          provider.errorCorreoDenunciante, provider.esDenunciaRadioVacio),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _correoControlador,
          keyboardType: TextInputType.emailAddress,
          label: 'Correo electrónico del denunciante',
          errorText: data.item1,
          enable: data.item2,
          maxLength: 32,
          onChanged: (valor) {
            provider.setCorreoDenunciante = valor;
          },
        );
      },
    );
  }
}
