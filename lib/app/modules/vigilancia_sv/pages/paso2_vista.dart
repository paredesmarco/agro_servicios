import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_caracteristicas.dart';
import 'package:agro_servicios/app/core/widgets/boton_foto.dart';
import 'package:agro_servicios/app/core/widgets/camara.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/vista_previa_imagen.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_vigilancia_sv.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';

class Caracteristicas extends StatefulWidget {
  const Caracteristicas({super.key});
  @override
  State<Caracteristicas> createState() => _CaracteristicasState();
}

class _CaracteristicasState extends State<Caracteristicas>
    with AutomaticKeepAliveClientMixin {
  _CaracteristicasState();

  TextEditingController? _cantidadAfectadaControlador;
  TextEditingController? _incidenciaControlador;
  TextEditingController? _severidadControlador;
  TextEditingController? _poblacionControlador;
  TextEditingController? _diagnosticoControlador;
  TextEditingController? _sintomasControlador;
  TextEditingController? _longitudControlador;
  TextEditingController? _latitudControlador;
  //TextEditingController _alturaControlador;

  @override
  void initState() {
    final p = context.read<CaracteristicasBloc>();
    p.eliminarImagenSinNotifier();
    _cantidadAfectadaControlador =
        TextEditingController(text: p.cantidadAfectada.toString());

    _severidadControlador = TextEditingController(text: p.severidad);
    _poblacionControlador = TextEditingController(text: p.poblacion);
    _sintomasControlador = TextEditingController(text: p.descripcionSintomas);

    p.encerarValidaciones();
    super.initState();
  }

  @override
  void dispose() {
    _cantidadAfectadaControlador!.dispose();
    _incidenciaControlador!.dispose();
    _severidadControlador!.dispose();
    _poblacionControlador!.dispose();
    _diagnosticoControlador!.dispose();
    _sintomasControlador!.dispose();
    _longitudControlador!.dispose();
    _latitudControlador!.dispose();
    //_alturaControlador.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Medidas().init(context);
    return Column(
      children: [
        const Espaciador(
          alto: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
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
                        'Características del cultivo/producto',
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
                          _buildEspecieCombo(
                              context,
                              CatalogosVigilanciaSV()
                                  .getEspecieVegetalString()),
                          _buildCantidadTotal(),
                          _builCantidadVigilancia(),
                          _buildUnidad(),
                          _buildSitioOperacion(),
                          _buildCondicionProduccion(),
                          _buildEtapaCultivo(),
                          _buildActividad(),
                          _buildManejoSitio(),
                          _buildPresenciaPlagas(context),
                          _buildPrediagnostico(),
                          _buildCantidadEfectiva(),
                          _buildIncidencia(),
                          _buildSeveridad(),
                          _buildTipoPlaga(),
                          _buildFasePlaga(),
                          _buildOrganoAfectado(),
                          _buildDistribucionPlaga(),
                          _buildPoblacion(),
                          _buildDiagnosticoVisual(),
                          _buildDescripcionSintomas(),
                          const Espaciador(alto: 20),
                          _buildFoto(),
                          _buildLongitud(),
                          _buildLatitud(),
                          //_buildAltura(),
                          const Espaciador(alto: 40)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildEspecieCombo(context, List<String> lista) {
    final providers = Provider.of<CaracteristicasBloc>(context);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.especieError,
      builder: (_, data, w) {
        // print('build especie');
        return ComboBusqueda(
          lista: CatalogosVigilanciaSV().getEspecieVegetalString(),
          label: 'Especie Vegetal',
          errorText: data,
          onChange: (valor) {
            providers.setEspecie = valor;
          },
        );
      },
    );
  }

  Widget _buildCantidadTotal() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorCantidadTotal,
      builder: (_, data, w) {
        return CampoTexto(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          label: 'Cantidad total',
          errorText: data,
          maxLength: 8,
          textInputFormatter: <TextInputFormatter>[
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(
              RegExp(r'(^\d*\.?\d*)'),
            )
          ],
          onChanged: (valor) {
            provider.setCantidadTotal = valor;
          },
        );
      },
    );
  }

  Widget _builCantidadVigilancia() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorCantidadVigilancia,
      builder: (_, data, w) {
        return CampoTexto(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          label: 'Cantidad vigilancia',
          errorText: data,
          maxLength: 8,
          textInputFormatter: <TextInputFormatter>[
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
          onChanged: (valor) {
            provider.setCantidadVigilancia = valor;
          },
        );
      },
    );
  }

  Widget _buildUnidad() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorUnidad,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getUnidad(),
          label: 'Unidad',
          errorText: provider.errorUnidad,
          onChanged: (valor) {
            provider.setUnidad = valor;
          },
        );
      },
    );
  }

  Widget _buildSitioOperacion() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorSitioOperacion,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getSitioOperacion(),
          label: 'Sitio de operación',
          errorText: provider.errorSitioOperacion,
          onChanged: (valor) {
            provider.setSitioOperacion = valor;
          },
        );
      },
    );
  }

  Widget _buildCondicionProduccion() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorCondicionProduccion,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getCondicionProduccion(),
          label: 'Condición de la producción',
          errorText: data,
          onChanged: (valor) {
            provider.setCondicionProduccion = valor;
          },
        );
      },
    );
  }

  Widget _buildEtapaCultivo() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorEtapaCultivo,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getEtapaCultivo(),
          label: 'Etapa del cultivo',
          errorText: provider.errorEtapaCultivo,
          onChanged: (valor) {
            provider.setEtapaCultivo = valor;
          },
        );
      },
    );
  }

  Widget _buildActividad() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorActividad,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getActividad(),
          label: 'Actividad',
          errorText: provider.errorActividad,
          onChanged: (valor) {
            provider.setActividad = valor;
          },
        );
      },
    );
  }

  Widget _buildManejoSitio() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorManejoOperacion,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getManejoSitio(),
          label: 'Manejo del sitio de operación',
          errorText: provider.errorManejoOperacion,
          onChanged: (valor) {
            provider.setManejoSitioOperacion = valor;
          },
        );
      },
    );
  }

  Widget _buildPresenciaPlagas(context) {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 15),
        const Text('Presencia de plagas', style: EstilosTextos.etiquetasInputs),
        Selector<CaracteristicasBloc, String?>(
          selector: (_, provider) => provider.presenciaPlaga,
          builder: (_, data, w) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Si',
                      groupValue: provider.presenciaPlaga,
                      onChanged: (dynamic valor) {
                        provider.setPresenciaPlaga = valor;
                        // provider.setCamposActivos = true;
                      },
                    ),
                    const Text('Si', style: EstilosTextos.radioYcheckbox),
                    Radio(
                      value: 'No',
                      groupValue: provider.presenciaPlaga,
                      onChanged: (dynamic valor) {
                        provider.setPresenciaPlaga = valor;
                        // provider.setCamposActivos = false;
                      },
                    ),
                    const Text('No', style: EstilosTextos.radioYcheckbox),
                  ],
                ),
                // if (provider.esProductoQuimicoVacio) _mensajeErrorRadioButton(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPrediagnostico() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorPlagaPredianostico, provider.camposActivos),
      builder: (_, data, w) {
        if (data.item2) {
          return ComboBusqueda(
            lista: provider.listaPlagaPrediagnostico,
            label: 'Plaga/Diagnóstico visual o prediagnóstico',
            onChange: (valor) {
              provider.setPlagaDiagnostico = valor;
            },
            errorText: data.item1,
          );
        } else {
          return const ComboBloqueado(
              label: 'Plaga/Diagnóstico visual o prediagnóstico');
        }
      },
    );
  }

  Widget _buildCantidadEfectiva() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: true);
    _cantidadAfectadaControlador =
        TextEditingController(text: provider.cantidadAfectada)
          ..selection = TextSelection.collapsed(
              offset: provider.cantidadAfectada?.length ?? 0);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorCantidadAfectada, provider.camposActivos),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _cantidadAfectadaControlador,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          label: 'Cantidad afectada',
          errorText: data.item1,
          maxLength: 8,
          textInputFormatter: <TextInputFormatter>[
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
          enable: data.item2,
          onChanged: (valor) {
            provider.setCantidadAfectada = valor;
          },
        );
      },
    );
  }

  Widget _buildIncidencia() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _incidenciaControlador = TextEditingController(text: provider.incidencia);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorIncidencia, provider.camposActivos),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _incidenciaControlador,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          label: '% Incidencia',
          errorText: data.item1,
          maxLength: 10,
          textInputFormatter: <TextInputFormatter>[
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
          enable: false,
          onChanged: (valor) {
            provider.setIncidencia = valor;
          },
        );
      },
    );
  }

  Widget _buildSeveridad() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _severidadControlador = TextEditingController(text: provider.severidad)
      ..selection =
          TextSelection.collapsed(offset: provider.severidad?.length ?? 0);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorSeveridad, provider.camposActivos),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _severidadControlador,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          label: '% Severidad',
          errorText: data.item1,
          maxLength: 8,
          textInputFormatter: <TextInputFormatter>[
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
          enable: data.item2,
          onChanged: (valor) {
            provider.setSeveridad = valor;
          },
        );
      },
    );
  }

  _buildTipoPlaga() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorTipoPlaga, provider.camposActivos),
      builder: (_, data, w) {
        if (data.item2) {
          return ComboBusqueda(
            lista: CatalogosVigilanciaSV().getTipoPlagaString(),
            label: 'Tipo de plaga',
            errorText: data.item1,
            onChange: (valor) {
              provider.setTipoPlaga = valor;
            },
          );
        }
        return const ComboBloqueado(label: 'Tipo de plaga');
      },
    );
  }

  Widget _buildFasePlaga() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorFasePlaga, provider.camposActivos),
      builder: (_, data, w) {
        if (data.item2) {
          return Combo(
            items: CatalogosVigilanciaSV().getFasePlaga(),
            label: 'Fase de desarrollo de la plaga',
            errorText: data.item1,
            enabled: data.item2,
            onChanged: (valor) {
              provider.setFasePlaga = valor;
            },
          );
        }
        return const ComboBloqueado(label: 'Fase de desarrollo de la plaga');
      },
    );
  }

  Widget _buildOrganoAfectado() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorOrganoAfectado, provider.camposActivos),
      builder: (_, data, w) {
        if (data.item2) {
          return Combo(
            items: CatalogosVigilanciaSV().getOrganoAfectado(),
            label: 'Órgano afectado',
            errorText: data.item1,
            enabled: data.item2,
            onChanged: (valor) {
              provider.setOrganoAfectado = valor;
            },
          );
        }
        return const ComboBloqueado(label: 'Órgano afectado');
      },
    );
  }

  Widget _buildDistribucionPlaga() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorDistribucionPlaga, provider.camposActivos),
      builder: (_, data, w) {
        if (data.item2) {
          return Combo(
            items: CatalogosVigilanciaSV().getDistribucionPlaga(),
            label: 'Distribución de la plaga',
            errorText: provider.errorDistribucionPlaga,
            enabled: data.item2,
            onChanged: (valor) {
              provider.setDistribucionPlaga = valor;
            },
          );
        }
        return const ComboBloqueado(label: 'Distribución de la plaga');
      },
    );
  }

  Widget _buildPoblacion() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _poblacionControlador = TextEditingController(text: provider.poblacion)
      ..selection =
          TextSelection.collapsed(offset: provider.poblacion?.length ?? 0);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorPoblacion, provider.camposActivos),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _poblacionControlador,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          label: 'Población',
          errorText: data.item1,
          textInputFormatter: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*)'))
          ],
          enable: data.item2,
          maxLength: 8,
          onChanged: (valor) {
            provider.setPoblacion = valor;
          },
        );
      },
    );
  }

  Widget _buildDiagnosticoVisual() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _diagnosticoControlador =
        TextEditingController(text: provider.diagnosticoVisual);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorDiagnostioVisual, provider.camposActivos),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _diagnosticoControlador,
          label: 'Diagnóstico visual',
          errorText: data.item1,
          enable: data.item2,
          maxLength: 64,
          readOnly: true,
          onChanged: (valor) {
            provider.setDiagnosticoVisual = valor;
          },
        );
      },
    );
  }

  Widget _buildDescripcionSintomas() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _sintomasControlador =
        TextEditingController(text: provider.descripcionSintomas)
          ..selection = TextSelection.collapsed(
              offset: provider.descripcionSintomas?.length ?? 0);
    return Selector<CaracteristicasBloc, Tuple2<String?, bool>>(
      selector: (_, provider) =>
          Tuple2(provider.errorDescripcionSintomas, provider.camposActivos),
      builder: (_, data, w) {
        return CampoTexto(
          controller: _sintomasControlador,
          label: 'Descripción de síntomas',
          errorText: data.item1,
          maxLength: 256,
          enable: data.item2,
          onChanged: (valor) {
            provider.setDescripcionSintoma = valor;
          },
        );
      },
    );
  }

  Widget _buildFoto() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Fotografía del síntoma',
            style: TextStyle(fontSize: 18, color: Color(0xFF69949C)),
          ),
        ),
        const Espaciador(alto: 20),
        const Center(child: Text('Tome una fotografía (opcional)')),
        const Espaciador(alto: 20),
        Center(
          child: Selector<CaracteristicasBloc, int?>(
            selector: (_, provider) => provider.numeroFotosTrampa,
            builder: (_, data, w) {
              return InkWell(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: provider.imagen == null
                      ? Image.asset(provider.rutaFoto)
                      : _buildImagenPrevia(),
                ),
                onTap: () async {
                  if (provider.imagen != null) {
                    await Get.to(
                      () => VistaImagen(
                        imagen: provider.imagen,
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
        const Espaciador(alto: 20),
        BotonFoto(
          onPress: (_) async {
            var xFile = await Get.to(() => const Camara());

            if (xFile != null) {
              debugPrint(xFile.path);
              provider.setImagenFile = xFile.path;
              provider.setNumeroFotosTrampa = provider.numeroFotosTrampa + 1;
              provider.obtenerCoordenadas();
            }
          },
        ),
      ],
    );
  }

  Widget _buildImagenPrevia() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    return Hero(
      tag: 'imgprevia',
      child: Image.file(provider.imagen),
    );
  }

  Widget _buildLongitud() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _longitudControlador = TextEditingController(text: provider.longitudImagen)
      ..selection =
          TextSelection.collapsed(offset: provider.longitudImagen?.length ?? 0);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorLongitudImagen,
      builder: (_, data, w) {
        return CampoTexto(
          controller: _longitudControlador,
          label: 'Longitud',
          maxLength: 32,
          errorText: data,
          enable: false,
          onChanged: (valor) {
            provider.setLongitudImagen = valor;
          },
        );
      },
    );
  }

  Widget _buildLatitud() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _latitudControlador = TextEditingController(text: provider.latitudImagen)
      ..selection =
          TextSelection.collapsed(offset: provider.latitudImagen?.length ?? 0);
    return Selector<CaracteristicasBloc, String?>(
      selector: (_, provider) => provider.errorLatitudimagen,
      builder: (_, data, w) {
        return CampoTexto(
          controller: _latitudControlador,
          label: 'Latitud',
          errorText: data,
          maxLength: 32,
          enable: false,
          onChanged: (valor) {
            provider.setLatitudImagen = valor;
          },
        );
      },
    );
  }

  /* Widget _buildAltura() {
    final provider = Provider.of<CaracteristicasBloc>(context, listen: false);
    _alturaControlador = TextEditingController(text: provider.alturaImagen);
    return Selector<CaracteristicasBloc, String>(
      selector: (_, _provider) => _provider.errorAlturaImagen,
      builder: (_, data, w) {
        return CampoTexto(
          controller: _alturaControlador,
          label: 'Altura',
          errorText: data,
          enable: false,
          onChange: (valor) {
            provider.setAlturaImagen = valor;
          },
        );
      },
    );
  } */

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
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
