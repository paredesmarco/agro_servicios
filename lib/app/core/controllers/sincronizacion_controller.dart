import 'package:agro_servicios/app/common/colores.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SincronizacionController extends GetxController {
  PageController pageController = PageController(keepPage: true);

  Color colorBajarDatos = const Color(0xFFFFFFFF);
  Color colorSubirDatos = Colores.primaryColor;

  double paginaActual = 0;

  int index = 0;

  @override
  void onInit() {
    pageController.addListener(() {
      paginaActual = pageController.page!;
      if (paginaActual <= 0.5 && index > 0) {
        if (index != 0) {
          index = 0;
          actualizarTabs();
        }
      } else if (paginaActual > 0.5) {
        if (index != 1) {
          index = 1;
          actualizarTabs();
        }
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void cambiarPagina(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void actualizarTabs() {
    if (colorBajarDatos == const Color(0xFFFFFFFF)) {
      colorBajarDatos = Colores.gradient2;
    } else {
      colorBajarDatos = const Color(0xFFFFFFFF);
    }

    if (colorSubirDatos == Colores.primaryColor) {
      colorSubirDatos = const Color(0xFFFFFFFF);
    } else {
      colorSubirDatos = Colores.primaryColor;
    }

    update();
  }
}
