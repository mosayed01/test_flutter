import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_flutter/data/model/character_response.dart';

import '../../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;
  List<CharacterDto> _characters = [];

  CharactersCubit(this._charactersRepository) : super(CharactersInitial());

  List<CharacterDto> getAllCharacters() {
    _charactersRepository
        .getAllCharacters()
        .then((characters) => {
              emit(CharactersLoaded(characters)),
              _characters = characters,
            })
        .catchError((error) => {emit(CharactersError(error.toString()))});
    return _characters;
  }
}
