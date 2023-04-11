import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_fecha.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/registroInformacion/controllers/registroInformacionController.dart';
import 'package:agro_servicios/app/utils/catalogos/catalalogos_registro_info.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DatosRegistroPaso4 extends StatefulWidget {
  final controlador = Get.find<RegistroInformacionController>();
  DatosRegistroPaso4({Key? key}) : super(key: key);

  @override
  State<DatosRegistroPaso4> createState() => _DatosRegistroState();
}

class _DatosRegistroState extends State<DatosRegistroPaso4>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Medidas().init(context);
    return GetBuilder<RegistroInformacionController>(
        builder: (_) => CuerpoFormularioIngreso(
            titulo: "Formulario Ingreso",
            widgets: [
              NombreSeccion(
                etiqueta: 'Datos de Muestra',
              ),
              _buildTipoMuestra(),
              _buildNumeroQuipux(),
              _buildCodigoMuestraLab(),
              _buildFechaRecepcion(),
              _buildFechaEmision(),
              _buildReferencia(),
              buildBotonRegresar(),
            ],
            botonFormulario: _buildBotonContinuar()));
  }

  Widget buildBotonRegresar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      height: 28,
      width: 28,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: CircleBorder(),
          backgroundColor: Colors.white,
        ),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
        onPressed: () =>
            Navigator.pushReplacementNamed(context, 'datosFronteraEntidad'),
      ),
    );
  }

  Widget _buildTipoMuestra() {
    final controlador = Get.find<RegistroInformacionController>();
    return GetBuilder<RegistroInformacionController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          selectedItem: controlador.registro.tipoMuestra,
          lista: CatalogoRegistroInfo().getTipoMuestraLista(),
          label: 'Tipo de Muestra',
          errorText: _.errorTipoMuestra,
          onChange: (valor) {
            _.setTipoMuestra = valor;
          },
        );
      },
    );
  }

  Widget _buildNumeroQuipux() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.numeroQuipuxTextController,
      label: 'Número de quipux de envío de la muestra al laboratorio',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setNumeroQuipux = valor,
    );
  }

  Widget _buildCodigoMuestraLab() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.codigoMuestraLabTextController,
      label: 'Código de muesta del laboratorio',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setCodigoMuestraLab = valor,
    );
  }

  Widget _buildFechaRecepcion() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoFecha(
      controller: controlador.fechaRecepcionTextController
        ..text =
            fechaFormateada('yyyy-MM-dd', controlador.registro.fechaRecepcion),
      label: 'Fecha de recepción de la muestra en el laboratorio',
      date: controlador.registro.fechaRecepcion,
      onChanged: (valor) =>
          {Get.find<RegistroInformacionController>().setFechaRecepcion = valor},
    );
  }

  Widget _buildFechaEmision() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoFecha(
      controller: controlador.fechaEmisionTextController
        ..text =
            fechaFormateada('yyyy-MM-dd', controlador.registro.fechaEmision),
      label: 'Fecha de emisión del informe en el laboratorio',
      date: controlador.registro.fechaEmision,
      onChanged: (valor) =>
          {Get.find<RegistroInformacionController>().setFechaEmision = valor},
    );
  }

  Widget _buildReferencia() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.referenciaTextController,
      label: 'Referencia',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setReferencia = valor,
    );
  }

  BotonPlano _buildBotonContinuar() {
    final controlador = Get.find<RegistroInformacionController>();
    return BotonPlano(
      texto: 'Continuar',
      color: Color(0XFF1ABC9C),
      funcion: () async {
        bool valido = controlador.validarFormulario();
        if (valido) {
          Navigator.pushReplacementNamed(context, 'datosContaminante');
        } else
          snackBarExterno(
            mensaje: SNACK_OBLIGATORIOS,
            context: Get.context!,
            elevation: 6,
            snackBarBehavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
          );
      },
      icono: Icon(Icons.arrow_forward, color: Colors.white, size: 20),
    );
  }
}
