import 'package:flutter/material.dart';
import 'package:movies_flutter/models/models.dart';
import 'package:movies_flutter/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            movieTitle: movie.title,
            movieFullBackdropImg: movie.fullBackdropImg,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(
              movieTitle: movie.title,
              movieFullPosterImg: movie.fullPosterImg,
              movieOriginalTitle: movie.originalTitle,
              movieVoteAverage: movie.voteAverage,
            ),
            _Overview(
              movieOverview: movie.overview,
            ),
            CastingCards(movieId: movie.id,),
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String movieTitle;
  final String movieFullBackdropImg;

  const _CustomAppBar(
      {required this.movieTitle, required this.movieFullBackdropImg});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movieTitle,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movieFullBackdropImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String movieTitle;
  final String movieFullPosterImg;
  final String movieOriginalTitle;
  final double movieVoteAverage;

  const _PosterAndTitle(
      {required this.movieTitle,
      required this.movieFullPosterImg,
      required this.movieOriginalTitle,
      required this.movieVoteAverage});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movieFullPosterImg),
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movieOriginalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      movieVoteAverage.toString(),
                      style: textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String movieOverview;

  const _Overview({required this.movieOverview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movieOverview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
