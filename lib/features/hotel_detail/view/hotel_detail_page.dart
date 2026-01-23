import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/hotel_detail_bloc.dart';
import '../bloc/hotel_detail_event.dart';
import '../bloc/hotel_detail_state.dart';
import '../widgets/book_now_bottom_bar.dart';
import '../widgets/hotel_image_slider.dart';
import '../widgets/hotel_info_section.dart';
import '../widgets/hotel_rooms_section.dart';
import '../widgets/hotel_amenities_section.dart';
import '../repository/hotel_detail_repository.dart';

class HotelDetailPage extends StatelessWidget {
  final String hotelId;

  const HotelDetailPage({
    super.key,
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HotelDetailBloc(
        context.read<HotelDetailRepository>(),
      )..add(
        LoadHotelDetail(hotelId),
      ),
      child: Scaffold(
        body: BlocBuilder<HotelDetailBloc, HotelDetailState>(
          builder: (context, state) {
            if (state is HotelDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HotelDetailLoaded) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HotelImageSlider(
                          images: state.hotel.hotelSlider.images,
                        ),

                        HotelInfoSection(
                          hotel: state.hotel,
                        ),

                        HotelRoomsSection(
                          rooms: state.hotel.roomsSection.rooms,
                        ),

                        HotelAmenitiesSection(
                          title: state.hotel.amenitiesSection.title,
                          amenities: state.hotel.amenitiesSection.amenities,
                        ),
                      ],
                    ),
                  ),

                  BookNowBottomBar(
                    hotel: state.hotel,
                  ),
                ],
              );
            }

            if (state is HotelDetailError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}


