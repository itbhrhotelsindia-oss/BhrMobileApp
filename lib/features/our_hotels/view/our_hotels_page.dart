import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/our_hotels_bloc.dart';
import '../bloc/our_hotels_event.dart';
import '../bloc/our_hotels_state.dart';
import '../widgets/hotels_grid.dart';

class OurHotelsPage extends StatelessWidget {
  const OurHotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) =>
      ctx.read<OurHotelsBloc>()..add(LoadOurHotels()),
      child: Scaffold(
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
                Text(
                  state.data!.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

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
      ),
    );
  }
}
