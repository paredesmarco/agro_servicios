import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_laboratorio_controller.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_mf_sv.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';

class IngresoMuesteaLaboratorioMfSv extends StatelessWidget {
  IngresoMuesteaLaboratorioMfSv({Key? key}) : super(key: key);

  final controlador = Get.find<TrampeoMfSvLaboratorioController>();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Orden para Laboratorio',
      widgets: [
        const NombreSeccion(etiqueta: 'Nueva orden de trabajo de laboratorio'),
        _builCodigoTrampa(),
        _buildCodigoMuestra(),
        _builTipoMuestra(),
        _buildTipoAnalisis(),
      ],
      botonFormulario: _buildBotonGuardar(),
    );
  }

  Widget _builCodigoTrampa() {
    return GetBuilder<TrampeoMfSvLaboratorioController>(
      id: 'idCodigo',
      builder: (_) {
        return Combo(
          items: _.lista.map((e) {
            return DropdownMenuItem(
              value: e.codigoTrampa,
              child: Text(e.codigoTrampa!),
            );
          }).toList(),
          label: 'Código de la trampa',
          errorText: _.errorCodigoTrampa,
          onChanged: (valor) {
            _.generarCodigoMuestra(valor);
            _.setCodigoTrampaPadre = valor;
          },
        );
      },
    );
  }

  Widget _builTipoMuestra() {
    return GetBuilder<TrampeoMfSvLaboratorioController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          items: CatalogoTrampasMfSv().getTipoMuestra(),
          label: 'Tipo de muestra',
          errorText: _.errorTipoMuestra,
          onChanged: (valor) {
            controlador.setTipoMuestra = valor;
          },
        );
      },
    );
  }

  Widget _buildTipoAnalisis() {
    return Row(
      children: [
        Obx(() {
          return Checkbox(
            value: controlador.entomologico.value,
            onChanged: (bool? valor) {
              controlador.setEntomologico = valor!;
              controlador.entomologico.value = valor;
            },
          );
        }),
        Text('Entomológico', style: _textoStyle()),
      ],
    );
  }

  Widget _buildCodigoMuestra() {
    return Obx(() {
      return CampoDescripcionBorde(
        etiqueta: 'Código de campo de la muestra',
        valor: controlador.codigoMuestra.value,
      );
    });
  }

  BotonPlano _buildBotonGuardar() {
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
    return GetX<TrampeoMfSvLaboratorioController>(
      builder: (_) {
        if (_.validandoBajada.value) return Modal.cargando();
        return Modal.iconoValido();
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Obx(() {
      return Modal.mensajeSincronizacion(
          mensaje: controlador.mensajeBajarDatos.value);
    });
  }

  _textoStyle() {
    return const TextStyle(color: Color(0xFF75808f));
  }
}
