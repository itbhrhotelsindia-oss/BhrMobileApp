import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api_client.dart';
import '../bloc/partner_bloc.dart';
import '../bloc/partner_event.dart';
import '../bloc/partner_state.dart';
import '../repository/partner_repository.dart';
import '../widgets/partner_form.dart';
import 'package:bhrhotel/core/theme/app_colors.dart';
import 'package:bhrhotel/app/app_shell.dart';

class PartnerPage extends StatelessWidget {
  const PartnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PartnerBloc(
        PartnerRepository(
          ApiClient("https://hotel-backend-nq72.onrender.com"),
        ),
      )..add(LoadCities()),
      child: Scaffold(
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
          title: const Text("Partner With Us"),
          centerTitle: true,
        ),
        body: BlocConsumer<PartnerBloc, PartnerState>(
          listener: (context, state) {
            if (state is PartnerSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const AppShell(), // ✅ home page
                ),
                    (route) => false, // removes all previous routes
              );
            }

            if (state is PartnerError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is PartnerLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CitiesLoaded) {
              return PartnerForm(cities: state.cities);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
