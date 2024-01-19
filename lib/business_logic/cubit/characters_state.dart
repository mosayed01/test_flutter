part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<CharacterDto> characters;

  CharactersLoaded(this.characters);
}

final class CharactersError extends CharactersState {
  final String message;

  CharactersError(this.message);
}

