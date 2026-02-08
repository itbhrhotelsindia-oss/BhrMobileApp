import '../../../core/api_client.dart';
import '../model/room_type_model.dart';
import '../model/room_type_model.dart';
import '../bloc/booking_state.dart';
import '../../our_hotels/model/city_model.dart';
import '../../../utils/date_time_convert.dart';

class BookingRepository {
  final ApiClient api;

  BookingRepository(this.api);

  Future<List<CityModel>> getCities() async {
    final res = await api.get("/api/cities/");
    return (res as List).map((e) => CityModel.fromJson(e)).toList();
  }

  Future<List<RoomTypeModel>> getRoomTypes(String hotelId) async {
    final res =
    await api.get("/api/admin/room-types?hotelId=$hotelId");
    return (res as List)
        .map((e) => RoomTypeModel.fromJson(e))
        .toList();
  }

  Future<dynamic> checkAvailability(BookingState state) async {
    return await api.post("/api/public/availability", {
      "hotelId": state.selectedHotelId,
      "roomTypeId": state.selectedRoomType!.id,
      "checkIn": formatDate(state.checkIn!.toIso8601String()),
      "checkOut": formatDate(state.checkOut!.toIso8601String()),
      "roomsRequested": state.rooms,
    });
  }

  Future<Map<String, dynamic>> createBooking(
      Map<String, dynamic> body) async {

    final response = await api.post(
      "/api/public/bookings",
      body,
    );

    return response;
  }

  Future<Map<String, dynamic>> createRazorpayOrder(
      String bookingId) async {
    return await api.post(
      "/api/public/payments/razorpay/order",
      {"bookingId": bookingId},
    );
  }


}
