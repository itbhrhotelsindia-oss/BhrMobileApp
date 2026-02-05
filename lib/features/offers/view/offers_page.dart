import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/offers_bloc.dart';
import '../bloc/offers_event.dart';
import '../bloc/offers_state.dart';
import '../model/offer_model.dart';
import '../repository/offers_repository.dart';
import 'package:bhrhotel/core/api_client.dart';
import '../../../core/theme/app_colors.dart';
import 'package:bhrhotel/app/app_shell.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OffersBloc(
        OffersRepository(ApiClient("https://hotel-backend-nq72.onrender.com")),
      )..add(LoadOffers()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.darkGold1,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Exclusive Offers",
            style: TextStyle(
              fontSize: 22,
              color: AppColors.darkGold1,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<OffersBloc, OffersState>(
          builder: (context, state) {
            if (state is OffersLoading || state is OffersInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OffersError) {
              return Center(child: Text(state.message));
            }

            if (state is OffersLoaded) {
              return _OffersGrid(offers: state.offers);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _OffersGrid extends StatelessWidget {
  final List<OfferModel> offers;

  const _OffersGrid({required this.offers});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final columns = width > 1000
        ? 3
        : width > 700
        ? 2
        : 1;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        itemCount: offers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (_, i) {
          final offer = offers[i];

          return Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE
                Image.network(
                  offer.img,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// CONTENT
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        offer.desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Text(
                        "Validity: ${offer.validity}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 22),

                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGold1,
                          ),
                          onPressed: () {},
                          child: Text(
                            offer.loginBtn,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
