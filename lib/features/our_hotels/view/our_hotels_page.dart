import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/our_hotels_bloc.dart';
import '../bloc/our_hotels_event.dart';
import '../bloc/our_hotels_state.dart';
import '../widgets/hotels_grid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/app_shell.dart';

class OurHotelsPage extends StatelessWidget {
  const OurHotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.darkGold1,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const AppShell(), // ✅ home page
              ),
                  (route) => false, // removes all previous routes
            );
          },
        ),
        title: const Text(
          "Our Destinations",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGold1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: BlocBuilder<OurHotelsBloc, OurHotelsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.data == null) {
            return const Center(
              child: Text("No destinations found"),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 20),

              Text(
                state.data!.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 40),

              HotelsGrid(cities: state.cities),
            ],
          );
        },
      ),
    );
  }
}
