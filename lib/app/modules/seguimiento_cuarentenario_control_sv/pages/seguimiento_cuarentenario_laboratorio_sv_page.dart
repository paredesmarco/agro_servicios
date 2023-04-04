import 'package:agro_servicios/app/modules/embalaje_control_sv/widgets/preguntas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_laboratorio_sv_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_laboratorios_sv.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/utils/utils.dart';

class SeguimientoCuarentenarioLaboratorioSvPage extends StatelessWidget {
  const SeguimientoCuarentenarioLaboratorioSvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Orden de trabajo de laboratorio',
      widgets: const [
        _TipoMuestra(),
        _AplicacionQuimico(),
        _CodigoMuestra(),
        _Prediagnostico(),
        _DescripcionSintomas(),
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
        _FitopalogicoFp07(),
        _FitopalogicoFp05(),
        _FitopalogicoFp01(),
        _FitopalogicoFp03(),
        _FitopalogicoFp10(),
        _FitopalogicoFp02(),
        _FitopalogicoFp04(),
        _FitopalogicoFp06(),
        _FitopalogicoFp08(),
        _FitopalogicoFp11(),
        _FitopalogicoFp12(),
        _ErrorAnalisis(),
        Espaciador(alto: 20),
      ],
      botonFormulario: _botonFormulario(),
    );
  }

  Widget _botonFormulario() {
    return BotonPlano(
      texto: 'Guardar',
      color: Colores.accentColor,
      funcion: () async {
        bool esValido =
            Get.find<SeguimientoCuarentenarioLaboratorioSvController>()
                .validarFormulario();
        if (esValido) {
          Get.find<SeguimientoCuarentenarioLaboratorioSvController>()
              .guardarFormulario(
            titulo: ALMACENANDO,
            icono: const _IconoModal(),
            mensaje: const _MensajeModal(),
          );
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

class _TipoMuestra extends StatelessWidget {
  const _TipoMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioLaboratorioSvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorTipoMuestra,
          items: CatalogosLaboratorios().getTipoMuestra(),
          label: 'Tipo de muestra',
          onChanged: (valor) {
            _.tipoMuestra = valor;
          },
        );
      },
    );
  }
}

class _AplicacionQuimico extends StatelessWidget {
  const _AplicacionQuimico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioLaboratorioSvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorProductoQuimico,
          items: CatalogosLaboratorios().getProductoQuimicoDropDown(),
          label: 'Aplicación de producto químico',
          onChanged: (valor) {
            _.productoQuimico = valor;
          },
        );
      },
    );
  }
}

class _CodigoMuestra
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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

class _Prediagnostico extends StatelessWidget {
  const _Prediagnostico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioLaboratorioSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          errorText: _.errorPrediagnostico,
          maxLength: 150,
          onChanged: (valor) {
            _.prediagnostico = valor;
          },
          label: 'Prediagnóstico',
        );
      },
    );
  }
}

class _DescripcionSintomas extends StatelessWidget {
  const _DescripcionSintomas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioLaboratorioSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          errorText: _.errorDescripcionSintomas,
          maxLength: 150,
          onChanged: (valor) {
            _.descripcion = valor;
          },
          label: 'Descripción de síntomas o daños',
        );
      },
    );
  }
}

class _IdentificacionInsectos
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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

class _FitopalogicoFp07
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp07({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp07.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp07 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Identificación de Bacterias y Hongos fitopatógenos hasta genero (PEE/FP/07) Hongos',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp05
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp05({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp05.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp05 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Identificación de Bacterias y Hongos fitopatógenos hasta genero (PEE/FP/05) Bacterias',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp01
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp01.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp01 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Identificación de Bacterias fitopatógenos hasta especie (PEE/FP/01)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp03
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp03.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp03 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Aislamiento e identificación mediante pruebas bioquímicas y ELISA DAS de Ralstonia solanacearum (PEE/FP/03)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp10
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp10.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp10 = valor!;
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

class _FitopalogicoFp02
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp02.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp02 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de virus del mosaico de las brácteas del banano por ELISA DAS (PEE/FP/02)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp04
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp04({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp04.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp04 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de banana streak virus-BSV (PEE/FP/04(BSV))',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp06
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp06({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp06.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp06 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de cucumber mosaic virus – CMV (PEE/FP/06)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp08
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp08({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp08.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp08 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de los virus papaya mosaic y Alternathera Mosaic virus por ELISA DAS (PEE/FP/08)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp11
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp11.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp11 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _FitopalogicoFp12
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _FitopalogicoFp12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopalogicoFp12.value,
            onChanged: (bool? valor) {
              controller.fitopalogicoFp12 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de virus por el método de ELISA DAS (PEE/FP/12) (CTV BBTV CyMV PVY)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _ErrorAnalisis
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
  const _ErrorAnalisis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.errorAnalisis.value) {
        return const MensajeErrorRadioButton();
      }
      return Container();
    });
  }
}

class _MensajeModal
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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

class _IconoModal
    extends GetView<SeguimientoCuarentenarioLaboratorioSvController> {
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
