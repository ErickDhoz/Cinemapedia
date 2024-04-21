import 'package:flutter/material.dart';
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    return NavigationBar(
      elevation: 0,
      destinations:  [
        NavigationDestination(icon: Icon(Icons.home_max_outlined, color: colors.primary), label: 'Inicio'),
        NavigationDestination(icon: Icon(Icons.label_outline, color: colors.primary),label: 'Categorias'),
        NavigationDestination(icon: Icon(Icons.favorite_outline, color: colors.primary),label: 'Favoritos')
      ]
      );
  }
}