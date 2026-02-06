import 'package:flutter/material.dart';

class PokeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokeAppBar({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  final TextEditingController searchController;
  final Function(String) onChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Pokedex'),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search Pokemon...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
