import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? trailingIcon;
  final VoidCallback? trailingOnTap;
  final String? subtitle;
  final bool copyOnLongPress;

  const ContactItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.trailingIcon,
    this.trailingOnTap,
    this.subtitle,
    this.copyOnLongPress = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.primaryColor;
    final primaryLight = theme.colorScheme.primary.withOpacity(0.85);
    final bg = backgroundColor;
    final ic = iconColor ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        onLongPress: copyOnLongPress
            ? () async {
                await Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied "$label"'),
                    action: onTap != null
                        ? SnackBarAction(label: 'Open', onPressed: onTap!)
                        : null,
                  ),
                );
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bg,
                gradient: bg == null
                    ? LinearGradient(
                        colors: [primary, primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2)),
                ],
              ),
              child: Center(
                child: Icon(icon, color: ic, size: 20),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
                if (subtitle != null)
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      label:
                          Text(subtitle!, style: const TextStyle(fontSize: 12)),
                      backgroundColor:
                          theme.colorScheme.surfaceVariant.withOpacity(0.12),
                    ),
                  ),
              ],
            ),
            subtitle: Text(
              value,
              style: TextStyle(
                  fontSize: 14, color: theme.textTheme.bodyMedium!.color),
            ),
            onTap: onTap,
            trailing: trailingIcon != null
                ? IconButton(
                    tooltip: 'Action',
                    icon: Icon(
                      trailingIcon,
                      color:
                          theme.iconTheme.color ?? theme.colorScheme.onSurface,
                    ),
                    onPressed: trailingOnTap ?? onTap,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
