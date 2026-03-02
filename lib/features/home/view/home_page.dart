import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
import 'package:bhrhotel/core/widgets/app_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.7,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  Future<void> openWhatsApp() async {

    String phoneNumber = "919211283334";
    String message = "Hello! Get instant booking support from our hotel team!";

    final url = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

          body: Stack(
            children: [

              /// Main Content
              ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {

                  switch (index) {

                    case 0:
                      return HeroSlider(images: home.heroImages);

                    case 1:
                      return BrandBannerWidget(
                        banner: home.brandBanner,
                        contact: home.contact,
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

              /// WhatsApp Blinking Button
              Positioned(
                bottom: 20,
                right: 20,
                child: ScaleTransition(
                  scale: _controller,
                  child: GestureDetector(
                    onTap: openWhatsApp,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        color: Color(0xFF25D366),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black26,
                            offset: Offset(0,4),
                          )
                        ],
                      ),
                      child: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}