import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/core/utils/icons/icons.dart';

import 'components/search_bar_component.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool donotScroll = false;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(searchMovie);
    scrollController.addListener(_loadMore);
    BlocProvider.of<MoviesBloc>(context).add(GetPreviousSearchResult());
  }

  void searchMovie() {
    donotScroll = false;
    if (controller.text.isNotEmpty) {
      BlocProvider.of<MoviesBloc>(context)
          .add(SearchMovieEvent(controller.text));
    } else {
      BlocProvider.of<MoviesBloc>(context).add(GetPreviousSearchResult());
    }
    setState(() {});
  }

  void cleanSearch() {
    controller.clear();
    BlocProvider.of<MoviesBloc>(context).add(GetPreviousSearchResult());
  }

  void _loadMore() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !donotScroll) {
      BlocProvider.of<MoviesBloc>(context).add(LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarComponent(),
        actions: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFedf3ff),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: AppIcons.icFilter),
          )
        ],
      ),
    );
  }
}
