import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/humans_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;
  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
    final scrollController = ScrollController();

    @override
  void initState() {
      super.initState();

      scrollController.addListener(() {

            if(widget.loadNextPage == null) return;
            if(scrollController.position.pixels + 200 > scrollController.position.maxScrollExtent){
              widget.loadNextPage!();
            }

        },
      );
  }

  @override
  void dispose() {
    scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 370,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
            const SizedBox(height: 10,),
          Expanded(
              child: ListView.builder(
                controller: scrollController,
            itemCount: widget.movies.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _Slide(
              movie: widget.movies[index],
            ),
          ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: Colors.yellow.shade800,
              ),
              const SizedBox(width: 3,),
              Text('${movie.voteAverage}',style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
              const SizedBox(width: 10,),
              Text('${HumansFormats.number(movie.popularity)}K',style: textStyle.bodySmall,)
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(top: 12),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: textStyle.titleLarge,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(
                  subTitle!,
                  style: textStyle.titleLarge,
                ))
        ],
      ),
    );
  }
}
