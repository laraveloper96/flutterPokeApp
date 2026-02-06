import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PokemonDetail extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<String> abilities;
  final List<Stat> stats;
  final List<Chain> evolutions;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
    this.evolutions = const [],
    this.abilities = const [],
  });

  @override
  List<Object> get props => [
    id,
    name,
    imageUrl,
    types,
    height,
    weight,
    stats,
    evolutions,
    abilities,
  ];
}

class Chain extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Chain({required this.id, required this.name, required this.imageUrl});

  @override
  List<Object> get props => [id, name, imageUrl];
}

class Stat extends Equatable {
  final String name;
  final int baseStat;

  const Stat({required this.name, required this.baseStat});

  @override
  List<Object> get props => [name, baseStat];
}

extension PokemonTypeColor on PokemonDetail {
  Color get typeColor {
    switch (types.first.toLowerCase()) {
      case 'grass':
        return Colors.green;
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blue;
      case 'bug':
        return Colors.lightGreen;
      case 'electric':
        return Colors.orangeAccent;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'rock':
        return Colors.grey;
      case 'psychic':
        return Colors.pinkAccent;
      case 'ghost':
        return Colors.indigo;
      case 'dragon':
        return Colors.deepPurple;
      case 'fairy':
        return Colors.pink;
      case 'fighting':
        return Colors.orange;
      case 'ice':
        return Colors.cyanAccent;
      case 'steel':
        return Colors.blueGrey;
      case 'dark':
        return Colors.black87;
      default:
        return Colors.blueGrey;
    }
  }
}
