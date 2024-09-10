import 'package:flutter/material.dart';
import 'package:music_plaayer/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class Box extends StatelessWidget {
  final Widget? child;

  const Box({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    //is dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            //darker shadow on bottom
            BoxShadow(
              color: isDarkMode ? Colors.black : Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ),

            //light shadow on top left
            BoxShadow(
              color: isDarkMode ? Colors.black : Colors.white,
              blurRadius: 15,
              offset: const Offset(-4, -4),
            ),
          ]),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
