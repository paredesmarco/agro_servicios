import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_paso1_sa_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_productos_importados.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/mensaje_error_radio_button.dart';

class ProductoImportadoPaso1Sa extends StatefulWidget {
  const ProductoImportadoPaso1Sa({Key? key}) : super(key: key);

  @override
  State<ProductoImportadoPaso1Sa> createState() =>
      _ProductoImportadoPaso1SaState();
}

class _ProductoImportadoPaso1SaState extends State<ProductoImportadoPaso1Sa>
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
        GetBuilder<ProductosImportadosPaso1SaController>(
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
              'Cantidad del producto pecuario es menor o igual al autorizado',
        ),
        GetBuilder<ProductosImportadosPaso1SaController>(
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

class _NumeroContenedoresEnvio extends StatelessWidget {
  const _NumeroContenedoresEnvio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso1SaController>(
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
    return GetBuilder<ProductosImportadosPaso1SaController>(
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
    return GetBuilder<ProductosImportadosPaso1SaController>(
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
    return GetBuilder<ProductosImportadosPaso1SaController>(
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
