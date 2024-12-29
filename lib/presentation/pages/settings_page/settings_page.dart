import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/application/auth/auth_bloc.dart';
import 'package:movie/utils/typography.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CheckUserLogInStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AccountIdTook) {
          BlocProvider.of<AuthBloc>(context).add(CheckUserLogInStatus());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: const Icon(Icons.menu),
          actions: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is UserLoginStatus && state.loggedIn) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Log out',
                        style: AppTypography.sampleText,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is RequestTokenInProgress) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is UserLoginStatus && !state.loggedIn) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(GetRequestTokenEvent());
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      shape: BoxShape.rectangle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Sign in with TMDB',
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.network(
                              'https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_1-5bdc75aaebeb75dc7ae79426ddd9be3b2be1e342510f8202baf6bffa71d7f5c4.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.language),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Language',
                            style: AppTypography.sampleText
                                .copyWith(color: Colors.grey),
                          ),
                          const Spacer(),
                          Text(
                            'English',
                            style: AppTypography.sampleText
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
