import 'package:flutter/material.dart';

import 'package:sist_prestamo/provider/layout_provider.dart';
import 'package:sist_prestamo/views/sidebar_widget.dart';
import 'package:sist_prestamo/views/topbar_widget.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final controller = LayoutProvider().controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool sidebarOpen = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleSidebar() {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 700) {
      scaffoldKey.currentState?.openDrawer();
      return;
    }

    setState(() {
      sidebarOpen = !sidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final effectiveSidebarOpen = constraints.maxWidth >= 1200
            ? true
            : sidebarOpen;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: const Color(0xfff4f7fb),
          drawer: isMobile
              ? Drawer(
                  width: 286,
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return SidebarWidget(
                        controller: controller,
                        isOpen: true,
                      );
                    },
                  ),
                )
              : null,
          body: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final content = Column(
                children: [
                  TopbarWidget(
                    title: controller.title,
                    onMenuPressed: toggleSidebar,
                    roleName: controller.roleName,
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: KeyedSubtree(
                        key: ValueKey(controller.title),
                        child: controller.currentView,
                      ),
                    ),
                  ),
                ],
              );

              if (isMobile) return content;

              return Row(
                children: [
                  SidebarWidget(
                    controller: controller,
                    isOpen: effectiveSidebarOpen,
                  ),
                  Expanded(child: content),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
