import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'bento_card.dart';

class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final String? trendText;
  final bool isPositiveTrend;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.trendText,
    this.isPositiveTrend = true,
    required this.icon,
    this.iconColor = AppColors.primaryBlue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BentoCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: iconColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          if (subtitle != null || trendText != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                if (trendText != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isPositiveTrend ? AppColors.successBg : AppColors.errorBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                          size: 14,
                          color: isPositiveTrend ? AppColors.success : AppColors.error,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          trendText!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isPositiveTrend ? AppColors.success : AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
