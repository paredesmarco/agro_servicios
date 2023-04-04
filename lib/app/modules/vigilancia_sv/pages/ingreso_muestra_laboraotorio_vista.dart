import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_orden_laboratorio.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_vigilancia_sv.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_sv.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class FormularioDatosMuestraLaboratorioVigilancia extends StatefulWidget {
  const FormularioDatosMuestraLaboratorioVigilancia({super.key});

  @override
  State<StatefulWidget> createState() =>
      _FormularioDatosMuestraLaboratorioVigilanciaState();
}

class _FormularioDatosMuestraLaboratorioVigilanciaState
    extends State<FormularioDatosMuestraLaboratorioVigilancia> {
  final recursos = CatalogosTrampasSv();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String imagenCheck = 'img/check-circle-regular.svg';

  @override
  void initState() {
    final p = context.read<OrdenLaboratorioSvBloc>();
    p.limpiarFormulario();
    p.setCodigoMuestra = p.generarCodigoMuestra(p.listaOrdenes.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                  _titulo(
                                      'Nueva orden de trabajo para laboratorio'),
                                  const Espaciador(alto: 10),
                                  _buildOrganoAfectado(),
                                  _buildConservacionMuestra(),
                                  _campoTrampa(
                                      'Código de campo de la muestra', null),
                                  const Espaciador(alto: 20),
                                  _titulo('Tipo de análisis'),
                                  errorSintomas(),
                                  _buildEntomologico(),
                                  _buildNematoLogico(),
                                  _buildFitoPatologico(),
                                  _buildBiologiaMolecular(),
                                  _buildMaleza(),
                                  _buildMalacologia(),
                                  const Espaciador(alto: 20),
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

  Widget _titulo(String titulo) {
    return Center(
      child: Text(titulo,
          style: const TextStyle(color: Color(0xFF69949C), fontSize: 17)),
    );
  }

  Widget _buildOrganoAfectado() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Selector<OrdenLaboratorioSvBloc, String?>(
      selector: (_, provider) => provider.tipoMuestraError,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getTipoMuestra(),
          label: 'Tipo de muestra',
          errorText: data,
          onChanged: (valor) {
            provider.setTipoMuestra = valor;
          },
        );
      },
    );
  }

  Widget _buildConservacionMuestra() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Selector<OrdenLaboratorioSvBloc, String?>(
      selector: (_, provider) => provider.conservacionMuestraError,
      builder: (_, data, w) {
        return Combo(
          items: CatalogosVigilanciaSV().getConservacionMuestra(),
          label: 'Conservación de la muestra',
          errorText: provider.conservacionMuestraError,
          onChanged: (valor) {
            provider.setConservacionMuestra = valor;
          },
        );
      },
    );
  }

  Widget _campoTrampa(String etiqueta, dynamic valor) {
    return Selector<OrdenLaboratorioSvBloc, String>(
      selector: (_, provider) => provider.codigoMuestra,
      builder: (_, data, w) {
        return CampoDescripcionBorde(
          etiqueta: etiqueta,
          valor: data,
        );
      },
    );
  }

  Widget _buildEntomologico() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Row(
      children: [
        Selector<OrdenLaboratorioSvBloc, bool>(
          selector: (_, provider) => provider.esEntomologico,
          builder: (_, data, w) {
            return Checkbox(
              value: provider.esEntomologico,
              onChanged: (bool? valor) {
                provider.setEntomologico = valor!;
              },
            );
          },
        ),
        Text('Entomológico', style: _textoStyle()),
      ],
    );
  }

  Widget _buildNematoLogico() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Row(
      children: [
        Selector<OrdenLaboratorioSvBloc, bool>(
          selector: (_, provider) => provider.esNematologico,
          builder: (_, data, w) {
            return Checkbox(
              value: provider.esNematologico,
              onChanged: (bool? valor) {
                provider.setNemantologico = valor!;
              },
            );
          },
        ),
        Text('Nematológico', style: _textoStyle()),
      ],
    );
  }

  Widget _buildFitoPatologico() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Row(
      children: [
        Selector<OrdenLaboratorioSvBloc, bool>(
          selector: (_, provider) => provider.esFitopatologico,
          builder: (_, data, w) {
            return Checkbox(
              value: provider.esFitopatologico,
              onChanged: (bool? valor) {
                provider.setFitopatologico = valor!;
              },
            );
          },
        ),
        Text('Fitopatológico', style: _textoStyle()),
      ],
    );
  }

  Widget _buildBiologiaMolecular() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Row(
      children: [
        Selector<OrdenLaboratorioSvBloc, bool>(
          selector: (_, provider) => provider.esBiologiaMolecular,
          builder: (_, data, w) {
            return Checkbox(
              value: provider.esBiologiaMolecular,
              onChanged: (bool? valor) {
                provider.setBiologiaMolecular = valor!;
              },
            );
          },
        ),
        Text('Biología Molecular', style: _textoStyle()),
      ],
    );
  }

  Widget _buildMaleza() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Row(
      children: [
        Selector<OrdenLaboratorioSvBloc, bool>(
          selector: (_, provider) => provider.esMaleza,
          builder: (_, data, w) {
            return Checkbox(
              value: provider.esMaleza,
              onChanged: (bool? valor) {
                provider.setMaleza = valor!;
              },
            );
          },
        ),
        Text('Malezas', style: _textoStyle()),
      ],
    );
  }

  Widget _buildMalacologia() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Row(
      children: [
        Selector<OrdenLaboratorioSvBloc, bool>(
          selector: (_, provider) => provider.esMalacologia,
          builder: (_, data, w) {
            return Checkbox(
              value: provider.esMalacologia,
              onChanged: (bool? valor) {
                provider.setMalacologia = valor!;
              },
            );
          },
        ),
        Text('Malacología', style: _textoStyle()),
      ],
    );
  }

  Widget errorSintomas() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);

    return Selector<OrdenLaboratorioSvBloc, String>(
      selector: (_, selector) => selector.analisisError,
      builder: (_, data, w) {
        if (data.isNotEmpty) {
          return Column(
            children: [
              const Espaciador(alto: 15),
              Text(
                provider.analisisError,
                style: TextStyle(color: Colors.red[700], fontSize: 13),
              )
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildBotonGuardar(BuildContext context) {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return BotonPlano(
      texto: 'Completar Orden',
      color: const Color(0XFF1ABC9C),
      funcion: () async {
        bool esvalido = provider.validarFormulario();
        if (esvalido) {
          mostrarModalBottomSheet(
            context: context,
            titulo: 'Guardando Datos',
            icono: _buildIconoModalSincronizando(),
            mensaje: _buildMensajeModalSincronizados(),
          );
          await Future.delayed(const Duration(seconds: 1));
          provider.setMensajeValidacion = 'Los registros fueron almacenados';
          provider.setEstadoGuardandoOrdenlaboratorio = false;
          await Future.delayed(const Duration(seconds: 2));

          Get.back();
          Get.back();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        }
      },
      icono: const Icon(Icons.save, color: Colors.white, size: 20),
    );
  }

  Widget _buildIconoModalSincronizando() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Selector<OrdenLaboratorioSvBloc, bool>(
      selector: (_, provider) => provider.estadoGuardandoOrdenlaboratorio,
      builder: (p, data, widget) {
        if (data) return Modal.cargando();
        return Container(child: provider.icono);
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Selector<OrdenLaboratorioSvBloc, String>(
      selector: (_, provider) => provider.mensajeValidacion,
      builder: (_, data, widget) {
        if (data != '') {
          return Modal.mensajeSincronizacion(mensaje: data);
        } else {
          return Modal.mensajeSincronizacion(mensaje: DEFECTO_A);
        }
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
}
