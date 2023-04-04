import 'package:flutter/material.dart';

class PaginaDetalle extends StatelessWidget {
  const PaginaDetalle({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xff39675e)),
      ),
      body: const Center(
        child: Text('Disponible próximamente'),
      ),
    );
  }
}
