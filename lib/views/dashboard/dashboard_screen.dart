import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../core/widgets/kpi_card.dart';
import '../../providers/dashboard_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final kpi = dashboardProvider.kpi;

    return RefreshIndicator(
      onRefresh: () => dashboardProvider.refreshDashboard(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumen Ejecutivo',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Control en tiempo real de SAP Business One & Operaciones',
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceCard : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.accentCyan),
                      const SizedBox(width: 8),
                      Text(
                        'Octubre 2026',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Top KPI Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;
                return GridView.count(
                  crossAxisCount: isWide ? 4 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isWide ? 1.6 : 1.3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    KpiCard(
                      title: 'Giras Activas',
                      value: kpi.activeGiras,
                      subtitle: 'En ruta nacional',
                      trendText: '+12%',
                      icon: Icons.local_shipping_rounded,
                      iconColor: AppColors.primaryBlue,
                    ),
                    KpiCard(
                      title: 'Entregas Bodega',
                      value: kpi.pendingDeliveries,
                      subtitle: 'Pendientes envío',
                      trendText: '-5%',
                      isPositiveTrend: false,
                      icon: Icons.inventory_2_rounded,
                      iconColor: AppColors.warning,
                    ),
                    KpiCard(
                      title: 'Empleados',
                      value: kpi.activeEmployees,
                      subtitle: 'Asistencia activa',
                      trendText: '+3',
                      icon: Icons.badge_rounded,
                      iconColor: AppColors.success,
                    ),
                    KpiCard(
                      title: 'Ingresos PVR',
                      value: kpi.monthlyPvrRevenue,
                      subtitle: 'Plaza Villa Rosa',
                      trendText: '+8.4%',
                      icon: Icons.apartment_rounded,
                      iconColor: AppColors.accentIndigo,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // Bento Grid Main Panels
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Panel Left: Logistics & Operations
                Expanded(
                  flex: 3,
                  child: BentoCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlue.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.map_rounded, color: AppColors.primaryBlue, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Estado de Giras & Rutas GPS',
                                  style: theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.successBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                '3 Motoristas en Línea',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.success),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Route Progress Bar Card 1
                        _buildRouteProgressCard(
                          context,
                          driverName: 'Juan Pérez (Camión C-04)',
                          route: 'San Pedro Sula ➔ Choloma ➔ Puerto Cortés',
                          progress: 0.72,
                          statusText: '72% Completado • 18 Pedidos Entregados',
                        ),

                        const SizedBox(height: 12),

                        // Route Progress Bar Card 2
                        _buildRouteProgressCard(
                          context,
                          driverName: 'Kevin Alexander Ramos (Camión C-08)',
                          route: 'Tegucigalpa ➔ Comayagua ➔ Siguatepeque',
                          progress: 0.45,
                          statusText: '45% Completado • 12 Pedidos Entregados',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // Panel Right: Sales Goal & Brands Progress
                Expanded(
                  flex: 2,
                  child: BentoCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.accentCyan.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.bar_chart_rounded, color: AppColors.accentCyan, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Cumplimiento Metas',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: Column(
                            children: [
                              Text(
                                kpi.salesTargetAchievement,
                                style: theme.textTheme.displayLarge?.copyWith(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                              Text(
                                'META GENERAL ALCANZADA',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  letterSpacing: 1.4,
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        _buildBrandBar(context, 'Tramontina', 0.88, AppColors.primaryBlue),
                        const SizedBox(height: 12),
                        _buildBrandBar(context, 'Fanal Cerraduras', 0.94, AppColors.success),
                        const SizedBox(height: 12),
                        _buildBrandBar(context, 'Gato Hidráulico', 0.78, AppColors.warning),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteProgressCard(
    BuildContext context, {
    required String driverName,
    required String route,
    required double progress,
    required String statusText,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                driverName,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primaryBlue, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(route, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: isDark ? Colors.black26 : Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
          ),
          const SizedBox(height: 8),
          Text(statusText, style: theme.textTheme.labelSmall?.copyWith(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildBrandBar(BuildContext context, String brand, double pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(brand, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('${(pct * 100).toInt()}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 6,
            backgroundColor: color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
