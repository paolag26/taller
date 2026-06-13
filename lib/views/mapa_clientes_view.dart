import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sist_prestamo/views/empty_widget.dart';
import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/provider/mapa_provider.dart';

class MapaClientesView extends StatefulWidget {
  const MapaClientesView({super.key});

  @override
  State<MapaClientesView> createState() => _MapaClientesViewState();
}

class _MapaClientesViewState extends State<MapaClientesView> {
  final controller = MapaProvider().controller;
  final mapController = MapController();

  static const LatLng centroBolivia = LatLng(-16.5, -64.7);

  @override
  void initState() {
    super.initState();
    controller.cargarClientes();
  }

  @override
  void dispose() {
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

        final clientesConUbicacion = controller.clientesConUbicacion;
        final markers = _crearMarkers(clientesConUbicacion);

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mapa Clientes',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 900;

                    if (isNarrow) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _MapaPanel(
                              mapController: mapController,
                              markers: markers,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: _ClientesPanel(
                              clientesConUbicacion: clientesConUbicacion,
                              clientesSinUbicacion:
                                  controller.clientesSinUbicacion,
                              onClienteTap: _centrarCliente,
                              onRutaTap: _abrirRutaGoogleMaps,
                            ),
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _MapaPanel(
                            mapController: mapController,
                            markers: markers,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _ClientesPanel(
                            clientesConUbicacion: clientesConUbicacion,
                            clientesSinUbicacion:
                                controller.clientesSinUbicacion,
                            onClienteTap: _centrarCliente,
                            onRutaTap: _abrirRutaGoogleMaps,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Marker> _crearMarkers(List<Map<String, dynamic>> clientes) {
    return clientes.map((cliente) {
      final persona = cliente['persona'];
      final point = LatLng(
        _toDouble(persona?['latitud'])!,
        _toDouble(persona?['longitud'])!,
      );

      return Marker(
        point: point,
        width: 170,
        height: 78,
        child: GestureDetector(
          onTap: () {
            _centrarCliente(cliente);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 38),
              Container(
                constraints: const BoxConstraints(maxWidth: 160),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  _nombreCliente(cliente),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  void _centrarCliente(Map<String, dynamic> cliente) {
    final point = _puntoCliente(cliente);

    if (point == null) {
      return;
    }

    mapController.move(point, 16);
  }

  Future<void> _abrirRutaGoogleMaps(Map<String, dynamic> cliente) async {
    final point = _puntoCliente(cliente);

    if (point == null) {
      return;
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${point.latitude},${point.longitude}&travelmode=driving',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  LatLng? _puntoCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final latitud = _toDouble(persona?['latitud']);
    final longitud = _toDouble(persona?['longitud']);

    if (latitud == null || longitud == null) {
      return null;
    }

    return LatLng(latitud, longitud);
  }

  String _nombreCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final materno = persona?['apellido_materno'] ?? '';
    final nombreCompleto = '$nombres $paterno $materno'.trim();

    return nombreCompleto.isEmpty
        ? 'Cliente #${cliente['id_cliente']}'
        : nombreCompleto;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }
}

class _MapaPanel extends StatelessWidget {
  final MapController mapController;
  final List<Marker> markers;

  const _MapaPanel({required this.mapController, required this.markers});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FlutterMap(
        mapController: mapController,
        options: const MapOptions(
          initialCenter: _MapaClientesViewState.centroBolivia,
          initialZoom: 5.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.sist_prestamo',
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}

class _ClientesPanel extends StatelessWidget {
  final List<Map<String, dynamic>> clientesConUbicacion;
  final List<Map<String, dynamic>> clientesSinUbicacion;
  final ValueChanged<Map<String, dynamic>> onClienteTap;
  final ValueChanged<Map<String, dynamic>> onRutaTap;

  const _ClientesPanel({
    required this.clientesConUbicacion,
    required this.clientesSinUbicacion,
    required this.onClienteTap,
    required this.onRutaTap,
  });

  @override
  Widget build(BuildContext context) {
    if (clientesConUbicacion.isEmpty && clientesSinUbicacion.isEmpty) {
      return const EmptyWidget(message: 'No existen clientes');
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ubicaciones',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                if (clientesConUbicacion.isEmpty)
                  const ListTile(
                    leading: Icon(Icons.location_off),
                    title: Text('Sin ubicaciones registradas'),
                  ),
                ...clientesConUbicacion.map((cliente) {
                  final persona = cliente['persona'];

                  return ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.red),
                    title: Text(_nombreCliente(cliente)),
                    subtitle: Text(persona?['direccion_domicilio'] ?? ''),
                    onTap: () {
                      onClienteTap(cliente);
                    },
                    trailing: IconButton(
                      tooltip: 'Abrir ruta en Google Maps',
                      icon: const Icon(Icons.directions),
                      onPressed: () {
                        onRutaTap(cliente);
                      },
                    ),
                  );
                }),
                if (clientesSinUbicacion.isNotEmpty) ...[
                  const Divider(height: 28),
                  Text(
                    'Sin coordenadas (${clientesSinUbicacion.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...clientesSinUbicacion.map((cliente) {
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.location_off),
                      title: Text(_nombreCliente(cliente)),
                    );
                  }),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _nombreCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final materno = persona?['apellido_materno'] ?? '';
    final nombreCompleto = '$nombres $paterno $materno'.trim();

    return nombreCompleto.isEmpty
        ? 'Cliente #${cliente['id_cliente']}'
        : nombreCompleto;
  }
}
