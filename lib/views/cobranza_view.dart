import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/empty_widget.dart';
import 'package:sist_prestamo/views/erp_card.dart';
import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/provider/pago_provider.dart';
import 'package:sist_prestamo/views/pago_form_dialog.dart';
import 'package:sist_prestamo/provider/cobranza_provider.dart';
import 'package:sist_prestamo/controllers/cobranza_controller.dart';

class CobranzaView extends StatefulWidget {
  const CobranzaView({super.key});

  @override
  State<CobranzaView> createState() => _CobranzaViewState();
}

class _CobranzaViewState extends State<CobranzaView>
    with SingleTickerProviderStateMixin {
  final controller = CobranzaProvider().controller;
  final pagoController = PagoProvider().controller;
  final mapController = MapController();
  final searchController = TextEditingController();
  final clienteSearchController = TextEditingController();
  late final TabController tabController;

  static const LatLng santaCruz = LatLng(-17.7833, -63.1821);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    controller.cargarCobranza();
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    clienteSearchController.dispose();
    controller.dispose();
    pagoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.loading) return const LoadingWidget();

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: 'Cobranza',
                subtitle:
                    'Gestion diaria de cuotas, mora, ubicaciones y recuperacion.',
                trailing: IconButton.filledTonal(
                  onPressed: controller.cargarCobranza,
                  tooltip: 'Actualizar',
                  icon: const Icon(Icons.refresh),
                ),
              ),
              if (controller.error != null) ...[
                const SizedBox(height: 12),
                _ErrorBox(message: controller.error!),
              ],
              const SizedBox(height: 16),
              _KpiWrap(controller: controller),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xffe2e8f0)),
                ),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  labelColor: const Color(0xff14532d),
                  unselectedLabelColor: const Color(0xff64748b),
                  indicatorColor: const Color(0xff14532d),
                  tabs: const [
                    Tab(icon: Icon(Icons.list_alt), text: 'Listado'),
                    Tab(icon: Icon(Icons.today), text: 'Cobranza del dia'),
                    Tab(icon: Icon(Icons.person_search), text: 'Por cliente'),
                    Tab(icon: Icon(Icons.map), text: 'Mapa / rutas'),
                    Tab(icon: Icon(Icons.bar_chart), text: 'Reportes'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _ListadoTab(
                      controller: controller,
                      searchController: searchController,
                      onPago: _registrarPago,
                      onRuta: _abrirRuta,
                    ),
                    _DiaTab(controller: controller, onPago: _registrarPago),
                    _ClienteTab(
                      controller: controller,
                      searchController: clienteSearchController,
                      onPago: _registrarPago,
                    ),
                    _MapaTab(
                      controller: controller,
                      mapController: mapController,
                      onRuta: _abrirRuta,
                      onRutaCompleta: _abrirRutaCompleta,
                    ),
                    _ReportesTab(controller: controller),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _registrarPago(Map<String, dynamic> cuota) async {
    await showDialog(
      context: context,
      builder: (context) {
        return PagoFormDialog(
          controller: pagoController,
          cuotaInicialId: cuota['id_cuota'],
        );
      },
    );

    await controller.cargarCobranza();
  }

  Future<void> _abrirRuta(Map<String, dynamic> cuota) async {
    final point = _puntoCuota(cuota);
    if (point == null) return;

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${point.latitude},${point.longitude}&travelmode=driving',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _abrirRutaCompleta(List<Map<String, dynamic>> cuotas) async {
    final puntos = cuotas.map(_puntoCuota).whereType<LatLng>().toList();
    if (puntos.isEmpty) return;

    final destination = puntos.last;
    final waypoints = puntos.length > 1
        ? puntos
              .take(puntos.length - 1)
              .map((point) => '${point.latitude},${point.longitude}')
              .join('|')
        : '';

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${destination.latitude},${destination.longitude}'
      '${waypoints.isEmpty ? '' : '&waypoints=$waypoints'}'
      '&travelmode=driving',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  LatLng? _puntoCuota(Map<String, dynamic> cuota) {
    final persona = cuota['prestamo']?['cliente']?['persona'];
    final latitud = _toDouble(persona?['latitud']);
    final longitud = _toDouble(persona?['longitud']);
    if (latitud == 0 || longitud == 0) return null;
    return LatLng(latitud, longitud);
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class _KpiWrap extends StatelessWidget {
  final CobranzaController controller;

  const _KpiWrap({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _KpiCard(
          title: 'A cobrar hoy',
          value: controller.money(controller.totalACobrarHoy),
          icon: Icons.today,
          color: const Color(0xff2563eb),
        ),
        _KpiCard(
          title: 'Cobrado hoy',
          value: controller.money(controller.totalCobradoHoy),
          icon: Icons.payments,
          color: const Color(0xff16a34a),
        ),
        _KpiCard(
          title: 'Pendiente hoy',
          value: controller.money(controller.totalPendienteHoy),
          icon: Icons.pending_actions,
          color: const Color(0xffd97706),
        ),
        _KpiCard(
          title: 'Clientes mora',
          value: '${controller.clientesEnMora}',
          icon: Icons.warning_amber,
          color: const Color(0xffdc2626),
        ),
        _KpiCard(
          title: 'Clientes al dia',
          value: '${controller.clientesAlDia}',
          icon: Icons.verified,
          color: const Color(0xff14532d),
        ),
        _KpiCard(
          title: 'Recuperacion',
          value:
              '${(controller.porcentajeRecuperacion * 100).toStringAsFixed(0)}%',
          icon: Icons.trending_up,
          color: const Color(0xff7c3aed),
        ),
      ],
    );
  }
}

class _ListadoTab extends StatelessWidget {
  final CobranzaController controller;
  final TextEditingController searchController;
  final ValueChanged<Map<String, dynamic>> onPago;
  final ValueChanged<Map<String, dynamic>> onRuta;

  const _ListadoTab({
    required this.controller,
    required this.searchController,
    required this.onPago,
    required this.onRuta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ErpCard(
          padding: const EdgeInsets.all(14),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 330,
                child: TextField(
                  controller: searchController,
                  inputFormatters: AppValidators.safeText,
                  onChanged: controller.cambiarBusqueda,
                  decoration: const InputDecoration(
                    labelText: 'Buscar por nombre, CI o telefono',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                width: 210,
                child: DropdownButtonFormField<String>(
                  initialValue: controller.filtro,
                  decoration: const InputDecoration(labelText: 'Filtro'),
                  items: const [
                    DropdownMenuItem(value: 'TODAS', child: Text('Todas')),
                    DropdownMenuItem(value: 'HOY', child: Text('Hoy')),
                    DropdownMenuItem(
                      value: 'PENDIENTE',
                      child: Text('Pendiente'),
                    ),
                    DropdownMenuItem(value: 'MORA', child: Text('Mora')),
                    DropdownMenuItem(
                      value: 'CON_UBICACION',
                      child: Text('Con ubicacion'),
                    ),
                    DropdownMenuItem(
                      value: 'SIN_UBICACION',
                      child: Text('Sin ubicacion'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) controller.cambiarFiltro(value);
                  },
                ),
              ),
              Text(
                'Total pendiente: ${controller.money(controller.totalPendienteGeneral)}',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: _CobranzaTable(
            cuotas: controller.cuotasFiltradas,
            controller: controller,
            onPago: onPago,
            onRuta: onRuta,
          ),
        ),
      ],
    );
  }
}

class _DiaTab extends StatelessWidget {
  final CobranzaController controller;
  final ValueChanged<Map<String, dynamic>> onPago;

  const _DiaTab({required this.controller, required this.onPago});

  @override
  Widget build(BuildContext context) {
    final cuotas = controller.cuotasDeHoy;

    return Column(
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _KpiCard(
              title: 'Esperado',
              value: controller.money(controller.totalACobrarHoy),
              icon: Icons.request_quote,
              color: const Color(0xff2563eb),
            ),
            _KpiCard(
              title: 'Clientes a visitar',
              value: '${controller.clientesAVisitarHoy}',
              icon: Icons.group,
              color: const Color(0xff14532d),
            ),
            _KpiCard(
              title: 'Cobrado',
              value: controller.money(controller.totalCobradoHoy),
              icon: Icons.check_circle,
              color: const Color(0xff16a34a),
            ),
            _KpiCard(
              title: 'Pendiente',
              value: controller.money(controller.totalPendienteHoy),
              icon: Icons.pending,
              color: const Color(0xffd97706),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Expanded(
          child: _CobranzaTable(
            cuotas: cuotas,
            controller: controller,
            onPago: onPago,
          ),
        ),
      ],
    );
  }
}

class _ClienteTab extends StatefulWidget {
  final CobranzaController controller;
  final TextEditingController searchController;
  final ValueChanged<Map<String, dynamic>> onPago;

  const _ClienteTab({
    required this.controller,
    required this.searchController,
    required this.onPago,
  });

  @override
  State<_ClienteTab> createState() => _ClienteTabState();
}

class _ClienteTabState extends State<_ClienteTab> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    final cuotas = widget.controller.buscarCuotasCliente(text);
    final cliente = cuotas.isEmpty
        ? null
        : cuotas.first['prestamo']?['cliente'];
    final pagos = cliente == null
        ? <Map<String, dynamic>>[]
        : widget.controller.pagosCliente(cliente['id_cliente']);

    return Column(
      children: [
        ErpCard(
          padding: const EdgeInsets.all(14),
          child: TextField(
            controller: widget.searchController,
            inputFormatters: AppValidators.safeText,
            onChanged: (value) => setState(() => text = value),
            decoration: const InputDecoration(
              labelText: 'Buscar cliente por nombre, CI o telefono',
              prefixIcon: Icon(Icons.person_search),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: text.trim().isEmpty
              ? const EmptyWidget(
                  message: 'Busque un cliente para ver su cobranza',
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final twoColumns = constraints.maxWidth > 900;
                    final left = _ClienteCuotasPanel(
                      cuotas: cuotas,
                      controller: widget.controller,
                      onPago: widget.onPago,
                    );
                    final right = _PagosClientePanel(pagos: pagos);

                    if (!twoColumns) {
                      return ListView(
                        children: [
                          SizedBox(height: 360, child: left),
                          const SizedBox(height: 14),
                          SizedBox(height: 320, child: right),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(flex: 3, child: left),
                        const SizedBox(width: 14),
                        Expanded(flex: 2, child: right),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _MapaTab extends StatelessWidget {
  final CobranzaController controller;
  final MapController mapController;
  final ValueChanged<Map<String, dynamic>> onRuta;
  final ValueChanged<List<Map<String, dynamic>>> onRutaCompleta;

  const _MapaTab({
    required this.controller,
    required this.mapController,
    required this.onRuta,
    required this.onRutaCompleta,
  });

  @override
  Widget build(BuildContext context) {
    final clientes = controller.clientesConUbicacionConsolidados;
    final cuotasRuta = clientes
        .map((item) => item['cuota_representativa'])
        .whereType<Map<String, dynamic>>()
        .toList();
    final markers = clientes.map((item) {
      final cuota = item['cuota_representativa'] as Map<String, dynamic>;
      final persona = cuota['prestamo']?['cliente']?['persona'];
      final point = LatLng(
        _toDouble(persona?['latitud']),
        _toDouble(persona?['longitud']),
      );
      final color = _estadoColor(controller.estadoCuota(cuota));

      return Marker(
        point: point,
        width: 180,
        height: 82,
        child: GestureDetector(
          onTap: () => mapController.move(point, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, color: color, size: 38),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Text(
                  controller.nombreClienteConsolidado(item),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Column(
      children: [
        ErpCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${clientes.length} clientes con ubicacion para ruta de cobranza',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              ElevatedButton.icon(
                onPressed: cuotasRuta.isEmpty
                    ? null
                    : () => onRutaCompleta(cuotasRuta),
                icon: const Icon(Icons.route),
                label: const Text('Abrir ruta completa'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final twoColumns = constraints.maxWidth > 920;
              final map = ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: FlutterMap(
                  mapController: mapController,
                  options: const MapOptions(
                    initialCenter: _CobranzaViewState.santaCruz,
                    initialZoom: 12,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.cuentasclaras.app',
                    ),
                    MarkerLayer(markers: markers),
                  ],
                ),
              );

              final list = _UbicacionesList(
                clientes: clientes,
                controller: controller,
                onRuta: onRuta,
              );

              if (!twoColumns) {
                return Column(
                  children: [
                    Expanded(child: map),
                    const SizedBox(height: 14),
                    Expanded(child: list),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(flex: 3, child: map),
                  const SizedBox(width: 14),
                  Expanded(flex: 2, child: list),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class _ReportesTab extends StatelessWidget {
  final CobranzaController controller;

  const _ReportesTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final twoColumns = constraints.maxWidth > 900;
              final width = twoColumns
                  ? (constraints.maxWidth - 14) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  SizedBox(
                    width: width,
                    child: _BarsPanel(
                      title: 'Cobranza diaria',
                      data: controller.reporteDiario,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _BarsPanel(
                      title: 'Cobranza semanal',
                      data: controller.reporteSemanal,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _BarsPanel(
                      title: 'Cobranza mensual',
                      data: controller.reporteMensual,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _AtrasoPanel(controller: controller),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CobranzaTable extends StatelessWidget {
  final List<Map<String, dynamic>> cuotas;
  final CobranzaController controller;
  final ValueChanged<Map<String, dynamic>> onPago;
  final ValueChanged<Map<String, dynamic>>? onRuta;

  const _CobranzaTable({
    required this.cuotas,
    required this.controller,
    required this.onPago,
    this.onRuta,
  });

  @override
  Widget build(BuildContext context) {
    final prestamos = controller.prestamosDesdeCuotas(cuotas);
    if (prestamos.isEmpty) {
      return const EmptyWidget(message: 'No hay prestamos para cobranza');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _CobranzaCards(
            prestamos: prestamos,
            controller: controller,
            onPago: onPago,
            onRuta: onRuta,
          );
        }

        return _CobranzaDesktopTable(
          prestamos: prestamos,
          controller: controller,
          onPago: onPago,
          onRuta: onRuta,
        );
      },
    );
  }
}

class _CobranzaDesktopTable extends StatelessWidget {
  final List<Map<String, dynamic>> prestamos;
  final CobranzaController controller;
  final ValueChanged<Map<String, dynamic>> onPago;
  final ValueChanged<Map<String, dynamic>>? onRuta;

  const _CobranzaDesktopTable({
    required this.prestamos,
    required this.controller,
    required this.onPago,
    this.onRuta,
  });

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      padding: const EdgeInsets.all(14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xfff8fafc)),
          columns: const [
            DataColumn(label: Text('Cliente')),
            DataColumn(label: Text('CI')),
            DataColumn(label: Text('Telefono')),
            DataColumn(label: Text('Direccion')),
            DataColumn(label: Text('Prestamo')),
            DataColumn(label: Text('Estado')),
            DataColumn(label: Text('Saldo pendiente')),
            DataColumn(label: Text('Cuotas pendientes')),
            DataColumn(label: Text('Cuotas mora')),
            DataColumn(label: Text('Ultimo pago')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: prestamos.map((item) {
            final prestamo = item['prestamo'];
            final cliente = prestamo?['cliente'];
            final persona = cliente?['persona'];
            final proximaCuota = controller.proximaCuotaPrestamo(item);
            final ultimoPago = controller.ultimoPagoPrestamo(item);

            return DataRow(
              cells: [
                DataCell(Text(_nombreClientePrestamo(item))),
                DataCell(Text(cliente?['ci_persona']?.toString() ?? '')),
                DataCell(Text(persona?['telefono']?.toString() ?? '')),
                DataCell(
                  SizedBox(
                    width: 190,
                    child: Text(
                      persona?['direccion_domicilio']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(Text('#${item['id_prestamo'] ?? ''}')),
                DataCell(
                  StatusChip.fromText(controller.estadoPrestamoCobranza(item)),
                ),
                DataCell(
                  Text(
                    controller.money(controller.saldoPendientePrestamo(item)),
                  ),
                ),
                DataCell(Text('${controller.cuotasPendientesPrestamo(item)}')),
                DataCell(Text('${controller.cuotasMoraPrestamo(item)}')),
                DataCell(
                  Text(
                    ultimoPago == null
                        ? '-'
                        : '${ultimoPago['fecha_pago'] ?? ''} / ${controller.money(ultimoPago['monto'])}',
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Registrar cobro',
                        onPressed: proximaCuota == null
                            ? null
                            : () => onPago(proximaCuota),
                        icon: const Icon(Icons.payments_outlined),
                      ),
                      IconButton(
                        tooltip: 'Abrir ubicacion',
                        onPressed:
                            onRuta == null ||
                                proximaCuota == null ||
                                !controller.tieneUbicacion(proximaCuota)
                            ? null
                            : () => onRuta!(proximaCuota),
                        icon: const Icon(Icons.map_outlined),
                      ),
                      IconButton(
                        tooltip: 'Ver detalle',
                        onPressed: () => _mostrarDetallePrestamo(context, item),
                        icon: const Icon(Icons.visibility_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _nombreClientePrestamo(Map<String, dynamic> item) {
    final cuota = controller.proximaCuotaPrestamo(item);
    if (cuota != null) return controller.nombreCliente(cuota);
    final persona = item['prestamo']?['cliente']?['persona'];
    final nombre =
        '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''}'
            .trim();
    return nombre.isEmpty ? 'Cliente sin nombre' : nombre;
  }

  void _mostrarDetallePrestamo(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final cuotas = controller.cuotasPrestamoItem(item);
        return AlertDialog(
          title: Text('Cuotas prestamo #${item['id_prestamo'] ?? ''}'),
          content: SizedBox(
            width: 720,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: cuotas.map((cuota) {
                  return ListTile(
                    dense: true,
                    title: Text('Cuota ${cuota['numero_cuota'] ?? ''}'),
                    subtitle: Text(
                      'Vence ${cuota['fecha_vencimiento'] ?? '-'} - ${controller.estadoCuota(cuota)}',
                    ),
                    trailing: Text(
                      controller.money(controller.montoCuota(cuota)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class _CobranzaCards extends StatelessWidget {
  final List<Map<String, dynamic>> prestamos;
  final CobranzaController controller;
  final ValueChanged<Map<String, dynamic>> onPago;
  final ValueChanged<Map<String, dynamic>>? onRuta;

  const _CobranzaCards({
    required this.prestamos,
    required this.controller,
    required this.onPago,
    this.onRuta,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: prestamos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = prestamos[index];
        final cuota = controller.proximaCuotaPrestamo(item);
        final prestamo = item['prestamo'];
        final cliente = prestamo?['cliente'];
        final persona = cliente?['persona'];
        final estado = controller.estadoPrestamoCobranza(item);

        return ErpCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      cuota == null
                          ? 'Prestamo #${item['id_prestamo'] ?? ''}'
                          : controller.nombreCliente(cuota),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  StatusChip.fromText(estado),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'pago':
                          if (cuota != null) onPago(cuota);
                        case 'ruta':
                          if (onRuta != null &&
                              cuota != null &&
                              controller.tieneUbicacion(cuota)) {
                            onRuta!(cuota);
                          }
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'pago',
                        child: Text('Registrar pago'),
                      ),
                      if (onRuta != null &&
                          cuota != null &&
                          controller.tieneUbicacion(cuota))
                        const PopupMenuItem(
                          value: 'ruta',
                          child: Text('Abrir ruta'),
                        ),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _CardField(
                label: 'Telefono',
                value: persona?['telefono']?.toString() ?? '',
              ),
              _CardField(
                label: 'Direccion',
                value: persona?['direccion_domicilio']?.toString() ?? '',
              ),
              _CardField(
                label: 'Pendiente',
                value: controller.money(
                  controller.saldoPendientePrestamo(item),
                ),
              ),
              _CardField(
                label: 'Cuotas',
                value:
                    '${controller.cuotasPendientesPrestamo(item)} pendientes / ${controller.cuotasMoraPrestamo(item)} mora',
              ),
              _CardField(
                label: 'Prestamo',
                value: '#${item['id_prestamo'] ?? ''}',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ClienteCuotasPanel extends StatelessWidget {
  final List<Map<String, dynamic>> cuotas;
  final CobranzaController controller;
  final ValueChanged<Map<String, dynamic>> onPago;

  const _ClienteCuotasPanel({
    required this.cuotas,
    required this.controller,
    required this.onPago,
  });

  @override
  Widget build(BuildContext context) {
    return _CobranzaTable(
      cuotas: cuotas,
      controller: controller,
      onPago: onPago,
    );
  }
}

class _PagosClientePanel extends StatelessWidget {
  final List<Map<String, dynamic>> pagos;

  const _PagosClientePanel({required this.pagos});

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Historial de pagos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: pagos.isEmpty
                ? const Center(child: Text('Sin pagos registrados'))
                : ListView.separated(
                    itemCount: pagos.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final pago = pagos[index];
                      final monto =
                          double.tryParse(pago['monto']?.toString() ?? '') ?? 0;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.payments),
                        title: Text('Bs ${monto.toStringAsFixed(2)}'),
                        subtitle: Text(
                          '${pago['fecha_pago'] ?? ''} - ${pago['tipo_pago'] ?? 'NORMAL'}',
                        ),
                        trailing: StatusChip.fromText(
                          pago['estado_pago']?.toString() ?? 'COMPLETO',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _UbicacionesList extends StatelessWidget {
  final List<Map<String, dynamic>> clientes;
  final CobranzaController controller;
  final ValueChanged<Map<String, dynamic>> onRuta;

  const _UbicacionesList({
    required this.clientes,
    required this.controller,
    required this.onRuta,
  });

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      child: ListView.separated(
        itemCount: clientes.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = clientes[index];
          final cuota = item['cuota_representativa'] as Map<String, dynamic>;
          final persona = cuota['prestamo']?['cliente']?['persona'];
          final cuotasCliente =
              item['cuotas'] as List<Map<String, dynamic>>? ?? [];
          final mora = item['cuotas_mora'] as int? ?? 0;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.location_on,
              color: _estadoColor(controller.estadoCuota(cuota)),
            ),
            title: Text(controller.nombreClienteConsolidado(item)),
            subtitle: Text(
              '${persona?['direccion_domicilio'] ?? ''}\n'
              '${cuotasCliente.length} cuotas - '
              '${controller.money(item['total_pendiente'] as double? ?? 0)}'
              '${mora > 0 ? ' - $mora en mora' : ''}',
            ),
            isThreeLine: true,
            trailing: IconButton(
              onPressed: () => onRuta(cuota),
              icon: const Icon(Icons.directions),
            ),
          );
        },
      ),
    );
  }
}

class _BarsPanel extends StatelessWidget {
  final String title;
  final Map<String, double> data;

  const _BarsPanel({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final max = data.values.fold<double>(0, (a, b) => b > a ? b : a);
    return ErpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          if (data.isEmpty)
            const Center(child: Text('Sin datos'))
          else
            ...data.entries.map((entry) {
              final value = max == 0 ? 0.0 : entry.value / max;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(entry.key)),
                        Text('Bs ${entry.value.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: value,
                        minHeight: 9,
                        backgroundColor: const Color(0xffeef2f7),
                        color: const Color(0xff14532d),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _AtrasoPanel extends StatelessWidget {
  final CobranzaController controller;

  const _AtrasoPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final clientes = controller.clientesConMasAtraso;
    return ErpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clientes con mas atraso',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          if (clientes.isEmpty)
            const Center(child: Text('Sin clientes en mora'))
          else
            ...clientes.map((item) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.warning_amber,
                  color: Color(0xffdc2626),
                ),
                title: Text(item['nombre']),
                subtitle: Text('${item['dias']} dias acumulados'),
                trailing: Text(
                  controller.money(item['saldo'] as double),
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffe2e8f0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xff64748b))),
                const SizedBox(height: 6),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardField extends StatelessWidget {
  final String label;
  final String value;

  const _CardField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 82,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xff64748b),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xfffecdd3)),
      ),
      child: Text(message, style: const TextStyle(color: Color(0xffbe123c))),
    );
  }
}

Color _estadoColor(String estado) {
  return switch (estado.toUpperCase()) {
    'PAGADO' || 'PAGADA' => const Color(0xff16a34a),
    'MORA' => const Color(0xffdc2626),
    _ => const Color(0xffd97706),
  };
}
