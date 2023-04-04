import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_laboratorio_control_sv_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_embalaje_control_sv.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class EmbalajeMuestraLaboratorioControlSv extends StatelessWidget {
  const EmbalajeMuestraLaboratorioControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Orden para laboratorio',
      widgets: const [
        NombreSeccion(etiqueta: 'Nueva orden de trabajo para laboratorio'),
        _Producto(),
        _TipoCliente(),
        _TipoMuestra(),
        _ConservacionMuestra(),
        _ActividadOrigen(),
        _Peso(),
        _CodigoMuestra(),
        _Prediagnostico(),
        _Sintomas(),
        _FaseFenologica(),
        NombreSeccion(etiqueta: 'Entomológico'),
        _IdentificacionInsectos(),
        NombreSeccion(etiqueta: 'Nematológico'),
        _ExtraccionNematodos01(),
        _ExtraccionNematodos02(),
        _ExtraccionNematodos03(),
        _ExtraccionNematodos06(),
        _ExtraccionNematodos09(),
        _ExtraccionNematodos12(),
        _ExtraccionNematodos14(),
        NombreSeccion(etiqueta: 'Fitopatológico'),
        Espaciador(alto: 10),
        _IdentificacionBacteriana(),
        _IdentificacionHongos(),
        _IdentificacionVirus(),
        Espaciador(alto: 20)
      ],
      botonFormulario: _botonFormulario(),
    );
  }

  BotonPlano _botonFormulario() {
    return BotonPlano(
      texto: 'Guardar Formulario',
      color: Colores.accentColor,
      funcion: () async {
        bool esValido = Get.find<EmbalajeLaboratorioControlSvController>()
            .validarFormulario();

        if (esValido) {
          await Get.find<EmbalajeLaboratorioControlSvController>()
              .guardarformulario(
            titulo: 'Almacenando',
            icono: const _IconoModal(),
            mensaje: const _MensajeModal(),
          );
        } else {
          snackBarExterno(
            mensaje: SNACK_OBLIGATORIOS,
            context: Get.context!,
            elevation: 6,
            margin: EdgeInsets.only(
                bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
            snackBarBehavior: SnackBarBehavior.floating,
          );
        }
      },
    );
  }
}

class _Producto extends GetView<EmbalajeLaboratorioControlSvController> {
  const _Producto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CampoDescripcionBorde(
        etiqueta: 'Producto', valor: controller.producto.value));
  }
}

class _TipoCliente extends GetView<EmbalajeLaboratorioControlSvController> {
  const _TipoCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: controller.errorTipoCliente,
          items: CatalogosEmbalajeControlSv().getTipocliente(),
          label: 'Tipo de cliente',
          onChanged: (valor) {
            controller.tipoCliente = valor;
          },
        );
      },
    );
  }
}

class _TipoMuestra extends GetView<EmbalajeLaboratorioControlSvController> {
  const _TipoMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: controller.errorTipoMuestra,
          items: CatalogosEmbalajeControlSv().getTipoMuestra(),
          label: 'Tipo de muestra',
          onChanged: (valor) {
            controller.tipoMuestra = valor;
          },
        );
      },
    );
  }
}

class _ConservacionMuestra
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ConservacionMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: controller.errorConservacion,
          items: CatalogosEmbalajeControlSv().getConservacion(),
          label: 'Conservación de la muestra',
          onChanged: (valor) {
            controller.conservacion = valor;
          },
        );
      },
    );
  }
}

class _ActividadOrigen extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ActividadOrigen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: controller.errorActividadOrigen,
          items: CatalogosEmbalajeControlSv().getActividad(),
          label: 'Actividad de origen',
          onChanged: (valor) {
            controller.actividadOrigen = valor;
          },
        );
      },
    );
  }
}

class _Peso extends GetView<EmbalajeLaboratorioControlSvController> {
  const _Peso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          errorText: controller.errorPeso,
          onChanged: (valor) {
            controller.peso = valor;
          },
          label: 'Peso de la muestra',
          maxLength: 8,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
          ],
        );
      },
    );
  }
}

class _CodigoMuestra extends GetView<EmbalajeLaboratorioControlSvController> {
  const _CodigoMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CampoDescripcionBorde(
        etiqueta: 'Código de campo de la muestra',
        valor: controller.codigoMuestra.value,
      ),
    );
  }
}

class _Prediagnostico extends GetView<EmbalajeLaboratorioControlSvController> {
  const _Prediagnostico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 150,
          errorText: controller.errorPrediagnostico,
          onChanged: (valor) {
            controller.prediagnostico = valor;
          },
          label: 'Prediagnóstico',
        );
      },
    );
  }
}

class _Sintomas extends GetView<EmbalajeLaboratorioControlSvController> {
  const _Sintomas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 150,
          errorText: controller.errorDescripcionSintomas,
          onChanged: (valor) {
            controller.descripcionSintomas = valor;
          },
          label: 'Descripción de síntomas o daños',
        );
      },
    );
  }
}

class _FaseFenologica extends GetView<EmbalajeLaboratorioControlSvController> {
  const _FaseFenologica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLaboratorioControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 50,
          errorText: controller.errorFaseFenologica,
          onChanged: (valor) {
            controller.faseFenologica = valor;
          },
          label: 'Fase fenológica de la plaga',
        );
      },
    );
  }
}

class _IdentificacionInsectos
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _IdentificacionInsectos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esIdentificacionInsectos.value,
            onChanged: (bool? valor) {
              controller.identificacionInsectos = valor!;
            },
          ),
        ),
        const Text('Identificación general de insectos',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _ExtraccionNematodos01
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ExtraccionNematodos01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esExtracion01.value,
            onChanged: (bool? valor) {
              controller.extracion01 = valor!;
            },
          ),
        ),
        const Text('Extracción de nemátodos (PEE/N/01)',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _ExtraccionNematodos02
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ExtraccionNematodos02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esExtracion02.value,
            onChanged: (bool? valor) {
              controller.extracion02 = valor!;
            },
          ),
        ),
        const Text('Extracción de nemátodos (PEE/N/02)',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _ExtraccionNematodos03
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ExtraccionNematodos03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esExtracion03.value,
            onChanged: (bool? valor) {
              controller.extracion03 = valor!;
            },
          ),
        ),
        const Text('Extracción de nemátodos (PEE/N/03)',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _ExtraccionNematodos06
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ExtraccionNematodos06({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esExtracion06.value,
            onChanged: (bool? valor) {
              controller.extracion06 = valor!;
            },
          ),
        ),
        const Text('Extracción de nemátodos (PEE/N/06)',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _ExtraccionNematodos09
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ExtraccionNematodos09({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esExtracion09.value,
            onChanged: (bool? valor) {
              controller.extracion09 = valor!;
            },
          ),
        ),
        const Text('Extracción de nemátodos (PEE/N/09)',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _ExtraccionNematodos12
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ExtraccionNematodos12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esExtracion12.value,
            onChanged: (bool? valor) {
              controller.extracion12 = valor!;
            },
          ),
        ),
        const Text('Extracción de nemátodos (PEE/N/12)',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _ExtraccionNematodos14
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _ExtraccionNematodos14({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esExtracion14.value,
            onChanged: (bool? valor) {
              controller.extracion14 = valor!;
            },
          ),
        ),
        const Text('Extracción de nemátodos (PEE/N/14)',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _IdentificacionBacteriana
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _IdentificacionBacteriana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esIdentificacionBacterias.value,
            onChanged: (bool? valor) {
              controller.identificacionBacterias = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Identificación de bacterias fitopatógenas hasta especie (PEE/FP/01)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _IdentificacionHongos
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _IdentificacionHongos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            value: controller.esIdentificacionHongos.value,
            onChanged: (bool? valor) {
              controller.identificacionHongos = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Identificación de hongos fitopatógenos hasta especie (PEE/FP/10)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _IdentificacionVirus
    extends GetView<EmbalajeLaboratorioControlSvController> {
  const _IdentificacionVirus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            value: controller.esDiagnostico.value,
            onChanged: (bool? valor) {
              controller.diagnostico = valor!;
            },
          ),
        ),
        SizedBox(
          width: orientacion.index == 0
              ? anchoPantalla * 0.75
              : anchoPantalla * 0.75,
          child: const Text(
            'Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)',
            style: EstilosTextos.radioYcheckbox,
          ),
        ),
      ],
    );
  }
}

class _MensajeModal extends GetView<EmbalajeLaboratorioControlSvController> {
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

class _IconoModal extends GetView<EmbalajeLaboratorioControlSvController> {
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
