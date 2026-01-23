import 'dart:convert';
import '../../../core/api_client.dart';
import '../model/hotel_detail_model.dart';

class HotelDetailRepository {
  final ApiClient api;

  HotelDetailRepository(this.api);

  Future<HotelDetailModel> loadHotel(String hotelId) async {
    final json = await api.get("/api/hotel-details/$hotelId");
    return HotelDetailModel.fromJson(json);
  }
}

