import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../models/home_model.dart';
import '../widgets/header_bar.dart';
import '../widgets/hero_slider.dart';
import '../widgets/brand_banner.dart';
import '../widgets/brands_section.dart';
import '../widgets/events_section.dart';
import '../widgets/footer.dart';
import 'package:bhrhotel/features/booking/widgets/booking_modal.dart';
import 'package:bhrhotel/core/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null) {
          return Scaffold(
            body: Center(child: Text(state.error!)),
          );
        }

        if (state.data == null) {
          return const Scaffold(
            body: Center(child: Text("No home data")),
          );
        }

        final HomeModel home = state.data!;

        return Scaffold(
          drawer: const AppDrawer(),

          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              "BHR Hotels",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              switch (index) {
                // case 0:
                //   return HeaderBar(
                //   scrolled: true,
                //   onBook: () {
                //     BookingModal.open(context);
                //   },
                // );
                case 0:
                  return HeroSlider(images: home.heroImages);

                case 1:
                  return BrandBannerWidget(
                    banner: home.brandBanner,
                  );

                case 2:
                  return BrandsSection(
                    section: home.brandSection,
                  );

                case 3:
                  return EventsSection(
                    section: home.eventsSection,
                  );

                case 4:
                  return FooterWidget(
                    contact: home.contact,
                  );

                default:
                  return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
