import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
              if (state is UpcomingMoviesLoadedState) {
                return CarouselSlider(

                  items: state.data.results!.map(
                    (i) {
                      return Container(
                        height: 466,
                        width: 428,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(
                              45,
                            ),
                            bottomRight: Radius.circular(
                              45,
                            ),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w1280${i.backdropPath!}',
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 24 + MediaQuery.of(context).padding.top,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppIcons.icAppIcon,
                                  AppIcons.icNotification
                                ],
                              ),
                            ),
                            const Spacer(),
                            AppIcons.icPlayVideoIcon,
                            const SizedBox(height: 16),
                            Text(
                              i.originalTitle!,
                              style: Typographies.heading4
                                  .copyWith(color: MainPrimaryColor.primary100),
                            ),
                            const SizedBox(height: 16),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TagComponent(
                                  title: i.genreIds.toString(),
                                ),
                                const SizedBox(width: 12),
                                TagComponent(
                                  title: i.releaseDate!,
                                ),
                                const SizedBox(width: 12),
                                TagComponent(
                                  title: i.originalLanguage!,
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: 466,
                    autoPlay: true,
                    viewportFraction: 1
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 50,
                    width: 90,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://wallpapercat.com/w/full/4/e/a/33262-3376x1899-desktop-hd-star-wars-background.jpg',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top 10 Movies This Week',
                    style: Typographies.heading5,
                  ),
                  Text(
                    'See all',
                    style: Typographies.bodyMediumSemiBold
                        .copyWith(color: MainPrimaryColor.primary500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://wallpapercat.com/w/full/4/e/a/33262-3376x1899-desktop-hd-star-wars-background.jpg',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IMDbTag(
                              title: '9.8',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
