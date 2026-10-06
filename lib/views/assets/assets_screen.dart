import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../providers/assets_provider.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final assetsProvider = Provider.of<AssetsProvider>(context);

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
            'Consultas en tiempo real a tablas Supabase (dispositivos, tintas, camiones)',
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          Text('FLOTA DE CAMIONES', style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 1.2)),
          const SizedBox(height: 12),

          if (assetsProvider.camiones.isEmpty) ...[
            BentoCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
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
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: assetsProvider.camiones.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final cam = assetsProvider.camiones[idx];
                return BentoCard(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.airport_shuttle_rounded, color: AppColors.primaryBlue, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Placa: ${cam.placaNueva} (${cam.marca ?? "Sin marca"})', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                          Text('Descripción: ${cam.descripcion ?? "Activo"}', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],

          const SizedBox(height: 24),

          Text('DISPOSITIVOS T.I.', style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 1.2)),
          const SizedBox(height: 12),

          if (assetsProvider.dispositivos.isEmpty) ...[
            BentoCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.accentCyan.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
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
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: assetsProvider.dispositivos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final disp = assetsProvider.dispositivos[idx];
                return BentoCard(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.accentCyan.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.phone_android_rounded, color: AppColors.accentCyan, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Modelo: ${disp.modelo ?? "Teléfono"} • IMEI: ${disp.imei ?? "N/A"}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                          Text('Asignado a: ${disp.empleadoNombre ?? "Sin asignar"}', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
