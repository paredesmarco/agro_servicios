import 'package:flutter/material.dart';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class CuerpoFormularioTab extends StatelessWidget {
  final String titulo;
  final TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabsPages;
  final Widget? fab;
  final List<Widget>? menuAppBar;

  const CuerpoFormularioTab(
      {Key? key,
      required this.titulo,
      required this.tabController,
      required this.tabs,
      required this.tabsPages,
      this.fab,
      this.menuAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: fab,
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Colors.white.withOpacity(0.1),
        elevation: 0,
        actions: menuAppBar,
        bottom: TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.only(bottom: 5),
            labelPadding: const EdgeInsets.only(bottom: 5),
            indicatorColor: Colors.white,
            onTap: (index) {},
            tabs: tabs),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colores.gradient1, Colores.gradient2],
            // colors: [Color(0xFFF0099393), Color(0xFFF1f5971)],
          ),
        ),
        child: Column(
          children: [
            Espaciador(
              alto: MediaQuery.of(context).padding.top,
            ),
            const Espaciador(
              alto: 104,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: tabController,
                  children: tabsPages,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
