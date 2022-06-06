import 'package:cargo_bike/src/features/authentication/bloc/auth_bloc.dart';
import 'package:cargo_bike/src/features/history/bloc/history_bloc.dart';
import 'package:cargo_bike/src/features/main/bloc/main_list_bloc.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:cargo_bike/src/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/authentication/auth_screen.dart';
import 'features/home/home_screen.dart';
import 'features/new_delivery/bloc/new_delivery_bloc.dart';
import 'features/settings/bloc/settings_bloc.dart';
import 'features/settings/settings_controller.dart';
import 'features/settings/settings_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>(
              create: (context) => AuthRepository(),
            ),
            RepositoryProvider<DeliveryRepository>(
              create: (context) => DeliveryRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SettingsBloc>(
                  create: (context) =>
                      SettingsBloc(repository: AuthRepository())
                        ..add(GetUserInfoEvent())),
              BlocProvider<HistoryBloc>(
                  create: (context) =>
                      HistoryBloc(repository: DeliveryRepository())),
              BlocProvider<MainListBloc>(
                  create: (context) => MainListBloc(
                      auth: AuthRepository(), repository: DeliveryRepository())
                    ..add(GetAllDeliveries())),
              BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(repository: AuthRepository())
                  ..add(CheckUserStatusEvent()),
              ),
              BlocProvider<NewDeliveryBloc>(
                create: (context) =>
                    NewDeliveryBloc(repository: DeliveryRepository()),
              ),
            ],
            child: AnimatedBuilder(
              animation: widget.settingsController,
              builder: (BuildContext context, Widget? child) {
                return MaterialApp(
                  home: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is RegisterSuccessState) {
                        context.read<SettingsBloc>().add(GetUserInfoEvent());
                        context.read<MainListBloc>().add(GetAllDeliveries());
                        context.read<HistoryBloc>().add(GetHistoryEvent());
                        return HomeScreen(
                            settingsController: widget.settingsController);
                      } else if (state is UnauthenticatedState) {
                        return const AuthScreen();
                      }

                      return const AuthScreen();
                    },
                  ),
                  // Providing a restorationScopeId allows the Navigator built by the
                  // MaterialApp to restore the navigation stack when a user leaves and
                  // returns to the app after it has been killed while running in the
                  // background.
                  restorationScopeId: 'app',

                  // Provide the generated AppLocalizations to the MaterialApp. This
                  // allows descendant Widgets to display the correct translations
                  // depending on the user's locale.
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                    Locale('sr', ''),
                  ],
                  locale: widget.settingsController.locale,
                  // Use AppLocalizations to configure the correct application title
                  // depending on the user's locale.
                  //
                  // The appTitle is defined in .arb files found in the localization
                  // directory.
                  onGenerateTitle: (BuildContext context) =>
                      AppLocalizations.of(context)!.appTitle,

                  // Define a light and dark color theme. Then, read the user's
                  // preferred ThemeMode (light, dark, or system default) from the
                  // SettingsController to display the correct theme.
                  theme: ThemeData(),
                  darkTheme: ThemeData.dark(),
                  themeMode: widget.settingsController.themeMode,

                  // Define a function to handle named routes in order to support
                  // Flutter web url navigation and deep linking.
                  onGenerateRoute: (RouteSettings routeSettings) {
                    return MaterialPageRoute<void>(
                      settings: routeSettings,
                      builder: (BuildContext context) {
                        switch (routeSettings.name) {
                          case SettingsScreen.routeName:
                            return SettingsScreen(
                                controller: widget.settingsController);
                          case HomeScreen.routeName:
                            return HomeScreen(
                                settingsController: widget.settingsController);

                          case AuthScreen.routeName:
                            return const AuthScreen();
                          default:
                            return const AuthScreen();
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
