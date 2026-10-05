import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestión de Activos e Inventarios',
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Control de flota vehicular, dispositivos corporativos y consumo de tintas',
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          // Trucks Fleet Bento Card
          BentoCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.airport_shuttle_rounded, color: AppColors.primaryBlue, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Camión C-04 • Freightliner M2', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        Text('Placa: HAA-4921 • Capacidad: 24,000 lbs', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // IT Device Bento Card
          BentoCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.accentCyan.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.phone_android_rounded, color: AppColors.accentCyan, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Samsung Galaxy A34 5G (IMEI 354891029348123)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        Text('Asignado a: Carlos Mendoza (Supervisión Vendedora)', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Inks Bento Card
          BentoCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.print_rounded, color: AppColors.warning, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tinta Epson 542 Cyan (Impresión Facturas)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        Text('Nuevas: 12 unidades • Abiertas: 2 unidades', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
