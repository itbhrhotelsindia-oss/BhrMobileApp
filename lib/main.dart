import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/api_client.dart';
import 'features/hotel_detail/repository/hotel_detail_repository.dart';

import 'features/home/bloc/home_bloc.dart';
import 'features/home/bloc/home_event.dart';
import 'features/home/repository/home_repository.dart';

import 'features/header/bloc/header_bloc.dart';
import 'features/header/bloc/header_event.dart';
import 'features/header/repository/header_repository.dart';
import 'features/our_hotels/bloc/our_hotels_bloc.dart';
import 'features/our_hotels/bloc/our_hotels_event.dart';
import 'features/our_hotels/repository/our_hotels_repository.dart';

import 'app/app_shell.dart';
import 'core/theme/app_theme.dart';

void main() {
  const baseUrl = "https://hotel-backend-nq72.onrender.com";

  final apiClient = ApiClient(baseUrl);
  final hotelDetailRepository = HotelDetailRepository(apiClient);

  final homeRepository = HomeRepository(apiClient);
  final headerRepository = HeaderRepository(apiClient);
  final ourHotelsRepository = OurHotelsRepository(apiClient);

  runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: apiClient),
          RepositoryProvider.value(value: hotelDetailRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            /// HOME DATA
            BlocProvider<HomeBloc>(
              create: (_) =>
              HomeBloc(homeRepository)..add(LoadHomeEvent()),
            ),

            /// CITY DROPDOWN
            BlocProvider<HeaderBloc>(
              create: (_) =>
              HeaderBloc(headerRepository)..add(LoadCities()),
            ),

            /// Our Hotels
            BlocProvider<OurHotelsBloc>(
              create: (_) => OurHotelsBloc(
                ourHotelsRepository,
              )..add(LoadOurHotels()),
            ),
          ],
          child: const MyApp(),
        )
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: AppTheme.lightTheme,
      // home: const AppShell(),
      debugShowCheckedModeBanner: false,
      title: "Hotel App",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
      ),

      /// ✅ BOTTOM NAVIGATION SHELL
      home: const AppShell(),
    );
  }
}
