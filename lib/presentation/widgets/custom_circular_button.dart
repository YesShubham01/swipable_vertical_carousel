import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomCircularButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isEnabled;

  const CustomCircularButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  State<CustomCircularButton> createState() => _CustomCircularButtonState();
}

class _CustomCircularButtonState extends State<CustomCircularButton>
    with SingleTickerProviderStateMixin {
  final Color activeColor = Colors.black;
  final Color inactiveColor = Colors.grey.shade500;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTapDown: widget.isEnabled
              ? (_) => setState(() => _isPressed = true)
              : null,
          onTapUp: widget.isEnabled
              ? (_) {
                  setState(() => _isPressed = false);
                  widget.onTap();
                }
              : null,
          onTapCancel: widget.isEnabled
              ? () => setState(() => _isPressed = false)
              : null,
          child: AnimatedScale(
            scale: _isPressed ? 0.92 : 1.0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: widget.isEnabled ? activeColor : inactiveColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(widget.icon, color: Colors.white, size: 38),
            ),
          ),
        ),
        const Gap(8),
        CustomText(
          text: widget.label,
          size: 14,
          color: Colors.black87,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}
