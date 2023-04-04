import 'package:flutter/material.dart';

import 'package:agro_servicios/app/utils/info_inicial.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class InformacionInicial extends StatefulWidget {
  const InformacionInicial({super.key});
  @override
  State<StatefulWidget> createState() => _InformacionInicialState();
}

class _InformacionInicialState extends State<InformacionInicial> {
  int paginaActual = 0;
  bool animated = true;

  var listaPantallas = List<Pantallas>.empty();
  var textos = List<Texto>.empty();
  List<Texto> listTextos = List.empty();
  bool cargar = false;

  PageController? _pageController;

  cargarDatos() async {
    listaPantallas = await pantallas.cargarDatos();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargarDatos();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (valor) {
                    setState(() {
                      paginaActual = valor;
                      if (paginaActual == listaPantallas.length - 1) {
                        animated = false;
                      } else if (paginaActual == listaPantallas.length - 2) {
                        animated = true;
                      }
                    });
                  },
                  itemCount: listaPantallas.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        listaPantallas[index].pantalla!,
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      const SizedBox(height: 20.0),
                      Image(
                        width: getProporcionAnchoPantalla(340.0),
                        image: AssetImage(listaPantallas[index].imagen!),
                      ),
                      SizedBox(
                        height: altoPantalla * 0.02,
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: listaPantallas[index].textos!.length,
                          itemBuilder: (context, index2) {
                            return Center(
                              child: Container(
                                width: getProporcionAnchoPantalla(340.0),
                                margin: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                    '${listaPantallas[index].textos![index2].texto}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          listaPantallas.length,
                          (index) => indicadoresPunto(index: index),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: getProporcionAlturaPantalla(45.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff09c273),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          child: AnimatedCrossFade(
                            duration: const Duration(milliseconds: 300),
                            firstCurve: Curves.easeIn,
                            firstChild: Text(
                              'Continuar',
                              style: TextStyle(
                                  fontSize: getProporcionAnchoPantalla(18),
                                  color: Colors.white),
                            ),
                            secondChild: Text(
                              'Ir a Inicio',
                              style: TextStyle(
                                  fontSize: getProporcionAnchoPantalla(18),
                                  color: Colors.white),
                            ),
                            crossFadeState: animated
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          ),
                          onPressed: () {
                            if (paginaActual <= listaPantallas.length - 2) {
                              paginaActual++;
                            }

                            if (!animated) {
                              Navigator.pushReplacementNamed(context, 'login');
                            }

                            if (paginaActual == listaPantallas.length - 1) {
                              animated = !animated;
                            }
                            if (_pageController!.hasClients) {
                              _pageController!.animateToPage(
                                paginaActual,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer indicadoresPunto({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      margin: const EdgeInsets.only(right: 5.0),
      height: 6,
      width: paginaActual == index ? 20 : 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: paginaActual == index ? const Color(0xff09c273) : Colors.grey),
    );
  }
}
