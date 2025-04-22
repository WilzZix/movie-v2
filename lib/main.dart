import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
      ],
      child: MaterialApp.router(
        color: Colors.black,
        routerConfig: AppRouter().router,
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
            dragHandleColor: GreyScale.grayScale200,
            backgroundColor: const Color(0xFFFEFEFE),
          ),
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
