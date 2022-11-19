import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

@immutable
class Film {
  final String id;
  final String title;
  final String desscription;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.desscription,
    required this.isFavorite,
  });

  Film copy({required bool isFavorite}) {
    return Film(
      id: id,
      title: title,
      desscription: desscription,
      isFavorite: isFavorite,
    );
  }

  @override
  String toString() {
    return 'Film(id: $id, title: $title, desscription: $desscription, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          isFavorite,
        ],
      );
}

const allFilms = [
  Film(
    id: "1",
    title: "title1",
    desscription: "desscription1",
    isFavorite: false,
  ),
  Film(
    id: "2",
    title: "title2",
    desscription: "desscription2",
    isFavorite: false,
  ),
  Film(
    id: "3",
    title: "title3",
    desscription: "desscription3",
    isFavorite: false,
  ),
  Film(
    id: "4",
    title: "title4",
    desscription: "desscription4",
    isFavorite: false,
  ),
];

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(allFilms);

  void update(Film film, bool isFavorite) {
    state = state
        .map((thisFilm) => thisFilm.id == film.id
            ? thisFilm.copy(isFavorite: isFavorite)
            : thisFilm)
        .toList();
  }
}

enum FavoriteStatus { all, favorite, notFavorite }

// favorites status.
final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (_) => FavoriteStatus.all,
);

// all films.
final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>(
  (_) => FilmsNotifier(),
);

// favorite films.
final favoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where((film) => film.isFavorite),
);

// not favorite films.
final notFavoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where((film) => !film.isFavorite),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo -> Example 06',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FilterWidget(),
          Consumer(builder: (context, ref, child) {
            final filter = ref.watch(favoriteStatusProvider);
            switch (filter) {
              case FavoriteStatus.all:
                return FilmsWidget(provider: allFilmsProvider);
              case FavoriteStatus.favorite:
                return FilmsWidget(provider: favoriteFilmsProvider);
              case FavoriteStatus.notFavorite:
                return FilmsWidget(provider: notFavoriteFilmsProvider);
            }
          }),
        ],
      ),
    );
  }
}

class FilmsWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsWidget({Key? key, required this.provider}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);
          final favoriteIcon = film.isFavorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.desscription),
            trailing: IconButton(
              icon: favoriteIcon,
              onPressed: () {
                final isFavorite = !film.isFavorite;
                ref.read(allFilmsProvider.notifier).update(film, isFavorite);
              },
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends ConsumerWidget {
  const FilterWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: ((context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values
              .map(
                (fs) => DropdownMenuItem(
                  value: fs,
                  child: Text(fs.toString().split('.').last),
                ),
              )
              .toList(),
          onChanged: (FavoriteStatus? fs) {
            ref.read(favoriteStatusProvider.state).state = fs!;
          },
        );
      }),
    );
  }
}
