import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BentoCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const BentoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 24,
    this.backgroundColor,
    this.gradient,
    this.onTap,
  });

  @override
  State<BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<BentoCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scale = _isPressed ? 0.98 : (_isHovered ? 1.015 : 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  (isDark ? AppColors.darkSurfaceCard : AppColors.lightSurface),
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    isDark ? (_isHovered ? 0.35 : 0.2) : (_isHovered ? 0.08 : 0.03),
                  ),
                  blurRadius: _isHovered ? 30 : 16,
                  spreadRadius: 0,
                  offset: Offset(0, _isHovered ? 12 : 6),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
