import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/widgets/preguntas.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso2_sv_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catologos_seguimiento_control_sv.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso1_sv_controller.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';

class SeguimientoCuarentenarioPaso2SvPage extends StatefulWidget {
  const SeguimientoCuarentenarioPaso2SvPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _SeguimientoCuarentenarioPaso2SvPageState();
}

class _SeguimientoCuarentenarioPaso2SvPageState
    extends State<SeguimientoCuarentenarioPaso2SvPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Datos de la Inspeción'),
        _NumeroSeguimientos(),
        _CantidadTotal(),
        _CantidadVigilada(),
        _Actividad(),
        _EtapaCultivo(),
        _MonitoreoPlagas(),
        _PresenciaPlagas(),
        _CantidadAfectada(),
        _Incidencia(),
        _Severidad(),
        _FasePlaga(),
        _FaseOrganoAfectado(),
        _DistrubicionPlaga(),
        _Poblacion(),
        _DescripcionSintomas(),
        Espaciador(alto: 30),
      ],
    );
  }
}

class _NumeroSeguimientos
    extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _NumeroSeguimientos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoDescripcionBorde(
      etiqueta: 'Número de seguimientos planificados',
      valor: controller.solicitud!.numeroSeguimientosPlanificados.toString(),
    );
  }
}

class _CantidadTotal extends StatelessWidget {
  const _CantidadTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 8,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          errorText: _.errorCantidadTotal,
          onChanged: (valor) {
            _.cantidadTotal = valor;
          },
          label: 'Cantidad total',
        );
      },
    );
  }
}

class _CantidadVigilada extends StatelessWidget {
  const _CantidadVigilada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 8,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          errorText: _.errorCantidadVigilada,
          onChanged: (valor) {
            _.cantidadVigilada = valor;
          },
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          label: 'Cantidad vigilada',
        );
      },
    );
  }
}

class _Actividad extends StatelessWidget {
  const _Actividad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorActividad,
          items: CatalogosSeguimientoControlSv().getActvidadDropDown(),
          label: 'Actividad',
          onChanged: (valor) {
            _.actividad = valor;
          },
        );
      },
    );
  }
}

class _EtapaCultivo extends StatelessWidget {
  const _EtapaCultivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorEtapaCultivo,
          items: CatalogosSeguimientoControlSv().getEtapaCultivoDropDown(),
          label: 'Etapa de cultivo',
          onChanged: (valor) {
            _.etapaCultivo = valor;
          },
        );
      },
    );
  }
}

class _MonitoreoPlagas extends StatelessWidget {
  const _MonitoreoPlagas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 15),
        const Text('Posee registro de monitoreo de plagas',
            style: EstilosTextos.textoDescripcionCard),
        GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
          id: 'idCambioMonitoreo',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.cambioMonitoreoPlaga,
                  onChanged: (valor) => _.cambioMonitoreoPlaga = valor,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.cambioMonitoreoPlaga,
                  onChanged: (valor) => _.cambioMonitoreoPlaga = valor,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.sinCambioMonitoreo == true)
                  const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PresenciaPlagas extends StatelessWidget {
  const _PresenciaPlagas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 5),
        const Text('Presencia de plagas', style: EstilosTextos.etiquetasInputs),
        GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
          id: 'idCambioPresencia',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.cambioPresenciaPlaga,
                  onChanged: (valor) => _.cambioPresenciaPlaga = valor,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.cambioPresenciaPlaga,
                  onChanged: (valor) => _.cambioPresenciaPlaga = valor,
                ),
                const Text('No', style: EstilosTextos.etiquetasInputs),
                if (_.sinCambioPresencia == true)
                  const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CantidadAfectada extends StatelessWidget {
  const _CantidadAfectada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idInactivable',
      builder: (_) {
        return CampoTexto(
          controller: _.cantidadController,
          enable: _.camposActivos,
          maxLength: 8,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          errorText: _.errorCantidadAfectada,
          onChanged: (valor) {
            _.cantidadAfectada = valor;
          },
          label: 'Cantidad afectada',
        );
      },
    );
  }
}

class _Incidencia extends GetView<SeguimientoCuarentenarioPaso2SvController> {
  const _Incidencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CampoDescripcionBorde(
          valor: controller.incidencia.value.toString(),
          etiqueta: '% Incidencia',
        ));
  }
}

class _Severidad extends StatelessWidget {
  const _Severidad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idInactivable',
      builder: (_) {
        return CampoTexto(
          controller: _.severidadController,
          enable: _.camposActivos,
          keyboardType: TextInputType.number,
          maxLength: 10,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
          errorText: _.errorSeveridad,
          onChanged: (valor) {
            _.severidad = valor;
          },
          label: '% Severidad',
        );
      },
    );
  }
}

class _FasePlaga extends StatelessWidget {
  const _FasePlaga({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idInactivable',
      builder: (_) {
        return Combo(
          enabled: _.camposActivos,
          errorText: _.errorFasePlaga,
          value: _.faseDesarrolloPlaga,
          items: _.listaFase
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          label: 'Fase de desarrollo de plaga',
          onChanged: (valor) {
            _.faseDesarrolloPlaga = valor;
          },
        );
      },
    );
  }
}

class _FaseOrganoAfectado extends StatelessWidget {
  const _FaseOrganoAfectado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idInactivable',
      builder: (_) {
        return Combo(
          enabled: _.camposActivos,
          errorText: _.errorOrganoAfectado,
          items: _.listaOrganoAfectado
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          label: 'Órgano afectado en la planta',
          onChanged: (valor) {
            _.organoAfectado = valor;
          },
        );
      },
    );
  }
}

class _DistrubicionPlaga extends StatelessWidget {
  const _DistrubicionPlaga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idInactivable',
      builder: (_) {
        return Combo(
          enabled: _.camposActivos,
          errorText: _.errorDistribucionPlaga,
          // items: CatalogosSeguimientoControlSv().getDistribucionPlagaDropDown(),
          items: _.listaDistribucion
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          label: 'Distribución de la plaga',
          onChanged: (valor) {
            _.distribucionPlaga = valor;
          },
        );
      },
    );
  }
}

class _Poblacion extends StatelessWidget {
  const _Poblacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idInactivable',
      builder: (_) {
        return CampoTexto(
          controller: _.poblacionController,
          enable: _.camposActivos,
          maxLength: 250,
          errorText: _.errorPoblacion,
          keyboardType: TextInputType.number,
          onChanged: (valor) {
            _.poblacion = valor;
          },
          label: 'Población',
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
        );
      },
    );
  }
}

class _DescripcionSintomas extends StatelessWidget {
  const _DescripcionSintomas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso2SvController>(
      id: 'idInactivable',
      builder: (_) {
        return CampoTexto(
          controller: _.descripcionController,
          enable: _.camposActivos,
          maxLength: 250,
          errorText: _.errorDescripcionSintomas,
          onChanged: (valor) {
            _.descripcionSintomas = valor;
          },
          label: 'Descripción de síntomas',
        );
      },
    );
  }
}
