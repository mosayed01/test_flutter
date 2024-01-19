import 'package:test_flutter/data/servers/characters_service.dart';

import '../model/character_response.dart';

class CharactersRepository {
  final CharactersService _charactersService;

  CharactersRepository(this._charactersService);

  Future<List<CharacterDto>> getAllCharacters() async {
    // TODO: add mapping logic
    final response = await _charactersService.getAllCharacters();
    return response.results ?? []; 
  }

}