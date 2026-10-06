import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tutoriales & Capacitación',
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.8),
          ),
          const SizedBox(height: 4),
          Text('Guías de uso del sistema ERP Corporación Diek', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 24),
          BentoCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.play_circle_fill_rounded, color: AppColors.primaryBlue, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cómo ingresar pedidos en SAP Business One', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      Text('Aprende a registrar pedidos de venta y cotizaciones.', style: theme.textTheme.bodyMedium),
                    ],
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
