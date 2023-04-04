import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_trampa_nueva_modelo.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_sv.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class FormularioDatosIngresoTrampa extends StatefulWidget {
  const FormularioDatosIngresoTrampa({super.key});
  @override
  State<StatefulWidget> createState() => _FormularioDatosIngresoTrampaState();

  void onLoad(BuildContext context) {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    final p = context.read<TrampeoBloc>();

    modeloFormulario.condicionTrampa =
        p.listaTrampasDetalle[p.indexTrampaGuardado].condicionTrampa;
    modeloFormulario.especie =
        p.listaTrampasDetalle[p.indexTrampaGuardado].especie;
    modeloFormulario.procedencia =
        p.listaTrampasDetalle[p.indexTrampaGuardado].procedencia;
    modeloFormulario.condicionCultivo =
        p.listaTrampasDetalle[p.indexTrampaGuardado].condicionCultivo;
    modeloFormulario.etapaCultivo =
        p.listaTrampasDetalle[p.indexTrampaGuardado].etapaCultivo;

    modeloFormulario.diagnosticoVisual =
        p.listaTrampasDetalle[p.indexTrampaGuardado].diagnosticoVisual;
    modeloFormulario.etapaPlaga =
        p.listaTrampasDetalle[p.indexTrampaGuardado].fasePlaga;
  }
}

class _FormularioDatosIngresoTrampaState
    extends State<FormularioDatosIngresoTrampa> {
  final recursos = CatalogosTrampasSv();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var propiedadControlador = TextEditingController();
  var especimencesControlador = TextEditingController();
  var observacionesControlador = TextEditingController();

  @override
  void initState() {
    FormularioTrampaNuevaModelo().encerarCampos();
    final p = context.read<TrampeoBloc>();
    p.encerarCamposNuevaTrampa();

    if (p.listaTrampas[p.trampaSeleccionada!].actualizado == true) {
      debugPrint("cargando trampa actualizada");
      propiedadControlador.text =
          p.listaTrampasDetalle[p.indexTrampaGuardado].propiedadFinca!;
      especimencesControlador.text =
          '${p.listaTrampasDetalle[p.indexTrampaGuardado].numeroEspecimenes}';
      observacionesControlador.text =
          p.listaTrampasDetalle[p.indexTrampaGuardado].observaciones!;
      widget.onLoad(context);
    }

    p.calcularDiasExposicion(
        p.listaTrampas[p.trampaSeleccionada!].fechaInspeccion);

    p.resetLugarTrampeoFormulario();
    p.getProvinciasSincronizadas();

    super.initState();
  }

  @override
  void dispose() {
    propiedadControlador.dispose();
    especimencesControlador.dispose();
    observacionesControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);

    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    final index = provider.trampaSeleccionada!;
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff09c273), Color(0xff05b386)],
          ),
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text('Completar Trampa'),
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
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: anchoPantalla * 0.04,
                                  right: anchoPantalla * 0.04,
                                ),
                                child: Form(
                                  key: provider.formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Espaciador(alto: 10),
                                      const Text('Datos Generales',
                                          style: TextStyle(
                                              color: Color(0xFF69949C),
                                              fontSize: 17)),
                                      _campoTrampa(
                                          'Código Trampa',
                                          provider.listaTrampas[index]
                                              .codigotrampa),
                                      _campoTrampa(
                                          'Provincia',
                                          provider
                                              .listaTrampas[index].provincia),
                                      _campoTrampa('Cantón',
                                          provider.listaTrampas[index].canton),
                                      _campoTrampa(
                                          'Parroquia',
                                          provider
                                              .listaTrampas[index].parroquia),
                                      _campoTrampa(
                                          'Coordenadas X',
                                          provider
                                              .listaTrampas[index].coordenadax),
                                      _campoTrampa(
                                          'Coordenadas Y',
                                          provider
                                              .listaTrampas[index].coordenaday),
                                      _campoTrampa(
                                          'Coordenadas Z',
                                          provider
                                              .listaTrampas[index].coordenadaz),
                                      _campoTrampa(
                                          'Lugar de instalación',
                                          provider.listaTrampas[index]
                                              .lugarinstalacion),
                                      _campoTrampa(
                                          'Número lugar de instalación',
                                          provider.listaTrampas[index]
                                              .numerolugarinstalacion),
                                      _campoTrampa(
                                          'Tipo de trampa',
                                          provider
                                              .listaTrampas[index].tipotrampa),
                                      _campoTrampa(
                                          'Fecha de instalación',
                                          provider.getFormatoFechaDate(provider
                                              .listaTrampas[index]
                                              .fechainstalacion!)),
                                      const Espaciador(alto: 10),
                                      const Divider(),
                                      const Espaciador(alto: 10),
                                      const Text('Completar Trampa',
                                          style: TextStyle(
                                              color: Color(0xFF69949C),
                                              fontSize: 17)),
                                      _buildPropiedadTexto(),
                                      _buildCondicionCombo(context),
                                      // _buildEspecieCombo(context,
                                      //     recursos.getEspecieVegetalString()),
                                      _buildEspecieCombo(),
                                      _buildProcedenciaCombo(),
                                      _buildCondicionCultivoCombo(context,
                                          recursos.getCondicionCultivo()),
                                      _buildEtapaCultivoCombo(
                                          context, recursos.getEtapaCultivo()),
                                      _campoTrampa('Exposición',
                                          modeloFormulario.exposicion),
                                      const Espaciador(alto: 12),
                                      _buildCambioFeromona(context),
                                      _buildCambioPapelAbsorvente(context),
                                      _buildCambioAceite(context),
                                      _buildCambioTrampa(context),
                                      _buildEspecimenesCapturadosTexto(context),
                                      _buildPlagaMonitoreada(),
                                      _buildEtapaPlaga(),
                                      _buildObservacionesTexto(),
                                      _buildMuestraLaboratorioRadioButton(
                                          context),
                                    ],
                                  ),
                                ),
                              ),
                              const Espaciador(alto: 20),
                            ],
                          ),
                        ),
                      ),
                      _buildBotonGuardar(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoTrampa(String etiqueta, dynamic valor) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
          //borderRadius: BorderRadius.all(Radius.circular(5)),
          //border: Border.all(width: 1, color: Color(0xFFDFDFDF)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              etiqueta,
              style: TextStyle(color: Colors.grey[500]),
            ),
            Text('$valor', style: const TextStyle(color: Color(0xFF75808f))),
          ],
        ),
      ),
    );
  }

  Widget _buildPropiedadTexto() {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return CampoTexto(
      maxLength: 256,
      controller: propiedadControlador,
      onChanged: (valor) {},
      onSaved: (valor) {
        modeloFormulario.propiedad = valor;
      },
      label: 'Propiedad/Finca',
    );
  }

  _buildCondicionCombo(context) {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Combo(
      items: recursos.getCondicionTrampa(),
      onChanged: (valor) {
        modeloFormulario.condicionTrampa = valor;
      },
      onSaved: (valor) {
        modeloFormulario.condicionTrampa = valor;
      },
      label: 'Condición de la Trampa',
      value: modeloFormulario.condicionTrampa,
      validator: (valor) {
        if (valor == '--') return 'La condición de la trampa es requerida';
        return null;
      },
    );
  }

  _buildEspecieCombo() {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return ComboBusqueda(
      label: 'Especie',
      lista: recursos.getEspecieVegetalString(),
      selectedItem: modeloFormulario.especie,
      onChange: (valor) {
        modeloFormulario.especie = valor;
      },
      onSave: (valor) {
        modeloFormulario.especie = valor;
      },
      validator: (valor) {
        if (valor == null || valor == '--') return 'La especie es requerida';
        return null;
      },
    );
  }

  _buildProcedenciaCombo() {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Combo(
      items: recursos.getProcedencia(),
      value: modeloFormulario.procedencia,
      label: 'Procedencia',
      onChanged: (valor) {
        modeloFormulario.procedencia = valor;
      },
      onSaved: (valor) {
        modeloFormulario.procedencia = valor;
      },
    );
  }

  _buildCondicionCultivoCombo(context, List<Widget> lista) {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Combo(
      items: recursos.getCondicionCultivo(),
      label: 'Condición cultivo',
      value: modeloFormulario.condicionCultivo,
      onChanged: (valor) {
        modeloFormulario.condicionCultivo = valor;
      },
      onSaved: (valor) {
        modeloFormulario.condicionCultivo = valor;
      },
      validator: (valor) {
        if (valor == '--') return 'La condición del cultivo es requerida';
        return null;
      },
    );
  }

  _buildEtapaCultivoCombo(context, List<Widget> lista) {
    final recursos = CatalogosTrampasSv();
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Combo(
      items: recursos.getEtapaCultivo(),
      label: 'Etapa Cultivo',
      value: modeloFormulario.etapaCultivo,
      onChanged: (valor) {
        modeloFormulario.etapaCultivo = valor;
      },
      onSaved: (valor) {
        modeloFormulario.etapaCultivo = valor;
      },
      validator: (valor) {
        if (valor == '--') return 'La etapa del cultivo es requerida';
        return null;
      },
    );
  }

  _buildCambioFeromona(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        Text('Cambio de Feromona', style: _labelStyle()),
        Selector<TrampeoBloc, Tuple2<String?, bool>>(
          selector: (_, provider) =>
              Tuple2(provider.cambioFeromonas, provider.esCambioFeromonaVacio),
          builder: (_, data, w) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setCambioFeromonas = valor;
                    modeloFormulario.cambioFeromona = valor;
                  },
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setCambioFeromonas = valor;
                    modeloFormulario.cambioFeromona = valor;
                  },
                ),
                Text('No', style: _textoStyle()),
                if (data.item2) _mensajeErrorRadioButton()
                //data.item2 ?
              ],
            );
          },
        ),
      ],
    );
  }

  _buildCambioPapelAbsorvente(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        Text('Cambio de papel absorbente', style: _labelStyle()),
        Selector<TrampeoBloc, Tuple2<String?, bool>>(
          selector: (_, provider) => Tuple2(
              provider.cambioPapelAbsorbente, provider.esCambioPapelVacio),
          builder: (_, data, w) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setCambioPapelAbsorbente = valor;
                    modeloFormulario.cambioPapel = valor;
                  },
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setCambioPapelAbsorbente = valor;
                    modeloFormulario.cambioPapel = valor;
                  },
                ),
                Text('No', style: _textoStyle()),
                if (data.item2) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }

  _buildCambioAceite(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        Text('Cambio de aceite', style: _labelStyle()),
        Selector<TrampeoBloc, Tuple2<String?, bool>>(
          selector: (_, provider) =>
              Tuple2(provider.cambioAceite, provider.esCambioAceiteVacio),
          builder: (_, data, w) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    debugPrint(valor);
                    provider.setCambioAceite = valor;
                    modeloFormulario.cambioAceite = valor;
                  },
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setCambioAceite = valor;
                    modeloFormulario.cambioAceite = valor;
                  },
                ),
                Text('No', style: _textoStyle()),
                if (data.item2) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }

  _buildCambioTrampa(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        Text(
          'Cambio de trampa',
          style: _labelStyle(),
        ),
        Selector<TrampeoBloc, Tuple2<String?, bool>>(
          selector: (_, provider) =>
              Tuple2(provider.cambioTrampa, provider.esCambioTrampaVacio),
          builder: (_, data, w) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setCambioTrampa = valor;
                    modeloFormulario.cambioTrampa = valor;
                  },
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setCambioTrampa = valor;
                    modeloFormulario.cambioTrampa = valor;
                  },
                ),
                Text('No', style: _textoStyle()),
                if (data.item2) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildEspecimenesCapturadosTexto(context) {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return CampoTexto(
      maxLength: 8,
      onChanged: (valor) {},
      onSaved: (valor) {
        modeloFormulario.numeroEspecimen = valor;
      },
      label: 'Número de especímenes capturados',
      textInputFormatter: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      enableInteractiveSelection: false,
      controller: especimencesControlador,
      keyboardType: TextInputType.number,
    );
  }

  _buildPlagaMonitoreada() {
    final recursos = CatalogosTrampasSv();
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return ComboBusqueda(
      label: 'Plaga monitoreada',
      lista: recursos.getPrediagnosticoString(),
      selectedItem: modeloFormulario.diagnosticoVisual,
      onChange: (valor) {
        modeloFormulario.diagnosticoVisual = valor;
      },
      onSave: (valor) {
        modeloFormulario.diagnosticoVisual = valor;
      },
    );
  }

  _buildEtapaPlaga() {
    final recursos = CatalogosTrampasSv();
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();

    return Combo(
        items: recursos.getEtapaDesarrollo(),
        value: modeloFormulario.etapaPlaga,
        onChanged: (dynamic valor) {
          modeloFormulario.etapaPlaga = valor;
        },
        onSaved: (dynamic valor) {
          modeloFormulario.etapaPlaga = valor;
        },
        label: 'Etapa de desarrollo de la plaga');
  }

  _buildObservacionesTexto() {
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return CampoTexto(
      maxLength: 256,
      onChanged: (valor) {},
      controller: observacionesControlador,
      onSaved: (valor) {
        modeloFormulario.observaciones = valor;
      },
      label: 'Observaciones',
    );
  }

  _buildMuestraLaboratorioRadioButton(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    FormularioTrampaNuevaModelo modeloFormulario =
        FormularioTrampaNuevaModelo();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 15),
        Text(
          'Envío de muestra a laboratorio',
          style: _labelStyle(),
        ),
        Selector<TrampeoBloc, Tuple2<String?, bool>>(
          selector: (_, provider) => Tuple2(
              provider.muestraLaboratorio, provider.esMuestraLaboratorioVacio),
          builder: (_, data, w) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setMuestraLaboratorio = valor;
                    modeloFormulario.muestraLaboratorio = valor;
                  },
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: data.item1,
                  onChanged: (dynamic valor) {
                    provider.setMuestraLaboratorio = valor;
                    modeloFormulario.muestraLaboratorio = valor;
                  },
                ),
                Text('No', style: _textoStyle()),
                if (data.item2) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }

  _buildBotonGuardar(BuildContext context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return BotonPlano(
      texto: 'Completar Trampa',
      color: const Color(0XFF1ABC9C),
      funcion: () async {
        bool condicion = provider.verificarFormularioNuevaTrampa();
        if (!condicion) {
          snackBarExterno(
              mensaje: 'Verifique los campos obligatorios',
              context: context,
              margin: EdgeInsets.only(
                  bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
              snackBarBehavior: SnackBarBehavior.floating);
          if (!provider.formkey.currentState!.validate()) {
            return;
          }
        } else {
          if (!provider.formkey.currentState!.validate()) {
            snackBarExterno(
                mensaje: 'Verifique los campos obligatorios',
                context: context,
                margin: EdgeInsets.only(
                    bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
                snackBarBehavior: SnackBarBehavior.floating);

            return;
          } else {
            provider.setEstaGuardando = true;
            provider.setEstaCargnado = true;

            mostrarModalBottomSheet(
              context: context,
              titulo: ALMACENANDO,
              icono: _buildIconoModalSincronizando(),
              mensaje: _buildMensajeModalSincronizados(),
            );

            provider.formkey.currentState!.save();
            await provider.guardarFormularioNuevaTrampa();
            provider.setMensajeValidacionTrampa =
                'Los datos fueron almacenados';
            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) return;
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }
      },
      icono: const Icon(Icons.save, color: Colors.white, size: 20),
    );
  }

  Widget _buildIconoModalSincronizando() {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);

    return Selector<TrampeoBloc, bool>(
      selector: (_, provider) => provider.estaCargando,
      builder: (_, data, widget) {
        if (data) {
          return Modal.cargando();
        }

        return Container(
          child: provider.icono,
        );
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Consumer<TrampeoBloc>(
      builder: (_, provider, widget) {
        if (provider.mensajeValidacionTrampa != '') {
          return Modal.mensajeSincronizacion(
              mensaje: provider.mensajeValidacionTrampa);
        } else {
          return Modal.mensajeSincronizacion(mensaje: DEFECTO_A);
        }
      },
    );
  }

  _labelStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey[500]);
  }

  _textoStyle() {
    return const TextStyle(color: Color(0xFF75808f));
  }

  Widget _mensajeErrorRadioButton() {
    return Row(
      children: [
        const Espaciador(
          ancho: 10,
        ),
        Text('El campo no puede estar vacío',
            style: TextStyle(color: Colors.red[700], fontSize: 12)),
      ],
    );
  }
}
