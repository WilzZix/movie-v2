import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/application/actors/actors_bloc.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/routes/go_router/go_router.dart';

import 'application/auth/auth_bloc.dart';
import 'application/movies_blocs/movies/movies_bloc.dart';
import 'application/movies_blocs/see_all_movies/see_all_movies_bloc.dart';
import 'core/network_provider.dart';
import 'core/utils/colors.dart';
import 'data/datasources/local_data_source/shared_preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NetworkProvider.initApp();
  Bloc.observer = MyGlobalObserver();
  await SharedPreferenceService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesBloc()..add(GetTopRatedMoviesEvent(1)),
        ),
        BlocProvider(
          create: (context) => ActorsBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckUserLogInStatus()),
        ),
        BlocProvider(create: (context) => SeeAllMoviesBloc())
      ],
      child: MaterialApp.router(
        color: Colors.black,
        routerConfig: MediaQuery.of(context).size.width >= 1280
            ? AppRouter().tabletRouter
            : AppRouter().router,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelStyle: Typographies.bodyLargeSemiBold.copyWith(
              color: MainPrimaryColor.primary500,
            ),
            unselectedLabelStyle: Typographies.bodyLargeSemiBold,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: const Color(0xD9181A20),
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              color: MainPrimaryColor.primary500,
            ),
            unselectedIconTheme: IconThemeData(
              color: GreyScale.grayScale500,
            ),
            unselectedItemColor: GreyScale.grayScale500,
            selectedItemColor: MainPrimaryColor.primary500,
            selectedLabelStyle: Typographies.bodyXSmallSemiBold
                .copyWith(color: MainPrimaryColor.primary500),
            unselectedLabelStyle: Typographies.bodyXSmallSemiBold,
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: GreyScale.grayScale100,
            focusColor: const Color(0xFFedf3ff),
            hintStyle: Typographies.bodyMediumRegular,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            outlineBorder: const BorderSide(),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MainPrimaryColor.primary500),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

class MyGlobalObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
