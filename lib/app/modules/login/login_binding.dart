import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/login/login_controlador.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  }
}
