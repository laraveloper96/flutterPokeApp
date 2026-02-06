import 'package:flutter/material.dart';
import 'package:pokeapp/core/shared/presentation/widgets/painters/pokeball_logo_painter.dart';
import 'package:pokeapp/features/pokemon_detail/presentation/widgets/detail/detail_component.dart';

class PokeLogoWidget extends StatelessWidget {
  const PokeLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
        opacity: pokeballOpacity,
        child: CustomPaint(
          size: const Size(pokeballSize, pokeballSize),
          painter: PokeballLogoPainter(color: Colors.white),
        ),
      ),
    );
  }
}
