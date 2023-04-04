import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:flutter/material.dart';

class CuerpoFormularioTabPage extends StatelessWidget {
  const CuerpoFormularioTabPage({Key? key, this.children}) : super(key: key);
  final List<Widget>? children;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          const Espaciador(alto: 10),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                    left: anchoPantalla * 0.04, right: anchoPantalla * 0.04),
                child: Column(
                  children: children ?? [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
