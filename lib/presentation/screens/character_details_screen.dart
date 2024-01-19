import 'package:flutter/material.dart';
import 'package:test_flutter/data/model/character_response.dart';
import 'package:test_flutter/theme/colors.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  final CharacterDto character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Gander: ', character.gender ?? ''),
                      buildDivider(285),
                      characterInfo('Species: ', character.species ?? ''),
                      buildDivider(280),
                      characterInfo('Status: ', character.status ?? ''),
                      buildDivider(285),
                      characterInfo('Origin: ', character.origin?.name ?? ''),
                      buildDivider(295),
                      characterInfo(
                          'Last Location: ', character.location?.name ?? ''),
                      buildDivider(235),
                      characterInfo(
                          'Episodes: ', character.episode?.join(' , ') ?? ''),
                      buildDivider(265),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
                const SizedBox(height: 500)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      backgroundColor: AppColors.gray,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name ?? '',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.start,
        ),
        background: Hero(
            tag: character.id ?? '',
            child: Image.network(
              character.image ?? '',
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: AppColors.yellow,
      height: 32,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}
