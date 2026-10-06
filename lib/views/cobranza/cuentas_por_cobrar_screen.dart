import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/bento_card.dart';

class CuentasPorCobrarScreen extends StatelessWidget {
  const CuentasPorCobrarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = NumberFormat.currency(symbol: 'L. ', decimalDigits: 2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cuentas por Cobrar',
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.8),
          ),
          const SizedBox(height: 4),
          Text('Mora, saldos vencidos y gestión de cobranza', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 24),
          BentoCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TOTAL CARTERA PENDIENTE', style: theme.textTheme.labelSmall?.copyWith(color: AppColors.warning)),
                    const SizedBox(height: 4),
                    Text(currency.format(1485200.0), style: theme.textTheme.displayLarge?.copyWith(fontSize: 32, fontWeight: FontWeight.w900)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.warningBg, shape: BoxShape.circle),
                  child: const Icon(Icons.attach_money_rounded, color: AppColors.warning, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
