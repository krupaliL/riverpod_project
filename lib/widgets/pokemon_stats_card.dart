import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_data_providers.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonURL;

  PokemonStatsCard({
    super.key,
    required this.pokemonURL,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(
      pokemonDataProvider(
        pokemonURL,
      ),
    );

    return AlertDialog(
      title: const Text('Statistics', textAlign: TextAlign.center,),
      content: pokemon.when(
        data: (data) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data?.stats?.map(
                  (stat) {
                    return Text(
                      '${stat.stat?.name?.toUpperCase()}: ${stat.baseStat}',
                    );
                  },
                ).toList() ??
                [],
          );
        },
        error: (error, stackTrace) {
          return Text(
            error.toString(),
          );
        },
        loading: () {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        },
      ),
    );
  }
}
