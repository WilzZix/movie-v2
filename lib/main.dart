import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:movie/application/actors/actors_bloc.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/routes/go_router/go_router.dart';

import 'application/auth/auth_bloc.dart';
import 'application/movies_blocs/movies/movies_bloc.dart';
import 'application/movies_blocs/see_all_movies/see_all_movies_bloc.dart';
import 'core/network_provider.dart';
import 'core/utils/colors.dart';
import 'data/datasources/local_data_source/shared_preference_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
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
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
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
            fillColor: Colors.black,
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            outlineBorder: const BorderSide(
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
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
