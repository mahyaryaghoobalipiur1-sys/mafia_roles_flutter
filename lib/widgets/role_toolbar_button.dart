import 'package:flutter/material.dart';

import '../models/role.dart';

/// A single role button for the Day/Night action toolbars: one icon plus
/// the role's name underneath - the same look everywhere, so a role
/// always reads the same way whether it's on the Full Roster, Day, or
/// Night screen (rather than two different icon styles for the same
/// role, one per screen).
class RoleToolbarButton extends StatelessWidget {
  final Role role;
  final bool armed;
  final bool disabled;
  final VoidCallback? onTap;
  final Color surfaceColor;
  final Color labelColor;
  final Color borderColor;

  const RoleToolbarButton({
    super.key,
    required this.role,
    required this.armed,
    required this.disabled,
    required this.onTap,
    this.surfaceColor = const Color(0xFF2A2438),
    this.labelColor = Colors.white,
    this.borderColor = Colors.white24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Opacity(
        opacity: disabled ? 0.35 : 1.0,
        child: Container(
          width: 64,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            color: armed ? role.color.withOpacity(0.35) : surfaceColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: armed ? role.color : borderColor,
              width: armed ? 2.5 : 1,
            ),
            boxShadow: armed
                ? [
                    BoxShadow(
                      color: role.color.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(role.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 2),
              Text(
                role.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: armed ? role.color : labelColor,
                ),
              ),
              if (disabled)
                Icon(Icons.block, size: 12, color: labelColor.withOpacity(0.6)),
            ],
          ),
        ),
      ),
    );
  }
}
