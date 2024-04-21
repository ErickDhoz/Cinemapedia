import 'package:cinemapedia/presentation/providers/movies/actors/actors_by_movie_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliderAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDatails(movie: movie),
            childCount: 1,
          ))
        ],
      ),
    );
  }
}

class _CustomSliderAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliderAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Center(
          child: Stack(
            children: [
              SizedBox.expand(
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox.expand(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                    0.7,
                    1.0
                  ],
                              colors: [
                    Colors.transparent,
                    Colors.black87,
                  ])))),
              const SizedBox.expand(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient:
                              LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))))
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieDatails extends StatelessWidget {
  final Movie movie;
  const _MovieDatails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: size.width*0.3,
                ),
            ),
            const SizedBox(width:10),
            
             SizedBox(width:(size.width-40)*0.7,
             child: Column(
              children: [
                Text(movie.title, style: textStyles.titleLarge,),
                Text(movie.overview)
              ],
             ),
             ),
          ],
        ),
        ),
        // Generos de las peliculas Aquí
        Padding(padding: EdgeInsets.all(8),
        child: Wrap(
          children: [
            ...movie.genreIds.map((gender) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(label: Text(gender),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),),
          ],
        ),
        ),
        //TODO: Mostrar Actores en un ListView
       const  SizedBox(height: 100,),
      ],
    );
  }
}