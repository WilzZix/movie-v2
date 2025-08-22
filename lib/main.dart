import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:movie/core/utils/application_theme.dart';
import 'package:movie/presentation/application/actors/actors_bloc.dart';
import 'package:movie/presentation/application/auth/auth_bloc.dart';
import 'package:movie/presentation/application/core_cubit.dart';
import 'package:movie/presentation/application/firebase_auth/firebase_auth_bloc.dart';
import 'package:movie/presentation/application/movies_blocs/movies/movies_bloc.dart';
import 'package:movie/presentation/application/movies_blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/presentation/application/movies_blocs/see_all_movies/see_all_movies_bloc.dart';
import 'package:movie/presentation/routes/go_router/go_router.dart';


import 'core/network_provider.dart';
import 'data/datasources/local_data_source/shared_preference_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  NetworkProvider.initApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyGlobalObserver();
  await FirebaseAnalytics.instance.logAppOpen();
  await SharedPreferenceService.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData appTheme = ApplicationTheme.light;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc()..add(GetTopRatedMoviesEvent(1)),
        ),
        BlocProvider<ActorsBloc>(
          create: (context) => ActorsBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckUserLogInStatus()),
        ),
        BlocProvider<SeeAllMoviesBloc>(create: (context) => SeeAllMoviesBloc()),
        BlocProvider<FirebaseAuthBloc>(create: (context) => FirebaseAuthBloc()),
        BlocProvider<RecommendedMoviesCubit>(
            create: (context) => RecommendedMoviesCubit()),
        BlocProvider<CoreCubit>(
            create: (context) => CoreCubit()..getAppTheme()),
      ],
      child: BlocBuilder<CoreCubit, CoreState>(
        builder: (context, state) {
          if (state is ApplicationThemeChanged) {
            appTheme = state.themeData;
          }
          if (state is ApplicationThemeLoaded) {
            appTheme = state.themeData;
          }
          return MaterialApp.router(
            routerConfig: _appRouter.router,
            theme: appTheme,
          );
        },
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
