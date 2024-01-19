import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/business_logic/cubit/characters_cubit.dart';
import 'package:test_flutter/data/model/character_response.dart';
import 'package:test_flutter/data/repository/characters_repository.dart';
import 'package:test_flutter/data/servers/characters_service.dart';
import 'package:test_flutter/presentation/screens/characters_screen.dart';

import 'presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharactersRepository _charactersRepository;
  late CharactersCubit _charactersCubit;

  AppRouter() {
    _charactersRepository = CharactersRepository(CharactersService());
    _charactersCubit = CharactersCubit(_charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CharactersCubit>(
            create: (BuildContext context) => _charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as CharacterDto;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );

        default: return null;
    }
  }
}

const charactersScreen = '/';
const characterDetailsScreen = '/character-details';
