import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/bloc/bloc_aplicaciones.dart';
import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/modules/home/widgets/boton_modulo.dart';
import 'package:agro_servicios/app/core/widgets/menu_lateral.dart';
import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/common/comunes.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final u = context.read<LoginBloc>();
      final p = context.read<AplicacionesBloc>();

      final controler = Get.find<LoginController>();

      p.indexCoordinacion = 0;

      if (u.getOnline) {
        p.getAplicacionesOnline(
            controler.usuarioModelo!.identificador, u.getOnline);
      } else {
        p.getAplicacionesOffline();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    final usuarioProvider =
        Provider.of<AplicacionesBloc>(context, listen: false);

    return Scaffold(
      appBar: appbar(),
      drawer: MenuLateral(),
      body: Center(
        child: Column(
          children: [
            _buildNombreCoordinacion(context),
            const Espaciador(alto: 20),
            SizedBox(
              height: 135,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 1, bottom: 20),
                child: Row(
                  children: List.generate(
                    usuarioProvider.listaCoordinaciones.length,
                    (index) => Selector<AplicacionesBloc,
                        Tuple2<List<AreasModelo>, int>>(
                      selector: (_, provider) => Tuple2(
                          provider.listaCoordinaciones,
                          provider.indexCoordinacion),
                      builder: (_, data, __) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _BotonCoordinacion(
                            area: data.item1[index],
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Espaciador(alto: 20),
            _crearSeccionActividades(),
            const SizedBox(height: 15.0),
            Consumer<AplicacionesBloc>(builder: (_, provider, widget) {
              return Expanded(child: _crearMenu(context));
            }),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xff39675e)),
      elevation: 0,
      titleSpacing: 0.0,
      centerTitle: false,
      title: _buildNombreUsuario(context),
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      // actions: [
      //   Container(
      //     width: 40.0,
      //     child: Center(
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(20.0),
      //         child: Container(
      //           width: 40.0,
      //           height: 40.0,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(20.0),
      //             color: Colors.lightBlueAccent,
      //           ),
      //           child: Image(
      //             image: AssetImage('img/user1.jpg'),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   SizedBox(
      //     width: 16.0,
      //   ),
      // ],
    );
  }

  Widget _buildNombreUsuario(context) {
    final ctrLogin = Get.find<LoginController>();

    final List<String> nombre = ctrLogin.usuarioModelo!.nombre!.split(' ');
    return GetBuilder<LoginController>(
      id: 'idUsuario',
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Hola',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            Text(
              ' ${nombre[0]}',
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNombreCoordinacion(context) {
    final provider = Provider.of<AplicacionesBloc>(context, listen: false);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        provider.coordicacionSeleccionada,
        style: const TextStyle(fontSize: 18.0, color: Color(0xff39675e)),
        key: UniqueKey(),
      ),
    );
  }

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromBottom,
    descStyle: const TextStyle(fontSize: 14),
    descTextAlign: TextAlign.center,
    animationDuration: const Duration(milliseconds: 300),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
    alertAlignment: Alignment.center,
  );

  Widget _crearSeccionActividades() {
    return SizedBox(
      width: getProporcionAnchoPantalla(350),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Mis Actividades',
            style: TextStyle(fontSize: 18.0, color: Color(0xff39675e)),
          ),
          // Row(
          //   children: [
          //     Icon(Icons.view_list, color: Color(0XFFF17A589)),
          //     Icon(Icons.view_module, size: 26.5, color: Color(0XFFF17A589))
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _crearMenu(context) {
    final aplicacionesProvider = Provider.of<AplicacionesBloc>(context);

    return Consumer<AplicacionesBloc>(builder: (_, provider, widget) {
      if (!aplicacionesProvider.isLoading) {
        if (aplicacionesProvider.listaAplicaciones.isEmpty) {
          return const Center(
            child: Text('No tienes actividades asignadas'),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            key: UniqueKey(),
            child: DefaultTabController(
              length: aplicacionesProvider.listaAreas.length,
              child: Column(
                children: [
                  SizedBox(
                    width: getProporcionAnchoPantalla(350),
                    child: SizedBox(
                      height: 30.0,
                      child: TabBar(
                        physics: const BouncingScrollPhysics(),
                        labelColor: Colors.white,
                        isScrollable: true,
                        unselectedLabelColor: Colors.black54,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colores.primaryColor),
                        tabs: List.generate(
                          aplicacionesProvider.listaAreas.length,
                          (index) => Tab(
                            text: aplicacionesProvider
                                .listaAreas[index].nombreCorto,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _crearTabBarPaginas(context),
                ],
              ),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0XFF1ABC9C),
          ),
        );
      }
    });
  }

  Widget _crearTabBarPaginas(context) {
    final aplicacionesProvider = Provider.of<AplicacionesBloc>(context);

    return Expanded(
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        children:
            List.generate(aplicacionesProvider.listaAreas.length, (index) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: aplicacionesProvider.listaAplicaciones.length,
            itemBuilder: (context, index2) {
              if (aplicacionesProvider.listaAreas[index].idArea ==
                  aplicacionesProvider.listaAplicaciones[index2].idArea) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: BotonModulo(
                      aplicacion:
                          aplicacionesProvider.listaAplicaciones[index2],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        }),
      ),
    );
  }
}

class _BotonCoordinacion extends StatelessWidget {
  final AreasModelo area;

  final int index;

  const _BotonCoordinacion({Key? key, required this.area, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AplicacionesBloc>(context, listen: false);

    return Selector<AplicacionesBloc, int>(
        selector: (_, provider) => provider.indexCoordinacion,
        builder: (_, data, __) {
          Color color = Colors.white;
          String icono = '';
          switch (area.idArea) {
            case 'CGSV':
              color = Colors.orange;
              icono = ICONO_SV;
              break;
            case 'CGSA':
              color = Colors.green;
              icono = ICONO_SA;
              break;
          }
          return AnimatedContainer(
            height: area.seleccionado ? 120 : 100,
            width: provider.listaCoordinaciones.length > 1
                ? anchoPantalla * 0.4
                : anchoPantalla * 0.8,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(area.seleccionado ? 5.0 : 0.0,
                      area.seleccionado ? 5.0 : 0.0),
                  spreadRadius: 0.1,
                  blurRadius: 8,
                  color: const Color(0xff878686)
                      .withOpacity(area.seleccionado ? 0.3 : 0.1),
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 0, top: 12, right: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80,
                        width: 3,
                        color: color,
                      ),
                      const Espaciador(
                        ancho: 11,
                      ),
                      Expanded(
                        child: Text(
                          area.nombreCorto!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          width: 55,
                          height: 55,
                          child: SvgPicture.asset(
                            icono,
                            fit: BoxFit.cover,
                            color: color,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  provider.cambiarCoordinaciones(index);
                },
              ),
            ),
          );
        });
  }
}
