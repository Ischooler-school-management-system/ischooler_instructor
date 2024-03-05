import 'package:flutter/material.dart';

class IschoolerNavbarItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool isSelected;
  const IschoolerNavbarItem(
      {super.key,
      required this.icon,
      required this.title,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon,
        const SizedBox(width: 4),
        if (isSelected)
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
      ],
    );
  }
}
