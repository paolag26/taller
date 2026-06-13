import 'package:flutter/material.dart';

import 'package:sist_prestamo/views/erp_card.dart';

class ClientesTable extends StatelessWidget {
  final List<Map<String, dynamic>> clientes;
  final ValueChanged<Map<String, dynamic>> onEdit;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const ClientesTable({
    super.key,
    required this.clientes,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _ClientesCards(
            clientes: clientes,
            onEdit: onEdit,
            onDelete: onDelete,
          );
        }

        return _ClientesDesktopTable(
          clientes: clientes,
          onEdit: onEdit,
          onDelete: onDelete,
        );
      },
    );
  }
}

class _ClientesDesktopTable extends StatelessWidget {
  final List<Map<String, dynamic>> clientes;
  final ValueChanged<Map<String, dynamic>> onEdit;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const _ClientesDesktopTable({
    required this.clientes,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xfff8fafc),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffe2e8f0)),
            ),
            child: const Row(
              children: [
                Expanded(child: _HeaderText('Codigo')),
                Expanded(flex: 2, child: _HeaderText('Cliente')),
                Expanded(child: _HeaderText('CI')),
                Expanded(child: _HeaderText('Celular')),
                Expanded(child: _HeaderText('Estado')),
                SizedBox(width: 120, child: _HeaderText('Acciones')),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];
                final persona =
                    cliente['persona'] as Map<String, dynamic>? ??
                    {
                      'nombres': 'Cliente',
                      'apellido_paterno': cliente['ci_persona'],
                      'apellido_materno': '',
                      'ci_persona': cliente['ci_persona'],
                      'telefono': '',
                    };

                final nombre =
                    '${persona['nombres'] ?? ''} '
                            '${persona['apellido_paterno'] ?? ''} '
                            '${persona['apellido_materno'] ?? ''}'
                        .trim();

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffedf2f7)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '#${cliente['id_cliente']}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          nombre.isEmpty ? 'Cliente sin nombre' : nombre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(child: Text(persona['ci_persona'] ?? '')),
                      Expanded(child: Text(persona['telefono'] ?? '')),
                      Expanded(
                        child: StatusChip.fromText(
                          cliente['estado'] == true ? 'ACTIVO' : 'INACTIVO',
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => onEdit(cliente),
                              tooltip: 'Editar',
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              onPressed: () => onDelete(cliente),
                              tooltip: 'Eliminar',
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class _ClientesCards extends StatelessWidget {
  final List<Map<String, dynamic>> clientes;
  final ValueChanged<Map<String, dynamic>> onEdit;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const _ClientesCards({
    required this.clientes,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: clientes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final cliente = clientes[index];
        final persona = _persona(cliente);
        final nombre = _nombre(persona);

        return ErpCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      nombre.isEmpty ? 'Cliente sin nombre' : nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  StatusChip.fromText(
                    cliente['estado'] == true ? 'ACTIVO' : 'INACTIVO',
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'editar') onEdit(cliente);
                      if (value == 'eliminar') onDelete(cliente);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'editar', child: Text('Editar')),
                      PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _Field(label: 'Codigo', value: '#${cliente['id_cliente']}'),
              _Field(label: 'CI', value: persona['ci_persona'] ?? ''),
              _Field(label: 'Celular', value: persona['telefono'] ?? ''),
            ],
          ),
        );
      },
    );
  }
}

Map<String, dynamic> _persona(Map<String, dynamic> cliente) {
  return cliente['persona'] as Map<String, dynamic>? ??
      {
        'nombres': 'Cliente',
        'apellido_paterno': cliente['ci_persona'],
        'apellido_materno': '',
        'ci_persona': cliente['ci_persona'],
        'telefono': '',
      };
}

String _nombre(Map<String, dynamic> persona) {
  return '${persona['nombres'] ?? ''} '
          '${persona['apellido_paterno'] ?? ''} '
          '${persona['apellido_materno'] ?? ''}'
      .trim();
}

class _Field extends StatelessWidget {
  final String label;
  final String value;

  const _Field({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 74,
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

class _HeaderText extends StatelessWidget {
  final String text;

  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xff475569),
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
