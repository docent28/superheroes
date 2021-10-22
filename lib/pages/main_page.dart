import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superheroes/blocs/main_bloc.dart';
import 'package:superheroes/pages/superhero_page.dart';
import 'package:superheroes/resources/superheroes_colors.dart';
import 'package:superheroes/resources/superheroes_images.dart';
import 'package:superheroes/widgets/action_button.dart';
import 'package:superheroes/widgets/info_with_button.dart';
import 'package:superheroes/widgets/superhero_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainBloc bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: const Scaffold(
        backgroundColor: SuperheroesColors.background,
        body: SafeArea(
          child: MainPageContent(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class MainPageContent extends StatelessWidget {
  const MainPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context, listen: false);
    return Stack(
      children: [
        const MainPageStateWidget(),
        Align(
          alignment: Alignment.bottomCenter,
          child: ActionButton(
            onTap: () => bloc.nextState(),
            text: "Next state",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
          ),
          child: SearchWidget(),
        ),
      ],
    );
  }
}

class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => print("CONTROLLER: ${controller}"));
  }

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context, listen: false);
    return TextField(
      controller: controller,
      onChanged: (text) => bloc.updateText(text),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: SuperheroesColors.indigo75,
        isDense: true,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white54,
          size: 24,
        ),
        suffix: GestureDetector(
          onTap: () => controller.clear(),
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}

class MainPageStateWidget extends StatelessWidget {
  const MainPageStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context, listen: false);
    return StreamBuilder<MainPageState>(
      stream: bloc.observeMainPageState(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox();
        }
        final MainPageState state = snapshot.data!;
        switch (state) {
          case MainPageState.loading:
            return const LoadingIndicator();
          case MainPageState.minSymbols:
            return const MinSymbolsWidget();
          case MainPageState.noFavorites:
            return NoFavoritesWidget();
          case MainPageState.favorites:
            return const FavoritesWidget();
          case MainPageState.searchResults:
            return const SearchResultsWidget();
          case MainPageState.nothingFound:
            return NothingFoundWidget();
          case MainPageState.loadingError:
            return LoadingErrorWidget();
          default:
            return Center(
              child: Text(
                state.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
        }
      },
    );
  }
}

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 90),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Your favorites",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperheroCard(
            name: "Batman",
            realName: "Bruce Wayne",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SuperheroPage(name: "Batman"),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperheroCard(
            name: "Ironman",
            realName: "Tony Stark",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/85.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SuperheroPage(name: "Ironman"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 90),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Search results",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperheroCard(
            name: "Batman",
            realName: "Bruce Wayne",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SuperheroPage(name: "Batman"),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SuperheroCard(
            name: "Venom",
            realName: "Eddie Brock",
            imageUrl:
                "https://www.superherodb.com/pictures2/portraits/10/100/22.jpg",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SuperheroPage(name: "Venom"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NoFavoritesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InfoWithButton(
        title: "No favorites yet",
        subtitle: "Search and add",
        buttonText: "Search",
        assetImage: SuperheroesImages.ironman,
        imageHeight: 119,
        imageWidth: 108,
        imageTopPadding: 9,
      ),
    );
  }
}

class NothingFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InfoWithButton(
        title: "Nothing found",
        subtitle: "Search for something else",
        buttonText: "Search",
        assetImage: SuperheroesImages.hulk,
        imageHeight: 112,
        imageWidth: 84,
        imageTopPadding: 16,
      ),
    );
  }
}

class LoadingErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InfoWithButton(
        title: "Error happened",
        subtitle: "Please, try again",
        buttonText: "Retry",
        assetImage: SuperheroesImages.superman,
        imageHeight: 106,
        imageWidth: 126,
        imageTopPadding: 22,
      ),
    );
  }
}

class MinSymbolsWidget extends StatelessWidget {
  const MinSymbolsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 110),
        child: Text(
          "Enter at least 3 symbols",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 110),
        child: CircularProgressIndicator(
          color: SuperheroesColors.blue,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
