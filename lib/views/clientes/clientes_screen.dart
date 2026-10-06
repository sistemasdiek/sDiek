import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';

class ClientesScreen extends StatelessWidget {
  const ClientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, String>> clientes = [
      {'code': 'C100452', 'name': 'Comercial La Economica S.A.', 'rtn': '08011990123456', 'city': 'San Pedro Sula'},
      {'code': 'C100889', 'name': 'Ferretería El Sol', 'rtn': '05011985678912', 'city': 'Tegucigalpa'},
      {'code': 'C101004', 'name': 'Distribuidora del Norte', 'rtn': '01011992881234', 'city': 'La Ceiba'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Directorio de Clientes',
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.8),
          ),
          const SizedBox(height: 4),
          Text('Maestro de Socios de Negocios SAP', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: clientes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final cli = clientes[index];
              return BentoCard(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.accentCyan.withOpacity(0.15),
                      child: Text(cli['name']!.substring(0, 2).toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.accentCyan)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cli['name']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                          Text('Código SAP: ${cli['code']} • RTN: ${cli['rtn']} • ${cli['city']}', style: theme.textTheme.bodyMedium),
                        ],
                      ),
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
}
