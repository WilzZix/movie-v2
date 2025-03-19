import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie/application/person/person_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/presentation/pages/movie_detail_page/movie_detail_page.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key, required this.personId});

  static const String tag = 'person_page';
  final int personId;

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _personBloc.add(GetPersonDetailEvent(personId: widget.personId));
    _personBloc.add(GetPersonPlayedMoviesEvent(personId: widget.personId));
    _personBloc.add(GetPersonGalleryEvent(personId: widget.personId));
    _tabController.addListener(tabChanged);
  }

  void tabChanged() {
    if (_tabController.index == 0 && !_tabController.indexIsChanging) {
      _personBloc.add(GetPersonPlayedMoviesEvent(personId: widget.personId));
    } else if (_tabController.index == 1 && !_tabController.indexIsChanging) {
      _personBloc.add(GetPersonDetailEvent(personId: widget.personId));
      _personBloc.add(GetPersonGalleryEvent(personId: widget.personId));
    }
  }

  late TabController _tabController;
  late final PersonBloc _personBloc = PersonBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _personBloc,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            BlocBuilder<PersonBloc, PersonState>(
              buildWhen: (context, state) {
                return state is PersonMovieDetailLoadedState;
              },
              builder: (context, state) {
                if (state is PersonMovieDetailLoadedState) {
                  return SliverAppBar(
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          Container(
                            height: 450,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w1280${state.data.profilePath}"),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35), // Adjust blur intensity
                              child: Container(
                                color: Colors.black.withOpacity(0.2), // Optional tint
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).padding.top + 70,
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    "https://image.tmdb.org/t/p/w1280${state.data.profilePath}"),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                DateFormat("dd MMM, yyyy").format(
                                    DateTime.parse(state.data.birthday)),
                                style: Typographies.bodyLargeSemiBold.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AppIcons.icIgIcon,
                                  AppIcons.icIgIcon,
                                  AppIcons.icIgIcon,
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      state.data.name,
                      style: Typographies.heading4.copyWith(color: Colors.white),
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                    child: CircularProgressIndicator());
              },
            ),
            SliverToBoxAdapter(
              child: TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                tabs: const [
                  Text('Filmography'),
                  Text('Biography'),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 500,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocBuilder<PersonBloc, PersonState>(
                      builder: (context, state) {
                        if (state is PersonMoviesLoadedState) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    context.pushNamed(
                                      MovieDetailPage.tag,
                                      extra: state.data[index].id,
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                          width: 190,
                                          height: 248,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w1280${state.data[index].backdropPath}'),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: IMDbTag(
                                          title: state.data[index].voteAverage
                                              .toStringAsFixed(1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<PersonBloc, PersonState>(
                            buildWhen: (context, state) {
                              return state is PersonMovieDetailLoadedState;
                            },
                            builder: (context, state) {
                              if (state is PersonMovieDetailLoadedState) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  child: Text(
                                    state.data.biography,
                                    style: Typographies.bodyMediumMedium,
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gallery',
                                  style: Typographies.heading5,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'See all',
                                    style: Typographies.bodyMediumSemiBold
                                        .copyWith(
                                            color: MainPrimaryColor.primary500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          BlocBuilder<PersonBloc, PersonState>(
                            buildWhen: (context, state) {
                              return state is PersonGalleryLoadedState;
                            },
                            builder: (context, state) {
                              if (state is PersonGalleryLoadedState) {
                                return SizedBox(
                                  height: 210,
                                  child: ListView.builder(
                                    itemCount: state.data.length,
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        height: 200,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w1280${state.data[index].filePath}',
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
