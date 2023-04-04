import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_laboratorios_sv.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_productos_importados.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/widgets/preguntas.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_orden_controller.dart';

class ProductoImportadoIngresOrdenSv extends StatelessWidget {
  const ProductoImportadoIngresOrdenSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Orden de trabajo de laboratorio',
      widgets: const [
        _Producto(),
        _TipoCliente(),
        _TipoMuestra(),
        _ConservacionMuestra(),
        _ActividadOrigen(),
        _PesoMuestra(),
        _CodigoMuestra(),
        _PreDiagnostico(),
        _DescripcionSintomas(),
        _FaseFenologica(),
        NombreSeccion(etiqueta: 'Entomológico'),
        _Entomologico01(),
        _Entomologico02(),
        NombreSeccion(etiqueta: 'Nematológico'),
        _Nematodos01(),
        _Nematodos02(),
        _Nematodos03(),
        _Nematodos04(),
        _Nematodos05(),
        _Nematodos06(),
        _Nematodos07(),
        _Nematodos08(),
        _Nematodos09(),
        NombreSeccion(etiqueta: 'Fitopatológico'),
        _Fitopatologico01(),
        _Fitopatologico02(),
        _Fitopatologico03(),
        _Fitopatologico04(),
        _Fitopatologico05(),
        _Fitopatologico06(),
        _Fitopatologico07(),
        _Fitopatologico08(),
        Espaciador(alto: 15),
        _ErrorAnalisis(),
        Espaciador(alto: 15),
      ],
      botonFormulario: BotonPlano(
          texto: 'Guardar',
          color: Colores.accentColor,
          funcion: () async {
            bool esValido = Get.find<ProductosImportadosOrdenController>()
                .validarFormulario();
            if (esValido) {
              Get.find<ProductosImportadosOrdenController>().guardarFormulario(
                  titulo: ALMACENANDO,
                  icono: const _IconoModal(),
                  mensaje: const _MensajeModal());
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

class _Producto extends StatelessWidget {
  const _Producto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          onChanged: (valor) => _.producto = valor,
          label: 'Producto',
          items: _.productos
              .map((e) => DropdownMenuItem(
                    value: e.nombre,
                    child: Text(e.nombre!),
                  ))
              .toList(),
          errorText: _.errorProducto,
        );
      },
    );
  }
}

class _TipoCliente extends StatelessWidget {
  const _TipoCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          onChanged: (valor) => _.tipoCliente = valor,
          label: 'Tipo de Cliente',
          items: CatalogosProductosImportados().getTipoCliente(),
          errorText: _.errorTipoCliente,
        );
      },
    );
  }
}

class _TipoMuestra extends StatelessWidget {
  const _TipoMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          onChanged: (valor) => _.tipoMuestra = valor,
          label: 'Tipo de Muestra',
          items: CatalogosLaboratorios().getTipoMuestra(),
          errorText: _.errorTipoMuestra,
        );
      },
    );
  }
}

class _ConservacionMuestra extends StatelessWidget {
  const _ConservacionMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          onChanged: (valor) => _.conservacionMuestra = valor,
          label: 'Conservación de la Muestra',
          items: CatalogosLaboratorios().getConservacionMuestraDropDown(),
          errorText: _.errorConservacionMuestra,
        );
      },
    );
  }
}

class _ActividadOrigen extends StatelessWidget {
  const _ActividadOrigen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          onChanged: (valor) => _.actividadOrigen = valor,
          label: 'Actividad de origen',
          items: CatalogosProductosImportados().getActividadOrigen(),
          errorText: _.errorActividadOrigen,
        );
      },
    );
  }
}

class _PesoMuestra extends StatelessWidget {
  const _PesoMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          maxLength: 10,
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          onChanged: (valor) => _.peso = valor,
          label: 'Peso de la muestra',
          errorText: _.errorPesoMustra,
        );
      },
    );
  }
}

class _CodigoMuestra extends GetView<ProductosImportadosOrdenController> {
  const _CodigoMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CampoDescripcionBorde(
        etiqueta: 'Código de campo de la muestra',
        valor: controller.codigoMuestra.value));
  }
}

class _PreDiagnostico extends StatelessWidget {
  const _PreDiagnostico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 150,
          onChanged: (valor) => _.prediagnostico = valor,
          label: 'Pre-diagnóstico',
          errorText: _.errorPreDiagnostico,
        );
      },
    );
  }
}

class _DescripcionSintomas extends StatelessWidget {
  const _DescripcionSintomas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          onChanged: (valor) => _.descrpcion = valor,
          maxLength: 150,
          label: 'Descripción de síntomas o daños',
          errorText: _.errorDescripcion,
        );
      },
    );
  }
}

class _FaseFenologica extends StatelessWidget {
  const _FaseFenologica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosOrdenController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 50,
          onChanged: (valor) => _.faseFenologica = valor,
          label: 'Fase fenológica producto',
          errorText: _.errorFaseFenologica,
        );
      },
    );
  }
}

class _Entomologico01 extends GetView<ProductosImportadosOrdenController> {
  const _Entomologico01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esEntomologico01.value,
            onChanged: (bool? valor) {
              controller.entomologico01 = valor!;
            },
          ),
        ),
        const Text('Identificación general de insectos',
            style: EstilosTextos.radioYcheckbox),
      ],
    );
  }
}

class _Entomologico02 extends GetView<ProductosImportadosOrdenController> {
  const _Entomologico02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esEntomologico02.value,
            onChanged: (bool? valor) {
              controller.entomologico02 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Identificación de plagas de granos almacenados',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos01 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico01.value,
            onChanged: (bool? valor) {
              controller.nematologico01 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Extracción de Nemátodos (PEE/N/01)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos02 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico02.value,
            onChanged: (bool? valor) {
              controller.nematologico02 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Extracción de Nemátodos (PEE/N/02)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos03 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico03.value,
            onChanged: (bool? valor) {
              controller.nematologico03 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Extracción de Nemátodos (PEE/N/03)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos04 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos04({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico04.value,
            onChanged: (bool? valor) {
              controller.nematologico04 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Extracción de Nemátodos (PEE/N/06)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos05 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos05({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico05.value,
            onChanged: (bool? valor) {
              controller.nematologico05 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Extracción de Nemátodos (PEE/N/09)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos06 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos06({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico06.value,
            onChanged: (bool? valor) {
              controller.nematologico06 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Extracción de Nemátodos (PEE/N/12)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos07 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos07({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico07.value,
            onChanged: (bool? valor) {
              controller.nematologico07 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Extracción de Nemátodos (PEE/N/14)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos08 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos08({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico08.value,
            onChanged: (bool? valor) {
              controller.nematologico08 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Identificación a nivel de especie (PEE/N/07)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Nematodos09 extends GetView<ProductosImportadosOrdenController> {
  const _Nematodos09({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esNematologico09.value,
            onChanged: (bool? valor) {
              controller.nematologico09 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text('Identificación a nivel de especie (PEE/N/08)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Fitopatologico01 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico01.value,
            onChanged: (bool? valor) {
              controller.fitopatologico01 = valor!;
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

class _Fitopatologico02 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico02.value,
            onChanged: (bool? valor) {
              controller.fitopatologico02 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Aislamiento e identificación mediante pruebas bioquímicas y ELISA DAS de Ralstonia solanacearun (PEE/FP/03)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Fitopatologico03 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico03.value,
            onChanged: (bool? valor) {
              controller.fitopatologico03 = valor!;
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

class _Fitopatologico04 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico04({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico04.value,
            onChanged: (bool? valor) {
              controller.fitopatologico04 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de virus de mosaico de las brácteas del banano por ELISA DAS. (PEE/FP/02)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Fitopatologico05 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico05({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico05.value,
            onChanged: (bool? valor) {
              controller.fitopatologico05 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de banana streak virus – BSV (PEE/FP/04 (BSV))',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Fitopatologico06 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico06({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico06.value,
            onChanged: (bool? valor) {
              controller.fitopatologico06 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de cucumber mosaic virus CMV (PEE/FP/06)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Fitopatologico07 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico07({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico07.value,
            onChanged: (bool? valor) {
              controller.fitopatologico07 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de virus por el método de ELISA DAS (PEE/FP/11)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _Fitopatologico08 extends GetView<ProductosImportadosOrdenController> {
  const _Fitopatologico08({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.esFitopatologico08.value,
            onChanged: (bool? valor) {
              controller.fitopatologico08 = valor!;
            },
          ),
        ),
        SizedBox(
          width: anchoPantalla * 0.7,
          child: const Text(
              'Diagnóstico de virus por el método de ELISA DAS (PEE/FP/12) (CTV, BBTV, CyMV, PVY)',
              style: EstilosTextos.radioYcheckbox),
        ),
      ],
    );
  }
}

class _ErrorAnalisis extends GetView<ProductosImportadosOrdenController> {
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

class _MensajeModal extends GetView<ProductosImportadosOrdenController> {
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

class _IconoModal extends GetView<ProductosImportadosOrdenController> {
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
