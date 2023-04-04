import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_datos_trampa_controller.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_mf_sv.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class IngresoDatosTrampaMfSv extends StatelessWidget {
  const IngresoDatosTrampaMfSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return GetBuilder<TrampeoMfSvDatosTrampaController>(
      builder: (_) => CuerpoFormularioIngreso(
        titulo: 'Completar trampa ',
        widgets: [
          const NombreSeccion(
            etiqueta: 'Datos Generales',
          ),
          CampoDescripcion(
            etiqueta: 'Provincia',
            valor: _.trampa?.provincia,
          ),
          CampoDescripcion(
            etiqueta: 'Canton',
            valor: _.trampa?.canton,
          ),
          CampoDescripcion(
            etiqueta: 'Parroquia',
            valor: _.trampa?.parroquia,
          ),
          CampoDescripcion(
            etiqueta: 'Lugar de instalación',
            valor: _.trampa?.nombreLugarInstalacion,
          ),
          if (_.esParroquia)
            CampoDescripcion(
              etiqueta: 'Provincia',
              valor: _.trampa?.provincia,
            )
          else
            CampoDescripcion(
              etiqueta: 'Número lugar de instalación',
              valor: _.trampa?.numeroLugarInstalacion.toString(),
            ),
          CampoDescripcion(
            etiqueta: 'Tipo atrayente',
            valor: _.trampa?.nombreTipoAtrayente,
          ),
          CampoDescripcion(
            etiqueta: 'Tipo trampa',
            valor: _.trampa?.nombreTipoTrampa,
          ),
          CampoDescripcion(
            etiqueta: 'Código trampa',
            valor: _.trampa?.codigoTrampa,
          ),
          CampoDescripcion(
            etiqueta: 'Coordenada X',
            valor: _.trampa?.coordenadax,
          ),
          CampoDescripcion(
            etiqueta: 'Coordenada Y',
            valor: _.trampa?.coordenaday,
          ),
          CampoDescripcion(
            etiqueta: 'Coordenada Z',
            valor: _.trampa?.coordenadaz,
          ),
          CampoDescripcion(
            etiqueta: 'Fecha instalación',
            valor: fechaFormateada('yyyy-MM-dd', _.trampa!.fechaInstalacion!),
          ),
          CampoDescripcion(
            etiqueta: 'Estado Trampa',
            valor: _.trampa?.estadoTrampa,
          ),
          const NombreSeccion(
            etiqueta: 'Completar Trampa',
          ),
          _builCondicion(),
          _buildCambioTrampa(),
          _buildCambioPlug(),
          _builEspeciePrincipal(),
          _builEstadoPrincipal(),
          _builEspecieColindante(),
          _builEstadoColindante(),
          _buildEspecimenesCapturadosTexto(),
          _buildEnvioMuestra(),
          _buildObservacion(),
          const Espaciador(alto: 25)
        ],
        botonFormulario: _buildBotonGuardar(),
      ),
    );
  }

  Widget _builCondicion() {
    final controlador = Get.find<TrampeoMfSvDatosTrampaController>();
    return GetBuilder<TrampeoMfSvDatosTrampaController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          value: controlador.detalleTrampa.condicion,
          items: CatalogoTrampasMfSv().getCondicion(),
          label: 'Condición',
          errorText: _.errorCondicion,
          onChanged: (valor) {
            _.setCondicion = valor;
          },
        );
      },
    );
  }

  Widget _buildCambioTrampa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        Text('Cambio de Trampa', style: _labelStyle()),
        GetBuilder<TrampeoMfSvDatosTrampaController>(
          id: 'idCambioTrampa',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.cambioTrampa,
                  onChanged: (valor) => _.setCambioTrampa = valor,
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: _.cambioTrampa,
                  onChanged: (valor) => _.setCambioTrampa = valor,
                ),
                Text('No', style: _textoStyle()),
                if (_.sinCambioTrampa == true) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCambioPlug() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        Text('Cambio Plug', style: _labelStyle()),
        GetBuilder<TrampeoMfSvDatosTrampaController>(
          id: 'idCambioPlug',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.cambioPlug,
                  onChanged: (valor) => _.setCambioPlug = valor,
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: _.cambioPlug,
                  onChanged: (valor) => _.setCambioPlug = valor,
                ),
                Text('NO', style: _textoStyle()),
                Radio(
                  value: 'N/A',
                  groupValue: _.cambioPlug,
                  onChanged: (valor) => _.setCambioPlug = valor,
                ),
                Text('N/A', style: _textoStyle()),
                if (_.sinCambioPlug == true) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _builEspeciePrincipal() {
    final controlador = Get.find<TrampeoMfSvDatosTrampaController>();
    return GetBuilder<TrampeoMfSvDatosTrampaController>(
      id: 'idValidacion',
      builder: (_) {
        debugPrint('especie ${controlador.detalleTrampa.especiePrincipal}');
        return ComboBusqueda(
          selectedItem: controlador.detalleTrampa.especiePrincipal,
          lista: CatalogoTrampasMfSv().getEspecieLista(),
          label: 'Especie principal',
          errorText: _.errorEspeciePrincipal,
          onChange: (valor) {
            _.setEspeciePrincipal = valor;
          },
        );
      },
    );
  }

  Widget _builEstadoPrincipal() {
    return GetBuilder<TrampeoMfSvDatosTrampaController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          value: _.detalleTrampa.estadoFenologicoPrincipal,
          items: CatalogoTrampasMfSv().getEstadoFenologico(),
          label: 'Estado fenológico principal',
          errorText: _.errorFenologicoPrincipal,
          onChanged: (valor) {
            _.setEstadoFenologicoPrincipal = valor;
          },
        );
      },
    );
  }

  Widget _builEspecieColindante() {
    return GetBuilder<TrampeoMfSvDatosTrampaController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          selectedItem: _.detalleTrampa.especieColindante,
          lista: CatalogoTrampasMfSv().getEspecieLista(),
          label: 'Especie colindante',
          errorText: _.errorEspecieColindante,
          onChange: (valor) {
            _.setEspecieColindante = valor;
          },
        );
      },
    );
  }

  Widget _builEstadoColindante() {
    return GetBuilder<TrampeoMfSvDatosTrampaController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          value: _.detalleTrampa.estadoFenologicoColindante,
          items: CatalogoTrampasMfSv().getEstadoFenologico(),
          label: 'Estado fenológico colindante',
          errorText: _.errorFenologicoColindante,
          onChanged: (valor) {
            _.setEstadoFenologicoColindante = valor;
          },
        );
      },
    );
  }

  Widget _buildEspecimenesCapturadosTexto() {
    final controlador = Get.find<TrampeoMfSvDatosTrampaController>();
    return GetBuilder<TrampeoMfSvDatosTrampaController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          controller: controlador.numeroEspecimenesTextController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputFormatter: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*)'))
          ],
          label: 'Número de especímenes capturados',
          maxLength: 10,
          errorText: _.errorNumeroEspecimenes,
          onChanged: (valor) {
            _.setNumeroEspecimenes =
                valor == '' ? int.parse('0') : int.parse(valor);
          },
        );
      },
    );
  }

  Widget _buildEnvioMuestra() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        Text('Envío muestra', style: _labelStyle()),
        GetBuilder<TrampeoMfSvDatosTrampaController>(
          id: 'idEnvioMuestra',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.envioMuestra,
                  onChanged: (valor) => _.setEnvioMuestra = valor,
                ),
                Text('Si', style: _textoStyle()),
                Radio(
                  value: 'No',
                  groupValue: _.envioMuestra,
                  onChanged: (valor) => _.setEnvioMuestra = valor,
                ),
                Text('No', style: _textoStyle()),
                if (_.sinEnvioMuestra == true) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildObservacion() {
    final controlador = Get.find<TrampeoMfSvDatosTrampaController>();
    return CampoTexto(
      controller: controlador.observacionTextController,
      maxLength: 256,
      label: 'Observaciones',
      onChanged: (valor) =>
          Get.find<TrampeoMfSvDatosTrampaController>().setObservacion = valor,
    );
  }

  BotonPlano _buildBotonGuardar() {
    final controlador = Get.find<TrampeoMfSvDatosTrampaController>();
    return BotonPlano(
      texto: 'Completar Trampa',
      color: const Color(0XFF1ABC9C),
      funcion: () async {
        bool valido = controlador.validarFormulario();
        if (valido) {
          await controlador.guardarFormulario(
            titulo: 'Guardando datos',
            mensaje: _buildMensajeModalSincronizados(),
            icono: _buildIconoModalSincronizados(),
          );
        } else {
          snackBarExterno(
            mensaje: SNACK_OBLIGATORIOS,
            context: Get.context!,
            elevation: 6,
            snackBarBehavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
          );
        }
      },
      icono: const Icon(Icons.save, color: Colors.white, size: 20),
    );
  }

  Widget _buildIconoModalSincronizados() {
    return GetX<TrampeoMfSvDatosTrampaController>(
      builder: (_) {
        if (_.validandoBajada.value) return Modal.cargando();
        return Modal.iconoValido();
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    final controlador = Get.find<TrampeoMfSvDatosTrampaController>();
    return Obx(() {
      return Modal.mensajeSincronizacion(
          mensaje: controlador.mensajeBajarDatos.value);
    });
  }

  Widget _mensajeErrorRadioButton() {
    return Row(
      children: [
        const Espaciador(
          ancho: 10,
        ),
        Text('Campo requerido',
            style: TextStyle(color: Colors.red[700], fontSize: 12)),
      ],
    );
  }

  _labelStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey[500]);
  }

  _textoStyle() {
    return const TextStyle(color: Color(0xFF75808f));
  }
}
