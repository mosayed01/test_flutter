import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:test_flutter/business_logic/cubit/characters_cubit.dart';
import 'package:test_flutter/presentation/widget/character_item.dart';
import 'package:test_flutter/theme/colors.dart';

import '../../data/model/character_response.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharacterDto> allCharacters = [];
  List<CharacterDto> serchedCharacters = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.gray,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.black87, fontSize: 18),
      onChanged: (query) {
        searchByName(query);
      },
    );
  }

  void searchByName(String query) {
    serchedCharacters = allCharacters
        .where(
          (character) =>
              character.name?.toLowerCase().startsWith(query.toLowerCase()) ??
              false,
        )
        .toList();
  }

  List<Widget> buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: AppColors.gray,
          ),
          onPressed: () {
            _clearSearchQuery();
            Navigator.pop(context);
          },
        ),
      ];
    }
    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search,
          color: AppColors.gray,
        ),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        title: _isSearching ? buildSearchField() : _buildAppParTitle(),
        actions: buildActions(),
        leading: _isSearching
            ? const BackButton(color: AppColors.gray)
            : Container(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return const Center(
              child: Text('No Internet Connection'),
            );
          }
        },
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.yellow),
        )
      ),
    );
  }

  Widget _buildAppParTitle() {
    return const Text(
      'Characters',
      style: TextStyle(
        color: AppColors.gray,
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildCharactersList(
            _isSearching ? serchedCharacters : allCharacters,
          );
        } else if (state is CharactersError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        }
      },
    );
  }

  Widget buildCharactersList(List<CharacterDto> allCcharacters) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.gray,
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: allCcharacters.length,
              itemBuilder: (context, index) {
                return CharacterItem(character: allCcharacters[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
