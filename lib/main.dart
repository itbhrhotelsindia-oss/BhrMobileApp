import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/api_client.dart';
import 'features/hotel_detail/repository/hotel_detail_repository.dart';

import 'features/home/bloc/home_bloc.dart';
import 'features/home/bloc/home_event.dart';
import 'features/home/repository/home_repository.dart';

// import 'features/header/bloc/header_bloc.dart';
// import 'features/header/bloc/header_event.dart';
// import 'features/header/repository/header_repository.dart';
import 'features/our_hotels/bloc/our_hotels_bloc.dart';
import 'features/our_hotels/bloc/our_hotels_event.dart';
import 'features/our_hotels/repository/our_hotels_repository.dart';

import 'features/weddings/bloc/weddings_bloc.dart';
import 'features/weddings/bloc/weddings_event.dart';
import 'features/weddings/repository/weddings_repository.dart';

import 'features/event/bloc/events_bloc.dart';
import 'features/event/bloc/events_event.dart';
import 'features/event/repository/events_repository.dart';

import 'features/booking/bloc/booking_bloc.dart';
import 'features/booking/bloc/booking_event.dart';
import 'features/booking/repository/booking_repository.dart';

import 'features/legal/repository/legal_repository.dart';

import 'app/app_shell.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'core/view/about_page.dart';
import 'core/view/contact_page.dart';
import 'core/view/careers_page.dart';
import 'core/view/why_book_direct_page.dart';
import 'core/view/manage_booking_page.dart';
import 'features/legal/view/terms_and_conditions_page.dart';
import 'features/legal/view/privacy_policy_page.dart';
import 'features/legal/view/refund_policy_page.dart';
import 'features/blog/view/blog_page.dart';
import 'features/offers/view/offers_page.dart';

void main() {
  const baseUrl = "https://hotel-backend-nq72.onrender.com";

  final apiClient = ApiClient(baseUrl);
  final hotelDetailRepository = HotelDetailRepository(apiClient);

  final homeRepository = HomeRepository(apiClient);
  // final headerRepository = HeaderRepository(apiClient);
  final ourHotelsRepository = OurHotelsRepository(apiClient);
  final weddingsRepository = WeddingsRepository(apiClient);
  final eventRepository = EventsRepository(apiClient);
  final bookingRepository = BookingRepository(apiClient);

  runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: apiClient),
          RepositoryProvider.value(value: hotelDetailRepository),
          RepositoryProvider(
            create: (context) =>
                LegalRepository(context.read<ApiClient>()),
          ),
          RepositoryProvider<BookingRepository>.value(
            value: bookingRepository,
          ),

        ],
        child: MultiBlocProvider(
          providers: [
            /// HOME DATA
            BlocProvider<HomeBloc>(
              create: (_) =>
              HomeBloc(homeRepository)..add(LoadHomeEvent()),
            ),

            /// CITY DROPDOWN
            // BlocProvider<HeaderBloc>(
            //   create: (_) =>
            //   HeaderBloc(headerRepository)..add(LoadCities()),
            // ),

            /// Our Hotels
            BlocProvider<OurHotelsBloc>(
              create: (_) => OurHotelsBloc(
                ourHotelsRepository,
              )..add(LoadOurHotels()),
            ),

            /// Weddings
            BlocProvider<WeddingsBloc>(
              create: (_) => WeddingsBloc(
                weddingsRepository,
              )..add(LoadWeddings()),
            ),

            /// Events
            BlocProvider<EventsBloc>(
              create: (_) => EventsBloc(
                eventRepository,
              )..add(LoadEventsPage()),
            ),

            /// Booking
            BlocProvider<BookingBloc>(
              create: (_) => BookingBloc(
                bookingRepository,
              )..add(LoadCities()),
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
      routes: {
        "/blog": (_) => const BlogPage(),
        "/offers": (_) => const OffersPage(),
        "/about": (_) => const AboutPage(),
        "/contact": (_) => const ContactPage(),
        "/careers": (_) => const CareersPage(),
        "/whyBookDirect": (_) => const WhyBookDirectPage(),
        "/manageBooking": (_) => const ManageBookingPage(),
        "/termsAndCondition": (_) => const TermsAndConditionsPage(),
        "/privacyPolicy": (_) => const PrivacyPolicyPage(),
        "/refundAndCancellation": (_) => const RefundPolicyPage(),
      },
      title: "Hotel App",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.lightGold,
        scaffoldBackgroundColor: Colors.white,
      ),

      /// ✅ BOTTOM NAVIGATION SHELL
      home: const AppShell(),
    );
  }
}
