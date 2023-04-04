import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_producto_control_sv_controller.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';

class IngresoProductoControlSv extends StatelessWidget {
  const IngresoProductoControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Nuevo Producto',
      widgets: const [
        _Partida(),
        _Descripcion(),
        _Cantidad(),
        _TipoEnvase(),
      ],
      botonFormulario: _botonFormulario(),
    );
  }

  Widget _botonFormulario() {
    return BotonPlano(
      texto: 'Guardar',
      color: Colores.accentColor,
      funcion: () async {
        bool esValido = Get.find<TransitoIngresoProductoControlSvController>()
            .validarFormulario();

        if (esValido) {
          Get.find<TransitoIngresoProductoControlSvController>()
              .guardarFormulario(
                  titulo: ALMACENANDO,
                  icono: const _IconoModal(),
                  mensaje: const _MensajeModal());
        } else {
          snackBarExterno(
            elevation: 6,
            snackBarBehavior: SnackBarBehavior.floating,
            mensaje: SNACK_OBLIGATORIOS,
            margin: EdgeInsets.only(
                bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
            context: Get.context!,
          );
        }
      },
    );
  }
}

class _Partida extends StatelessWidget {
  const _Partida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TransitoIngresoProductoControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          errorText: _.errorPartida,
          label: 'Partida arancelaria',
          lista: _.productos
              .map(
                  (e) => '${e.nombre} (${e.partidaArancelaria}) - ${e.subtipo}')
              .toList(),
          onChange: (valor) {
            _.partidaArancelaria = valor;
          },
        );
      },
    );
  }
}

class _Descripcion extends GetView<TransitoIngresoProductoControlSvController> {
  const _Descripcion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CampoDescripcionBorde(
        etiqueta: 'Descripción',
        valor: controller.nombreProducto.value,
      ),
    );
  }
}

class _Cantidad extends StatelessWidget {
  const _Cantidad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitoIngresoProductoControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          errorText: _.errorCantidad,
          maxLength: 10,
          onChanged: (valor) {
            _.cantidad = valor;
          },
          label: 'Cantidad (Kg)',
          keyboardType: const TextInputType.numberWithOptions(),
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
        );
      },
    );
  }
}

class _TipoEnvase extends StatelessWidget {
  const _TipoEnvase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TransitoIngresoProductoControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorEnvase,
          items: _.envases.map((e) {
            return DropdownMenuItem(
                value: e.nombreEnvase, child: Text(e.nombreEnvase!));
          }).toList(),
          label: 'Tipo de envase',
          onChanged: (valor) {
            _.tipoEnvase = valor;
          },
        );
      },
    );
  }
}

class _MensajeModal
    extends GetView<TransitoIngresoProductoControlSvController> {
  const _MensajeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Modal.mensajeSincronizacion(
            mensaje: controller.mensajeGuardado.value, fontSize: 12);
      },
    );
  }
}

class _IconoModal extends GetView<TransitoIngresoProductoControlSvController> {
  const _IconoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.validandoGuardado.value) return Modal.cargando();
      if (controller.estadoGuardado == 'error') {
        return Modal.iconoError();
      } else if (controller.estadoGuardado == 'advertencia') {
        return Modal.iconoAdvertencia();
      } else {
        return Modal.iconoValido();
      }
    });
  }
}
