import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superheroes/model/biography.dart';
import 'package:superheroes/model/powerstats.dart';
import 'package:superheroes/model/server_image.dart';
import 'package:superheroes/model/superhero.dart';
import 'package:superheroes/resources/superheroes_colors.dart';
import 'package:superheroes/widgets/action_button.dart';

class SuperheroPage extends StatelessWidget {
  final String id;

  const SuperheroPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final superhero = Superhero(
      id: id,
      name: "Batman",
      biography: Biography(
        fullName: "Batman Anatol'evich",
        alignment: "good",
        aliases: ["Batmanovich", "Protector of the Realm"],
        placeOfBirth: "Russia, St. Petersburg",
      ),
      image: ServerImage(
        "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg",
      ),
      powerstats: Powerstats(
        intelligence: "81",
        strength: "40",
        speed: "29",
        durability: "55",
        power: "63",
        combat: "90",
      ),
    );
    return Scaffold(
      backgroundColor: SuperheroesColors.background,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            stretch: true,
            pinned: true,
            floating: true,
            expandedHeight: 348,
            backgroundColor: SuperheroesColors.background,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                superhero.name,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              centerTitle: true,
              background: CachedNetworkImage(
                imageUrl: superhero.image.url,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
