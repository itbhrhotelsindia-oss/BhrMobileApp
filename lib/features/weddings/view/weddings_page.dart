import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../weddings/widgets/wedding_video_section.dart';
import '../../weddings/widgets/wedding_stats_banner.dart';
import '../../weddings/widgets/wedding_type_slider.dart';
import '../../weddings/widgets/wedding_festivities_section.dart';
import '../../weddings/widgets/wedding_enquiry_form.dart';
import '../../weddings/bloc/weddings_bloc.dart';
import '../../weddings/bloc/weddings_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/app_shell.dart';

class WeddingsPage extends StatelessWidget {
  const WeddingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeddingsBloc, WeddingsState>(
      builder: (context, state) {
        if (state is WeddingsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WeddingsLoaded) {
          final data = state.data;

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
              title: Text(
                  data.title,
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // WeddingVideoSection(
                  //   videoUrl: state.weddings.videoUrl,
                  // ),

                  // WeddingHeaderTitle(title: data.title),

                  // WeddingVideoSection(videoUrl: data.videoUrl),


                  WeddingTypeSlider(
                    title: data.typeOfWeddings.title,
                    description: data.typeOfWeddings.description,
                    items: data.typeOfWeddings.weddingList,
                  ),

                  WeddingFestivitiesSection(
                    festivities: data.festivities,
                  ),

                  WeddingStatsBanner(stats: data.stats),
                  const WeddingEnquiryForm(),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
