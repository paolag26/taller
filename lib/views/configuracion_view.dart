import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/views/erp_card.dart';
import 'package:sist_prestamo/provider/configuracion_provider.dart';
import 'package:sist_prestamo/controllers/configuracion_controller.dart';

class ConfiguracionView extends StatefulWidget {
  const ConfiguracionView({super.key});

  @override
  State<ConfiguracionView> createState() => _ConfiguracionViewState();
}

class _ConfiguracionViewState extends State<ConfiguracionView>
    with SingleTickerProviderStateMixin {
  final controller = ConfiguracionProvider().controller;
  late final TabController tabController;

  static const tipoPrestamoConfig = CatalogoConfig(
    titulo: 'Tipos de prestamo',
    tabla: 'tipo_prestamo',
    idColumn: 'id_tipo',
    icon: Icons.account_balance_wallet,
    tieneDescripcion: true,
  );

  static const estadoPrestamoConfig = CatalogoConfig(
    titulo: 'Estados de prestamo',
    tabla: 'estado_prestamo',
    idColumn: 'id_estado',
    icon: Icons.flag,
    tieneDescripcion: true,
  );

  static const conceptoGastoConfig = CatalogoConfig(
    titulo: 'Conceptos de gasto',
    tabla: 'concepto_gasto',
    idColumn: 'id_concepto',
    icon: Icons.receipt_long,
    tieneDescripcion: true,
  );

  static const rolConfig = CatalogoConfig(
    titulo: 'Roles de usuario',
    tabla: 'rol',
    idColumn: 'id_rol',
    icon: Icons.admin_panel_settings,
    tieneDescripcion: true,
  );

  static const monedaConfig = CatalogoConfig(
    titulo: 'Monedas',
    tabla: 'moneda',
    idColumn: 'id_moneda',
    icon: Icons.payments,
    tieneDescripcion: true,
    tieneActivo: true,
  );

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    controller.cargarConfiguracion();
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.loading) {
          return const LoadingWidget();
        }

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Configuracion',
                subtitle: 'Catalogos, roles, monedas y seguridad del sistema.',
              ),
              const SizedBox(height: 16),
              if (controller.error != null) ...[
                _ErrorBox(message: controller.error!),
                const SizedBox(height: 16),
              ],
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xffe2e8f0)),
                ),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelColor: const Color(0xff14532d),
                  unselectedLabelColor: const Color(0xff64748b),
                  indicatorColor: const Color(0xff14532d),
                  tabs: const [
                    Tab(icon: Icon(Icons.tune), text: 'Catalogos'),
                    Tab(icon: Icon(Icons.group), text: 'Roles'),
                    Tab(icon: Icon(Icons.payments), text: 'Moneda'),
                    Tab(icon: Icon(Icons.security), text: 'Seguridad'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _CatalogosTab(
                      controller: controller,
                      sections: [
                        _CatalogoSectionData(
                          config: tipoPrestamoConfig,
                          items: controller.tiposPrestamo,
                        ),
                        _CatalogoSectionData(
                          config: estadoPrestamoConfig,
                          items: controller.estadosPrestamo,
                        ),
                        _CatalogoSectionData(
                          config: conceptoGastoConfig,
                          items: controller.conceptosGasto,
                          emptyMessage:
                              'No hay conceptos de gasto registrados o falta la tabla concepto_gasto',
                        ),
                      ],
                    ),
                    _CatalogosTab(
                      controller: controller,
                      sections: [
                        _CatalogoSectionData(
                          config: rolConfig,
                          items: controller.roles,
                          emptyMessage:
                              'No hay roles cargados. Revise el error real de Base local arriba.',
                        ),
                      ],
                    ),
                    _MonedaTab(
                      controller: controller,
                      config: monedaConfig,
                      monedas: controller.monedas,
                    ),
                    _SeguridadTab(controller: controller),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;

  const _ErrorBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfffff1f2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xfffecdd3)),
      ),
      child: Text(message, style: const TextStyle(color: Color(0xffbe123c))),
    );
  }
}

class _CatalogosTab extends StatelessWidget {
  final ConfiguracionController controller;
  final List<_CatalogoSectionData> sections;

  const _CatalogosTab({required this.controller, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: sections.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final section = sections[index];

        return _CatalogoPanel(
          controller: controller,
          config: section.config,
          items: section.items,
          emptyMessage: section.emptyMessage,
        );
      },
    );
  }
}

class _MonedaTab extends StatelessWidget {
  final ConfiguracionController controller;
  final CatalogoConfig config;
  final List<Map<String, dynamic>> monedas;

  const _MonedaTab({
    required this.controller,
    required this.config,
    required this.monedas,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _CatalogoPanel(
          controller: controller,
          config: config,
          items: monedas,
          emptyMessage: 'No hay monedas cargadas o falta la tabla moneda',
        ),
        const SizedBox(height: 16),
        _InfoPanel(
          icon: Icons.currency_exchange,
          title: 'Tipo de cambio',
          body:
              'Para manejar tipo de cambio historico conviene crear una tabla tipo_cambio con moneda_origen, moneda_destino, valor y fecha. Asi no se pierde el valor usado en pagos y reportes antiguos.',
        ),
      ],
    );
  }
}

class _SeguridadTab extends StatefulWidget {
  final ConfiguracionController controller;

  const _SeguridadTab({required this.controller});

  @override
  State<_SeguridadTab> createState() => _SeguridadTabState();
}

class _SeguridadTabState extends State<_SeguridadTab> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool saving = false;
  bool get puedeGuardar {
    return _validarPassword(passwordController.text) == null &&
        passwordController.text == confirmPasswordController.text;
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> cambiarPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      saving = true;
    });

    try {
      await widget.controller.cambiarPassword(passwordController.text.trim());

      if (!mounted) return;
      passwordController.clear();
      confirmPasswordController.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Contrasena actualizada')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo cambiar la contrasena: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ErpCard(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () => setState(() {}),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cambiar contrasena',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: _validarPassword,
                    decoration: const InputDecoration(
                      labelText: 'Nueva contrasena',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Las contrasenas no coinciden';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Confirmar contrasena',
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: saving || !puedeGuardar ? null : cambiarPassword,
                  icon: const Icon(Icons.lock_reset),
                  label: Text(saving ? 'Guardando...' : 'Cambiar contrasena'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const _InfoPanel(
          icon: Icons.shield,
          title: 'Politicas de seguridad',
          body:
              'Aqui se pueden agregar proximamente reglas como bloqueo por intentos fallidos, duracion de sesion, doble verificacion y permisos por rol.',
        ),
      ],
    );
  }

  String? _validarPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo requerido';
    }

    if (value.trim().length < 6) {
      return 'Use al menos 6 caracteres';
    }

    return null;
  }
}

class _CatalogoPanel extends StatelessWidget {
  final ConfiguracionController controller;
  final CatalogoConfig config;
  final List<Map<String, dynamic>> items;
  final String? emptyMessage;

  const _CatalogoPanel({
    required this.controller,
    required this.config,
    required this.items,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(config.icon, color: const Color(0xff14532d)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  config.titulo,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _abrirDialogoCatalogo(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                emptyMessage ?? 'No hay registros',
                style: const TextStyle(color: Color(0xff64748b)),
              ),
            )
          else if (config.tabla == 'rol')
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: items.map((item) {
                return SizedBox(
                  width: 260,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xfff8fafc),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xffe2e8f0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xffe8f5ec),
                              child: Text(
                                item['id_rol']?.toString() ?? '',
                                style: const TextStyle(
                                  color: Color(0xff14532d),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item['nombre']?.toString() ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['descripcion']?.toString().isNotEmpty == true
                              ? item['descripcion'].toString()
                              : 'Sin descripcion',
                          style: const TextStyle(color: Color(0xff64748b)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = items[index];

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: config.tabla == 'rol'
                      ? CircleAvatar(
                          backgroundColor: const Color(0xffe8f5ec),
                          child: Text(
                            item[config.idColumn]?.toString() ?? '',
                            style: const TextStyle(
                              color: Color(0xff14532d),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      : null,
                  title: Text(
                    config.tabla == 'rol'
                        ? 'Nombre: ${item['nombre'] ?? ''}'
                        : item['nombre']?.toString() ?? '',
                  ),
                  subtitle: config.tieneDescripcion
                      ? Text(
                          config.tabla == 'rol'
                              ? 'Descripcion: ${item['descripcion'] ?? ''}'
                              : item['descripcion']?.toString() ?? '',
                        )
                      : null,
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      if (config.tieneActivo)
                        Switch(
                          value: item['activo'] != false,
                          onChanged: (value) {
                            controller.cambiarActivo(
                              config: config,
                              item: item,
                              activo: value,
                            );
                          },
                        ),
                      IconButton(
                        tooltip: 'Editar',
                        onPressed: () {
                          _abrirDialogoCatalogo(context, item: item);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        tooltip: 'Eliminar',
                        onPressed: () {
                          _confirmarEliminar(context, item);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _abrirDialogoCatalogo(
    BuildContext context, {
    Map<String, dynamic>? item,
  }) async {
    final nombreController = TextEditingController(
      text: item?['nombre']?.toString() ?? '',
    );
    final descripcionController = TextEditingController(
      text: item?['descripcion']?.toString() ?? '',
    );
    var activo = item?['activo'] != false;
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(item == null ? 'Agregar' : 'Editar'),
              content: SizedBox(
                width: 420,
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: () => setDialogState(() {}),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nombreController,
                        inputFormatters: AppValidators.lettersOnly,
                        validator: AppValidators.letters,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                      ),
                      if (config.tieneDescripcion) ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descripcionController,
                          inputFormatters: AppValidators.safeText,
                          validator: AppValidators.safeTextValidator,
                          minLines: 2,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Descripcion',
                          ),
                        ),
                      ],
                      if (config.tieneActivo) ...[
                        const SizedBox(height: 10),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Activo'),
                          value: activo,
                          onChanged: (value) {
                            setDialogState(() {
                              activo = value;
                            });
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed:
                      AppValidators.letters(nombreController.text) == null &&
                          AppValidators.safeTextValidator(
                                descripcionController.text,
                              ) ==
                              null
                      ? () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          try {
                            await controller.guardarCatalogo(
                              config: config,
                              id: item?[config.idColumn],
                              nombre: AppValidators.sanitizeText(
                                nombreController.text,
                              ),
                              descripcion: AppValidators.sanitizeText(
                                descripcionController.text,
                              ),
                              activo: activo,
                            );

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('No se pudo guardar: $e')),
                            );
                          }
                        }
                      : null,
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );

    nombreController.dispose();
    descripcionController.dispose();
  }

  Future<void> _confirmarEliminar(
    BuildContext context,
    Map<String, dynamic> item,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar registro'),
          content: Text('Se eliminara "${item['nombre']}".'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    try {
      await controller.eliminarCatalogo(config, item[config.idColumn]);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo eliminar: $e')));
    }
  }
}

class _InfoPanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InfoPanel({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xff14532d)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(body, style: const TextStyle(color: Color(0xff64748b))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CatalogoSectionData {
  final CatalogoConfig config;
  final List<Map<String, dynamic>> items;
  final String? emptyMessage;

  const _CatalogoSectionData({
    required this.config,
    required this.items,
    this.emptyMessage,
  });
}
