import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/mensaje_error_radio_button.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_lotes_controller.dart';

class ProductoImportadoIngresoLoteSv extends StatelessWidget {
  const ProductoImportadoIngresoLoteSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Ingreso de Lote',
      widgets: const [
        _DescripcionLote(),
        _NumeroCajas(),
        _PorcentajeInspeccion(),
        _CajasMuestra(),
        _AusenciaSuelo(),
        _AusenciaContaminantes(),
        _AusenciaSintomasPlagas(),
        _AusenciaPlagas(),
        _Dictamen(),
      ],
      botonFormulario: BotonPlano(
          texto: 'Guardar',
          color: Colores.accentColor,
          funcion: () async {
            bool esValido = Get.find<ProductosImportadosLotesController>()
                .validarFormulario();
            if (esValido) {
              Get.find<ProductosImportadosLotesController>().guardarFormulario(
                titulo: ALMACENANDO,
                icono: const _IconoModal(),
                mensaje: const _MensajeModal(),
              );
            } else {
              snackBarExterno(
                mensaje: SNACK_OBLIGATORIOS,
                snackBarBehavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                    bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
                context: context,
              );
            }
          }),
    );
  }
}

class _DescripcionLote extends StatelessWidget {
  const _DescripcionLote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosLotesController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 512,
          onChanged: (valor) => _.descripcionLote = valor,
          label: 'Descripción del Lote',
          errorText: _.errorDescripcion,
        );
      },
    );
  }
}

class _NumeroCajas extends StatelessWidget {
  const _NumeroCajas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosLotesController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          keyboardType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
          maxLength: 6,
          onChanged: (valor) => _.cajasLote = valor,
          label: 'No. Cajas envases / Lote',
          errorText: _.errorCajasEnvase,
        );
      },
    );
  }
}

class _PorcentajeInspeccion extends StatelessWidget {
  const _PorcentajeInspeccion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosLotesController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 10,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          margin: 8,
          onChanged: (valor) => _.porcentajeInspeccion = valor,
          label: '% Real de Inspección',
          errorText: _.errorPorcentaje,
        );
      },
    );
  }
}

class _CajasMuestra extends GetView<ProductosImportadosLotesController> {
  const _CajasMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CampoDescripcionBorde(
        etiqueta: 'No. Cajas muestra',
        valor: controller.nroCajasMuestra.value,
      ),
    );
  }
}

class _AusenciaSuelo extends StatelessWidget {
  const _AusenciaSuelo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Ausencia de suelo',
        ),
        GetBuilder<ProductosImportadosLotesController>(
          id: 'idAusenciaSuelo',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.ausenciaSuelo,
                  onChanged: (valor) => _.ausenciaSuelo = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.ausenciaSuelo,
                  onChanged: (valor) => _.ausenciaSuelo = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.errorAsuenciaSuelo == true)
                  const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AusenciaContaminantes extends StatelessWidget {
  const _AusenciaContaminantes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Ausencia de contaminantes vegetales prohibidos',
        ),
        GetBuilder<ProductosImportadosLotesController>(
          id: 'idAusencuiaContaminante',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.ausenciaContaminante,
                  onChanged: (valor) => _.setAusenciaContaminante = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.ausenciaContaminante,
                  onChanged: (valor) => _.setAusenciaContaminante = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.errorAusenciaContaminante == true)
                  const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AusenciaSintomasPlagas extends StatelessWidget {
  const _AusenciaSintomasPlagas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Ausencia de síntomas de plagas',
        ),
        GetBuilder<ProductosImportadosLotesController>(
          id: 'idAusencuiaSintomasPlaga',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.ausenciaSintomaPlaga,
                  onChanged: (valor) => _.setAusenciaSintomaPlaga = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.ausenciaSintomaPlaga,
                  onChanged: (valor) => _.setAusenciaSintomaPlaga = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.errorAusenciaSintoma == true)
                  const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AusenciaPlagas extends StatelessWidget {
  const _AusenciaPlagas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Ausencia de plagas',
        ),
        GetBuilder<ProductosImportadosLotesController>(
          id: 'idAusenciaPlaga',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.ausenciaPlaga,
                  onChanged: (valor) => _.setAusenciaPlaga = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.ausenciaPlaga,
                  onChanged: (valor) => _.setAusenciaPlaga = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.errorAusenciaPlaga == true)
                  const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Dictamen extends StatelessWidget {
  const _Dictamen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Dictamen',
        ),
        GetBuilder<ProductosImportadosLotesController>(
          id: 'idDictamen',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Aprobar',
                  groupValue: _.dictamen,
                  onChanged: (valor) => _.setDictamen = valor!,
                ),
                const Text('Aprobar', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'Negar',
                  groupValue: _.dictamen,
                  onChanged: (valor) => _.setDictamen = valor!,
                ),
                const Text('Negar', style: EstilosTextos.radioYcheckbox),
                if (_.errorDictamen == true) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MensajeModal extends GetView<ProductosImportadosLotesController> {
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

class _IconoModal extends GetView<ProductosImportadosLotesController> {
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
