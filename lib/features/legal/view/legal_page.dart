import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/legal_bloc.dart';
import '../bloc/legal_event.dart';
import '../bloc/legal_state.dart';
import '../repository/legal_repository.dart';
import '../../../core/theme/app_colors.dart';
import 'package:bhrhotel/app/app_shell.dart';

class LegalPage extends StatelessWidget {
  final String apiPath;
  final String from;

  const LegalPage({super.key, required this.apiPath, required this.from});

  @override
  Widget build(BuildContext context) {
    var title = "";
    if (from == "termsAndConditions")
      title = "Terms And Conditions";
    else if (from == "refundPolicy")
      title = "Refund and Cancellation";
    else if (from == "privacyPolicy")
      title = "Privacy Policy";
    else
      title = "Legal";

    return BlocProvider(
      create: (_) =>
          LegalBloc(context.read<LegalRepository>())
            ..add(LoadLegalPage(apiPath)),
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
          title: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: AppColors.darkGold1,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<LegalBloc, LegalState>(
          builder: (context, state) {
            if (state is LegalLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LegalError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is LegalLoaded) {
              final data = state.data;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 60),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   data.title,
                        //   style: const TextStyle(
                        //     fontSize: 32,
                        //     fontWeight: FontWeight.w700,
                        //     color: Color(0xFF3B2F1E),
                        //   ),
                        // ),
                        if (data.lastUpdated != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            "Last updated: ${data.lastUpdated}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],

                        const SizedBox(height: 30),

                        ...data.content.map(
                          (section) => Padding(
                            padding: const EdgeInsets.only(bottom: 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  section.heading,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF8B5E1A),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  section.body,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.7,
                                    color: Color(0xFF444444),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
