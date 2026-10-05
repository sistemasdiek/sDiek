import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isSecondary;
  final LinearGradient? gradient;
  final double height;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isSecondary = false,
    this.gradient,
    this.height = 52,
    this.borderRadius = 14,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 12),
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: 20, color: Colors.white),
          const SizedBox(width: 10),
        ],
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
            color: Colors.white,
          ),
        ),
      ],
    );

    return AnimatedScale(
      scale: _isPressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 120),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            gradient: widget.isSecondary
                ? null
                : (widget.gradient ?? AppColors.primaryGradient),
            color: widget.isSecondary
                ? (isDark ? AppColors.darkSurfaceCard : AppColors.lightSurfaceCard)
                : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.isSecondary
                  ? (isDark ? AppColors.darkBorder : AppColors.lightBorder)
                  : Colors.white.withOpacity(0.15),
              width: 1,
            ),
            boxShadow: widget.isSecondary
                ? []
                : [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.35),
                      blurRadius: 16,
                      spreadRadius: 0,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: buttonChild,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
