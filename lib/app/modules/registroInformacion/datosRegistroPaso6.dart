import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_foto.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/registroInformacion/controllers/registroInformacionController.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DatosRegistroPaso6 extends StatefulWidget {
  final controlador = Get.find<RegistroInformacionController>();
  DatosRegistroPaso6({Key? key}) : super(key: key);

  @override
  State<DatosRegistroPaso6> createState() => _DatosRegistroState();
}

class _DatosRegistroState extends State<DatosRegistroPaso6>
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
                etiqueta: 'Acciones Tomadas',
              ),
              _buildAcciones(),
              _buildObservaciones(),
              _buildCargarImagenes(),
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
            Navigator.pushReplacementNamed(context, 'datosContaminante'),
      ),
    );
  }

  Widget _buildAcciones() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.accionesTomadasTextController,
      label: 'Acciones Tomadas',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setAccionesTomadas = valor,
    );
  }

  Widget _buildObservaciones() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.observacionesTextController,
      label: 'Observaciones',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setObservaciones = valor,
    );
  }

  Widget _buildCargarImagenes() {
    return BotonFoto(onPress: (valor) => {});
  }

  BotonPlano _buildBotonContinuar() {
    final controlador = Get.find<RegistroInformacionController>();
    return BotonPlano(
      texto: 'Guardar',
      color: Color(0XFF1ABC9C),
      funcion: () async {
        bool valido = controlador.validarFormulario();
        if (valido) {
          print("Guardando.!");
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
      icono: Icon(Icons.save, color: Colors.white, size: 20),
    );
  }
}
