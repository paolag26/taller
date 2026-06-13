import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/app_feedback.dart';
import 'package:sist_prestamo/models/persona_model.dart';
import 'package:sist_prestamo/controllers/cliente_controller.dart';
import 'package:sist_prestamo/models/cliente_model.dart';

class ClienteFormDialog extends StatefulWidget {
  final ClienteController controller;
  final Map<String, dynamic>? cliente;

  const ClienteFormDialog({super.key, required this.controller, this.cliente});

  @override
  State<ClienteFormDialog> createState() => _ClienteFormDialogState();
}

class _ClienteFormDialogState extends State<ClienteFormDialog> {
  final formKey = GlobalKey<FormState>();

  final nombresController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final ciController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  final direccionDomicilioController = TextEditingController();
  final direccionTrabajoController = TextEditingController();
  final latitudController = TextEditingController();
  final longitudController = TextEditingController();
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();

  String estadoCredito = 'BUENO';
  String tipoUsuario = 'CLIENTE';
  bool saving = false;

  bool get isEditing => widget.cliente != null;
  bool get puedeGuardar {
    return AppValidators.letters(nombresController.text) == null &&
        AppValidators.letters(apellidoPaternoController.text) == null &&
        AppValidators.letters(
              apellidoMaternoController.text,
              required: false,
            ) ==
            null &&
        AppValidators.ci(ciController.text) == null &&
        AppValidators.phone(telefonoController.text) == null &&
        AppValidators.email(correoController.text) == null &&
        AppValidators.addressValidator(direccionDomicilioController.text) ==
            null &&
        AppValidators.addressValidator(direccionTrabajoController.text) ==
            null &&
        coordenada(latitudController.text) == null &&
        coordenada(longitudController.text) == null &&
        (isEditing ||
            (AppValidators.email(usuarioController.text, required: false) ==
                    null &&
                _validarPassword(passwordController.text) == null));
  }

  @override
  void initState() {
    super.initState();
    _cargarCliente();
  }

  void _cargarCliente() {
    final cliente = widget.cliente;
    if (cliente == null) return;

    final persona = cliente['persona'] as Map<String, dynamic>? ?? {};

    nombresController.text = persona['nombres']?.toString() ?? '';
    apellidoPaternoController.text =
        persona['apellido_paterno']?.toString() ?? '';
    apellidoMaternoController.text =
        persona['apellido_materno']?.toString() ?? '';
    ciController.text =
        cliente['ci_persona']?.toString() ??
        persona['ci_persona']?.toString() ??
        '';
    telefonoController.text = persona['telefono']?.toString() ?? '';
    correoController.text = persona['correo']?.toString() ?? '';
    direccionDomicilioController.text =
        persona['direccion_domicilio']?.toString() ?? '';
    direccionTrabajoController.text =
        persona['direccion_trabajo']?.toString() ?? '';
    latitudController.text = persona['latitud']?.toString() ?? '';
    longitudController.text = persona['longitud']?.toString() ?? '';
    estadoCredito = cliente['estado_credito']?.toString().isNotEmpty == true
        ? cliente['estado_credito'].toString()
        : 'BUENO';
  }

  @override
  void dispose() {
    nombresController.dispose();
    apellidoPaternoController.dispose();
    apellidoMaternoController.dispose();
    ciController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    direccionDomicilioController.dispose();
    direccionTrabajoController.dispose();
    latitudController.dispose();
    longitudController.dispose();
    usuarioController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> guardarCliente() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      saving = true;
    });

    final persona = PersonaModel(
      ciPersona: AppValidators.sanitizeInteger(ciController.text),
      nombres: AppValidators.sanitizeText(nombresController.text),
      apellidoPaterno: AppValidators.sanitizeText(
        apellidoPaternoController.text,
      ),
      apellidoMaterno: AppValidators.sanitizeText(
        apellidoMaternoController.text,
      ),
      telefono: AppValidators.sanitizeInteger(telefonoController.text),
      correo: AppValidators.sanitizeText(correoController.text),
      direccionDomicilio: AppValidators.sanitizeText(
        direccionDomicilioController.text,
      ),
      direccionTrabajo: AppValidators.sanitizeText(
        direccionTrabajoController.text,
      ),
      latitud: double.tryParse(latitudController.text.trim()),
      longitud: double.tryParse(longitudController.text.trim()),
    );

    final cliente = ClienteModel(
      idCliente: widget.cliente?['id_cliente'] ?? 0,
      ciPersona: AppValidators.sanitizeInteger(ciController.text),
      estadoCredito: estadoCredito,
      estado: widget.cliente?['estado'] ?? true,
    );

    try {
      if (isEditing) {
        await widget.controller.actualizarClienteConPersona(persona, cliente);
      } else {
        await widget.controller.insertarClienteConPersona(
          persona,
          cliente,
          tipoUsuario: tipoUsuario,
          username: AppValidators.sanitizeText(usuarioController.text),
          password: passwordController.text.trim(),
        );
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      AppSnackbarError.show(context, _mensajeErrorGuardar(e));
    } finally {
      if (mounted) {
        setState(() {
          saving = false;
        });
      }
    }
  }

  String? requerido(String? value) {
    return AppValidators.required(value);
  }

  String? coordenada(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    return AppValidators.signedDecimal(value);
  }

  String? _validarPassword(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    if (text.length < 6) return 'Minimo 6 caracteres';
    return null;
  }

  Future<void> seleccionarUbicacion() async {
    final initialPoint = LatLng(
      double.tryParse(latitudController.text.trim()) ?? -16.5,
      double.tryParse(longitudController.text.trim()) ?? -64.7,
    );
    var selectedPoint = initialPoint;

    final result = await showDialog<LatLng>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar ubicacion'),
          content: SizedBox(
            width: 620,
            height: 460,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return FlutterMap(
                  options: MapOptions(
                    initialCenter: selectedPoint,
                    initialZoom: selectedPoint == initialPoint ? 5.2 : 16,
                    onTap: (tapPosition, point) {
                      setDialogState(() {
                        selectedPoint = point;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.sist_prestamo',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: selectedPoint,
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 42,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
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
              onPressed: () {
                Navigator.pop(context, selectedPoint);
              },
              child: const Text('Usar ubicacion'),
            ),
          ],
        );
      },
    );

    if (result == null) {
      return;
    }

    setState(() {
      latitudController.text = result.latitude.toStringAsFixed(7);
      longitudController.text = result.longitude.toStringAsFixed(7);
    });
  }

  String _mensajeErrorGuardar(Object error) {
    final textoOriginal = error.toString().replaceFirst('Exception: ', '');
    final mensaje = textoOriginal.toLowerCase();

    if (mensaje.contains('duplicate') || mensaje.contains('duplic')) {
      return 'Ya existe un cliente registrado con ese CI';
    }

    if (mensaje.contains('ya existe un cliente')) {
      return 'Ya existe un cliente registrado con ese CI';
    }

    if (mensaje.contains('foreign key')) {
      return 'No se pudo guardar por una relacion invalida en la base local: $textoOriginal';
    }

    if (mensaje.contains('ci de persona') ||
        mensaje.contains('ci del cliente') ||
        mensaje.contains('persona es obligatorio') ||
        mensaje.contains('cliente es obligatorio')) {
      return textoOriginal;
    }

    return 'No se pudo guardar el cliente: $textoOriginal';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Editar Cliente' : 'Nuevo Cliente'),
      content: SizedBox(
        width: 500,
        child: AppLoadingOverlay(
          loading: saving,
          message: 'Guardando cliente...',
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: () => setState(() {}),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nombresController,
                    inputFormatters: AppValidators.lettersOnly,
                    validator: AppValidators.letters,
                    decoration: const InputDecoration(labelText: 'Nombres'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: apellidoPaternoController,
                    inputFormatters: AppValidators.lettersOnly,
                    validator: AppValidators.letters,
                    decoration: const InputDecoration(
                      labelText: 'Apellido paterno',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: apellidoMaternoController,
                    inputFormatters: AppValidators.lettersOnly,
                    validator: (value) =>
                        AppValidators.letters(value, required: false),
                    decoration: const InputDecoration(
                      labelText: 'Apellido materno',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: ciController,
                    inputFormatters: AppValidators.ciOnly,
                    validator: AppValidators.ci,
                    readOnly: isEditing,
                    decoration: const InputDecoration(labelText: 'CI'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: telefonoController,
                    inputFormatters: AppValidators.phoneOnly,
                    validator: AppValidators.phone,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Telefono'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: correoController,
                    inputFormatters: AppValidators.safeText,
                    validator: AppValidators.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Correo'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: direccionDomicilioController,
                    inputFormatters: AppValidators.address,
                    validator: AppValidators.addressValidator,
                    decoration: const InputDecoration(
                      labelText: 'Direccion domicilio',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: direccionTrabajoController,
                    inputFormatters: AppValidators.address,
                    validator: AppValidators.addressValidator,
                    decoration: const InputDecoration(
                      labelText: 'Direccion trabajo',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: latitudController,
                          validator: coordenada,
                          inputFormatters: AppValidators.signedDecimalOnly,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Latitud',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: longitudController,
                          validator: coordenada,
                          inputFormatters: AppValidators.signedDecimalOnly,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Longitud',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: seleccionarUbicacion,
                      icon: const Icon(Icons.map),
                      label: const Text('Elegir ubicacion en mapa'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    initialValue: tipoUsuario,
                    items: const [
                      DropdownMenuItem(
                        value: 'CLIENTE',
                        child: Text('Cliente'),
                      ),
                      DropdownMenuItem(
                        value: 'COBRADOR',
                        child: Text('Cobrador'),
                      ),
                    ],
                    onChanged: isEditing
                        ? null
                        : (value) {
                            if (value == null) return;
                            setState(() {
                              tipoUsuario = value;
                            });
                          },
                    decoration: const InputDecoration(
                      labelText: 'Tipo de usuario',
                    ),
                  ),
                  if (!isEditing) ...[
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: usuarioController,
                      inputFormatters: AppValidators.safeText,
                      validator: (value) =>
                          AppValidators.email(value, required: false),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Usuario / correo de acceso',
                        helperText:
                            'Opcional. Si se deja vacio se genera automaticamente.',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      validator: _validarPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contrasena',
                        helperText: 'Opcional. Por defecto: 123456',
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    initialValue: estadoCredito,
                    items: const [
                      DropdownMenuItem(value: 'BUENO', child: Text('Bueno')),
                      DropdownMenuItem(
                        value: 'REGULAR',
                        child: Text('Regular'),
                      ),
                      DropdownMenuItem(value: 'MALO', child: Text('Malo')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        estadoCredito = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Estado credito',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: saving
              ? null
              : () {
                  Navigator.pop(context);
                },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: saving || !puedeGuardar ? null : guardarCliente,
          child: Text(saving ? 'Guardando...' : 'Guardar'),
        ),
      ],
    );
  }
}
