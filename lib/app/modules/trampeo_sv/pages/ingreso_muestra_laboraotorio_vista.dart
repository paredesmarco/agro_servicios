import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_sv.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class FormularioDatosMuestraLaboratorio extends StatefulWidget {
  const FormularioDatosMuestraLaboratorio({super.key});
  @override
  State<StatefulWidget> createState() =>
      _FormularioDatosMuestraLaboratorioState();
}

class _FormularioDatosMuestraLaboratorioState
    extends State<FormularioDatosMuestraLaboratorio> {
  final recursos = CatalogosTrampasSv();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    final p = context.read<TrampeoBloc>();
    p.limpiarOrdenLaboratorio();
    p.getTrampasParaLabortorio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    Medidas().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff09c273), Color(0xff05b386)],
          ),
        ),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text('Orden para Laboratorio'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      const Espaciador(
                        alto: 4,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: anchoPantalla * 0.04,
                                right: anchoPantalla * 0.04),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Espaciador(alto: 15),
                                  const NombreSeccion(
                                      etiqueta:
                                          'Nueva orden de trabajo para laboratorio'),
                                  const Espaciador(alto: 10),
                                  _buildProductoOrdenLaboratorioCombo(context),
                                  _buildTrampaCombo(context),
                                  const Espaciador(alto: 10),
                                  _campoTrampa('Código de campo de la muestra',
                                      provider.codigoCampoMuestra),
                                  _buildPrediagnosticoTexto(),
                                  _buildProductoQuimico(context),
                                  _buildTipoAnalisis(),
                                  // _buildEntomologico(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildBotonGuardar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductoOrdenLaboratorioCombo(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);

    return Combo(
      value: provider.productoOrdenLaboratorio,
      items: recursos.getProductoOrdenLaboratorio(),
      label: 'Producto para',
      onChanged: (valor) {},
      onSaved: (dynamic valor) async {
        provider.productoOrdenLaboratorio = valor;
      },
      validator: (dynamic valor) {
        if (valor == '--') {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }

  Widget _buildTrampaCombo(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);

    return Combo(
      value: provider.listaTrampasParaLaboratorio[0].codigoTrampa,
      items: provider.listaTrampasParaLaboratorio.map((e) {
        return DropdownMenuItem(
          value: e.codigoTrampa,
          child: Text(e.codigoTrampa!),
        );
      }).toList(),
      label: 'Trampa a la que pertenece la orden',
      onChanged: (dynamic valor) async {
        if (valor != '--') {
          provider.codigoTrampaParaOrdenLaboratorio = valor;

          provider.setCodigoMuestraParaOrdenLaboratorio =
              await provider.generarCodigoMuestra(valor);
        }
      },
      onSaved: (valor) {
        if (valor != '--') {
          provider.codigoTrampaParaOrdenLaboratorio = valor;
        }
      },
      validator: (dynamic valor) {
        if (valor == '--') {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }

  Widget _buildPrediagnosticoTexto() {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return CampoTexto(
      maxLength: 256,
      label: 'Prediagnóstico / Síntomas',
      onChanged: (valor) {},
      onSaved: (valor) {
        provider.setPrediagnostico = valor;
      },
      validator: (valor) {
        if (valor!.isEmpty) return 'El prediagnóstico es requerido';
        return null;
      },
    );
  }

  Widget _buildProductoQuimico(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 15),
        Text('Aplicó control químico sobre el producto o cultivo',
            style: _labelStyle()),
        Selector<TrampeoBloc, Tuple2<String?, bool>>(
          selector: (_, provider) =>
              Tuple2(provider.productoQuimico, provider.esProductoQuimicoVacio),
          builder: (_, data, w) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Si',
                      groupValue: provider.productoQuimico,
                      onChanged: (dynamic valor) {
                        provider.setPoductoQuimico = valor;
                      },
                    ),
                    Text('Si', style: _textoStyle()),
                    Radio(
                      value: 'No',
                      groupValue: provider.productoQuimico,
                      onChanged: (dynamic valor) {
                        provider.setPoductoQuimico = valor;
                      },
                    ),
                    Text('No', style: _textoStyle()),
                    Radio(
                      value: 'N/A',
                      groupValue: provider.productoQuimico,
                      onChanged: (dynamic valor) {
                        provider.setPoductoQuimico = valor;
                      },
                    ),
                    Text('N/A', style: _textoStyle()),
                  ],
                ),
                if (provider.esProductoQuimicoVacio) _mensajeErrorRadioButton(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTipoAnalisis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipo de análisis', style: _labelStyle()),
        Row(
          children: [
            Radio(
              value: null,
              groupValue: null,
              onChanged: (dynamic valor) {},
            ),
            const Text('Entomológico',
                style: TextStyle(color: Color(0xFF75808f))),
          ],
        )
      ],
    );
  }

  Widget _buildBotonGuardar(BuildContext context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return BotonPlano(
      texto: 'Completar Orden',
      color: const Color(0XFF1ABC9C),
      funcion: () async {
        bool condicion = provider.verificarFormularioOrdenLaboratorio();

        if (!condicion) {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);

          if (_formKey.currentState!.validate()) {
            return;
          }
        } else {
          if (!_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);

            return;
          } else {
            provider.setEstadoGuardandoOrdenlaboratorio = true;

            mostrarModalBottomSheet(
              context: context,
              titulo: ALMACENANDO,
              icono: _buildIconoModalSincronizando(),
              mensaje: _buildMensajeModalSincronizados(),
            );
            _formKey.currentState!.save();
            await Future.delayed(const Duration(seconds: 1));
            provider.guardarOrdenLaboratorio();
            provider.setMensajeValidacionlaboratorio =
                'Los registros fueron almacenados';
            await Future.delayed(const Duration(seconds: 1));
            Get.back();
            Get.back();
          }
        }
      },
      icono: const Icon(Icons.save, color: Colors.white, size: 20),
    );
  }

  Widget _buildIconoModalSincronizando() {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Selector<TrampeoBloc, bool>(
      selector: (_, provider) => provider.estadoGuardandoOrdenlaboratorio,
      builder: (_, data, widget) {
        if (data) return Modal.cargando();
        return Container(child: provider.icono);
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Selector<TrampeoBloc, String>(
      selector: (_, provider) => provider.mensajeValidacionlaboratorio,
      builder: (_, data, widget) {
        if (data != '') {
          return Modal.mensajeSincronizacion(mensaje: data);
        } else {
          return Modal.mensajeSincronizacion(mensaje: DEFECTO_A);
        }
      },
    );
  }

  Widget _campoTrampa(String etiqueta, dynamic valor) {
    return Selector<TrampeoBloc, String>(
      selector: (_, provider) => provider.codigoMuestraParaOrdenLaboratorio,
      builder: (_, data, w) {
        return CampoDescripcionBorde(
          etiqueta: etiqueta,
          valor: data,
        );
      },
    );
  }

  final SnackBar _snackBar = SnackBar(
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    content: const Text('Verifique los campos obligatorios'),
    margin: EdgeInsets.only(bottom: altoPantalla * 0.035, left: 10, right: 10),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {},
    ),
  );

  _textoStyle() {
    return const TextStyle(color: Color(0xFF75808f));
  }

  _labelStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey[500]);
  }

  Widget _mensajeErrorRadioButton() {
    return Column(
      children: [
        Text('Seleccione una opción para el producto químico',
            style: TextStyle(color: Colors.red[700], fontSize: 12)),
        const Espaciador(
          alto: 15,
        ),
      ],
    );
  }
}
