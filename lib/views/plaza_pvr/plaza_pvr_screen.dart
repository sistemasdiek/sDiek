import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';
import '../../providers/plaza_pvr_provider.dart';

class PlazaPvrScreen extends StatelessWidget {
  const PlazaPvrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pvrProvider = Provider.of<PlazaPvrProvider>(context);
    final inquilinos = pvrProvider.inquilinos;
    final currencyFormat = NumberFormat.currency(symbol: 'L. ', decimalDigits: 2);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Plaza Villa Rosa (PVR)',
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Gestión de contratos de arrendamiento, locales comerciales y mantenimiento',
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          // Total Income Bento Header
          BentoCard(
            gradient: AppColors.glassGradientDark,
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL RECAUDACIÓN MENSUAL',
                      style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 1.4, color: AppColors.accentCyan),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      currencyFormat.format(pvrProvider.totalMensualidad),
                      style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.accentIndigo.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.apartment_rounded, color: AppColors.accentIndigo, size: 32),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: inquilinos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final inq = inquilinos[index];

              return BentoCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.accentIndigo.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.storefront_rounded, color: AppColors.accentIndigo, size: 24),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  inq.nombre,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                                ),
                                Text(
                                  '${inq.local} • RTN: ${inq.rtn}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          currencyFormat.format(inq.totalMensual),
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: AppColors.success),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFeeDetail(context, 'Arrendamiento', inq.arrendamiento),
                        _buildFeeDetail(context, 'Mantenimiento', inq.mantenimiento),
                        _buildFeeDetail(context, 'Energía Eléctrica', inq.energiaDefault),
                      ],
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

  Widget _buildFeeDetail(BuildContext context, String label, double amount) {
    final currencyFormat = NumberFormat.currency(symbol: 'L. ', decimalDigits: 2);
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMutedDark)),
        const SizedBox(height: 2),
        Text(currencyFormat.format(amount), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
