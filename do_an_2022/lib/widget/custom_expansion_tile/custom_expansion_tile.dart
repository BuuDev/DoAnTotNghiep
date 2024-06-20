import 'package:flutter/material.dart';

import '../../theme/color.dart';

class CustomExpansionTile extends StatefulWidget {
  final void Function(bool)? onExpansionChanged;
  final IconData icons;
  final String title;
  final int index;
  final List<Widget> children;
  final Widget? trailing;

  const CustomExpansionTile({
    Key? key,
    this.onExpansionChanged,
    required this.title,
    required this.icons,
    required this.index,
    required this.children,
    this.trailing,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  Widget get icon {
    return widget.trailing ??
        (isExpanded
            ? const Icon(Icons.expand_more)
            : const Icon(Icons.navigate_next));
  }

  void onExpand(bool isExpanded) {
    setState(() {
      this.isExpanded = isExpanded;
    });
    widget.onExpansionChanged?.call(isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: onExpand,
      iconColor: AppColors.primary,
      collapsedIconColor:
          isExpanded ? AppColors.primary : AppColors.textBlueBlack,
      leading: Icon(
        widget.icons,
        color: isExpanded ? AppColors.primary : AppColors.textBlueBlack,
      ),
      trailing: icon,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: isExpanded ? AppColors.primary : AppColors.textBlueBlack,
              fontWeight: FontWeight.bold,
            ),
      ),
      children: widget.children,
    );
  }
}
