import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso1_sv_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_productos_importados.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/mensaje_error_radio_button.dart';

class ProductoImportadoPaso1Sv extends StatefulWidget {
  const ProductoImportadoPaso1Sv({Key? key}) : super(key: key);

  @override
  State<ProductoImportadoPaso1Sv> createState() =>
      _ProductoImportadoPaso1SvState();
}

class _ProductoImportadoPaso1SvState extends State<ProductoImportadoPaso1Sv>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Identidad e integridad del envío'),
        _DescripcionProducto(),
        _CantidadProducto(),
        NombreSeccion(etiqueta: 'Identidad del embalaje'),
        _NumeroEmbalajeEnvio(),
        _NumeroEmbalajeInspeccion(),
        _MarcaAutorizada(),
        _MarcaLegible(),
        _AusenciaDanios(),
        _AusenciaInsectosVivos(),
        _AusenciaCorteza(),
        _EmpaquesNuevos(),
        NombreSeccion(etiqueta: 'Datos del muestreo'),
        _NumeroContenedoresEnvio(),
        _NumeroContenedoresAforo(),
        _CriterioDivision(),
        _CategoriaRiesgo(),
        Espaciador(alto: 30),
      ],
    );
  }
}

class _DescripcionProducto extends StatelessWidget {
  const _DescripcionProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Descripción del Producto coincide con el producto físico',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idDescripcion',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.descripcionProducto,
                  onChanged: (valor) => _.descripcionProducto = valor,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.descripcionProducto,
                  onChanged: (valor) => _.descripcionProducto = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta01) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CantidadProducto extends StatelessWidget {
  const _CantidadProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta:
              'Cantidad del producto vegetal es menor o igual al autorizado',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idCantidad',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.cantidad,
                  onChanged: (valor) => _.cantidad = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.cantidad,
                  onChanged: (valor) => _.cantidad = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta02) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _NumeroEmbalajeEnvio extends StatelessWidget {
  const _NumeroEmbalajeEnvio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          label: 'Número de embalajes de envío',
          keyboardType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
          maxLength: 6,
          onChanged: (valor) => _.numeroEmbalajeEnvio = int.tryParse(valor),
          errorText: _.errorNumeroEmbalajeEnvio,
        );
      },
    );
  }
}

class _NumeroEmbalajeInspeccion extends StatelessWidget {
  const _NumeroEmbalajeInspeccion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          label: 'Número de embalajes de inspeccionados',
          keyboardType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
          maxLength: 6,
          onChanged: (valor) =>
              _.numeroEmbalajeInspeccion = int.tryParse(valor),
          errorText: _.errorNumeroEmbalajeInspeccion,
        );
      },
    );
  }
}

class _MarcaAutorizada extends StatelessWidget {
  const _MarcaAutorizada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Cuentan con la marca autorizada del país de origen',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idMarcaAutorizado',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.marcaAutorizada,
                  onChanged: (valor) => _.marcaAutorizada = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.marcaAutorizada,
                  onChanged: (valor) => _.marcaAutorizada = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'N/A',
                  groupValue: _.marcaAutorizada,
                  onChanged: (valor) => _.marcaAutorizada = valor!,
                ),
                const Text('N/A', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta03) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MarcaLegible extends StatelessWidget {
  const _MarcaLegible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'La marca es legible',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idMarcaLegible',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.marcaLegible,
                  onChanged: (valor) => _.marcaLegible = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.marcaLegible,
                  onChanged: (valor) => _.marcaLegible = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'N/A',
                  groupValue: _.marcaLegible,
                  onChanged: (valor) => _.marcaLegible = valor!,
                ),
                const Text('N/A', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta04) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AusenciaDanios extends StatelessWidget {
  const _AusenciaDanios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Ausencia de daños de insectos',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idDanioInsecto',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.danioInsecto,
                  onChanged: (valor) => _.danioInsecto = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.danioInsecto,
                  onChanged: (valor) => _.danioInsecto = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'N/A',
                  groupValue: _.danioInsecto,
                  onChanged: (valor) => _.danioInsecto = valor!,
                ),
                const Text('N/A', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta05) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AusenciaInsectosVivos extends StatelessWidget {
  const _AusenciaInsectosVivos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Ausencia de insectos vivos en los embalajes',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idInsectosVivos',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.insectosVivos,
                  onChanged: (valor) => _.insectosVivos = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.insectosVivos,
                  onChanged: (valor) => _.insectosVivos = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'N/A',
                  groupValue: _.insectosVivos,
                  onChanged: (valor) => _.insectosVivos = valor!,
                ),
                const Text('N/A', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta06) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AusenciaCorteza extends StatelessWidget {
  const _AusenciaCorteza({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Ausencia de corteza',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idCorteza',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.corteza,
                  onChanged: (valor) => _.corteza = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.corteza,
                  onChanged: (valor) => _.corteza = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'N/A',
                  groupValue: _.corteza,
                  onChanged: (valor) => _.corteza = valor!,
                ),
                const Text('N/A', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta07) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _EmpaquesNuevos extends StatelessWidget {
  const _EmpaquesNuevos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Empaques nuevos de primer uso',
        ),
        GetBuilder<ProductosImportadosPaso1SvController>(
          id: 'idEmpaques',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.empaques,
                  onChanged: (valor) => _.empaques = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.empaques,
                  onChanged: (valor) => _.empaques = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'N/A',
                  groupValue: _.empaques,
                  onChanged: (valor) => _.empaques = valor!,
                ),
                const Text('N/A', style: EstilosTextos.radioYcheckbox),
                if (_.errorPregunta08) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _NumeroContenedoresEnvio extends StatelessWidget {
  const _NumeroContenedoresEnvio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          label: 'No. De contenedores/vehículos del envío/pallets del envío',
          keyboardType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
          maxLength: 6,
          onChanged: (valor) => _.palletsEnvio = valor,
          errorText: _.errorPalletsEnvio,
        );
      },
    );
  }
}

class _NumeroContenedoresAforo extends StatelessWidget {
  const _NumeroContenedoresAforo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          label: 'No. De contenedores seleccionados para el aforo',
          keyboardType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
          maxLength: 6,
          onChanged: (valor) => _.contenedoresAforo = valor,
          errorText: _.errorContenedoresAforo,
        );
      },
    );
  }
}

class _CriterioDivision extends StatelessWidget {
  const _CriterioDivision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          items: CatalogosProductosImportados().getCriterioDivisionEspecie(),
          label: 'Criterio usado para la división de los envíos en lotes.',
          onChanged: (valor) => _.criterio = valor,
          errorText: _.errorCriterio,
        );
      },
    );
  }
}

class _CategoriaRiesgo extends StatelessWidget {
  const _CategoriaRiesgo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          items: CatalogosProductosImportados().getCategoriaRiesgo(),
          label: 'Categoría de Riesgo',
          onChanged: (valor) => _.categoriaRiesgo = valor,
          errorText: _.errorRiesgo,
        );
      },
    );
  }
}
