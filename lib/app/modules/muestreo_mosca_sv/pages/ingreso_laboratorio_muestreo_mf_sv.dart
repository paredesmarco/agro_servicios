import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_laboratorio_ingreso_controller.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_mf_sv.dart';
import 'package:agro_servicios/app/utils/catalogos/catologos_muestreo_mf_sv.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';

class MuestreoMfSvLaboratorio extends StatelessWidget {
  MuestreoMfSvLaboratorio({Key? key}) : super(key: key);

  final controlador = Get.find<MuestreoMfSvLaboratorioIngresoController>();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Orden para laboratorio',
      widgets: [
        const NombreSeccion(etiqueta: 'Orden de trabajo para laboratorio'),
        _buildCodigoMuestra(),
        _builEspeciePrincipal(),
        _builSitioMuestreo(),
        _buildNumeroFrutos(),
        _buildAplicacionQuimico(),
        _buildSintomas(),
        const Espaciador(alto: 20)
      ],
      botonFormulario: _buildBotonFormulario(),
    );
  }

  Widget _buildCodigoMuestra() {
    return Obx(() => CampoDescripcionBorde(
          etiqueta: 'Código de campo de la muestra',
          valor: controlador.codigoMuestra.value,
        ));
  }

  Widget _builEspeciePrincipal() {
    return GetBuilder<MuestreoMfSvLaboratorioIngresoController>(
      builder: (_) {
        return ComboBusqueda(
          lista: CatalogoTrampasMfSv().getEspecieLista(),
          label: 'Especie',
          errorText: _.errorEspecie,
          onChange: (valor) => _.setEspecie = valor,
        );
      },
    );
  }

  Widget _builSitioMuestreo() {
    return GetBuilder<MuestreoMfSvLaboratorioIngresoController>(builder: (_) {
      return Combo(
        items: CatalogosMuestreoMfSv().getSitioMuestreoDropDown(),
        label: 'Sitio de muestreo',
        errorText: _.errorSitio,
        onChanged: (valor) => _.setSitio = valor,
      );
    });
  }

  Widget _buildNumeroFrutos() {
    return GetBuilder<MuestreoMfSvLaboratorioIngresoController>(builder: (_) {
      return CampoTexto(
        label: 'Número de frutos recolectados',
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputFormatter: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*)'))
        ],
        errorText: _.errorFrutos,
        onChanged: (valor) => _.setNumeroRecolectado = valor,
        maxLength: 10,
      );
    });
  }

  Widget _buildAplicacionQuimico() {
    return GetBuilder<MuestreoMfSvLaboratorioIngresoController>(builder: (_) {
      return Combo(
        items: CatalogosMuestreoMfSv().getProductoQuimicoDropDown(),
        onChanged: (valor) => _.setProductoQuimico = valor,
        label: 'Aplicación de producto químico',
        errorText: _.errorQuimico,
      );
    });
  }

  Widget _buildSintomas() {
    return GetBuilder<MuestreoMfSvLaboratorioIngresoController>(builder: (_) {
      return CampoTexto(
        onChanged: (valor) => _.setDescripcion = valor,
        label: 'Descripción de síntomas o daños',
        errorText: _.errorDescripcion,
        maxLength: 150,
      );
    });
  }

  BotonPlano _buildBotonFormulario() {
    return BotonPlano(
      texto: 'Completar orden',
      color: const Color(0XFF1ABC9C),
      funcion: () async {
        bool validadoFormulario = controlador.validarFormulario();
        if (validadoFormulario) {
          await controlador.guardarFormulario(
            titulo: 'Guardando datos',
            mensaje: _buildMensajeModalSincronizados(),
            icono: _buildIconoModalSincronizados(),
          );
          Get.back();
          Get.back();
        } else {
          snackBarExterno(
              mensaje: SNACK_OBLIGATORIOS,
              context: Get.context!,
              elevation: 6,
              margin: EdgeInsets.only(
                  bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
              snackBarBehavior: SnackBarBehavior.floating);
        }
      },
      icono: const Icon(Icons.save, color: Colors.white, size: 20),
    );
  }

  Widget _buildIconoModalSincronizados() {
    return GetX<MuestreoMfSvLaboratorioIngresoController>(
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
}
