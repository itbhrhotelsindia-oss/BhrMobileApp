import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';
import 'payment_at_hotel_page.dart';
import 'payment_success_page.dart';
import 'payment_failure_page.dart';

class BookingConfirmationPage extends StatefulWidget {
  final Map<String, dynamic> booking;
  final Map<String, dynamic> bookingDetail;

  const BookingConfirmationPage({
    super.key,
    required this.booking,
    required this.bookingDetail,
  });

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState
    extends State<BookingConfirmationPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      _onPaymentSuccess,
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      _onPaymentFailure,
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  /// 🔓 Open Razorpay checkout
  void _openRazorpay(Map<String, dynamic> order) {
    final options = {
      'key': order['keyId'],
      'amount': order['amount'], // MUST be int (paise)
      'currency': order['currency'],
      'name': 'BHR Hotels India',
      'description': 'Hotel Booking Payment',
      'order_id': order['orderId'],
      'prefill': {
        'name': widget.booking['guestName'] ?? "Guest",
        'email': widget.booking['guestEmail'] ?? "guest@bhrhotelsindia.com",
        'contact': widget.booking['guestPhone'] ?? "9999999999",
      },
      'theme': {
        'color': '#6b2d2d',
      },
    };

    debugPrint("Opening Razorpay: $options");
    _razorpay.open(options);
  }



  /// ✅ Payment success
  void _onPaymentSuccess(PaymentSuccessResponse response) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PaymentSuccessPage(),
      ),
    );
  }

  /// ❌ Payment failed OR dismissed
  void _onPaymentFailure(PaymentFailureResponse response) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PaymentFailurePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;
    final detail = widget.bookingDetail;

    return BlocListener<BookingBloc, BookingState>(
      listenWhen: (prev, curr) =>
      prev.paymentOrder != curr.paymentOrder,
          listener: (context, state) {
        /// Razorpay order created → open checkout
        if (state.paymentOrder != null) {
          _openRazorpay(state.paymentOrder!);

          context.read<BookingBloc>().add(ClearPaymentOrder());
        }

        /// Order creation failed
        if (state.error == "PAYMENT_ORDER_FAILED") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const PaymentFailurePage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Booking Confirmation")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// SUCCESS BOX
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Text(
                      "🎉 Booking Created Successfully",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your booking is currently PENDING.\nPlease complete payment to confirm.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// DETAILS
              _detail("Booking ID", booking['bookingId']),
              _detail("Hotel", booking['hotelId']),
              _detail("Room Type", detail['roomTypeName']),
              _detail("Check-In", detail['checkIn']),
              _detail("Check-Out", detail['checkOut']),
              _detail("Rooms", detail['roomsRequested']),

              const Divider(height: 32),

              _detail(
                "Total Amount",
                "₹${booking['totalAmount']}",
                bold: true,
              ),

              const Spacer(),

              /// PAY ONLINE
              BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGold1,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: state.creatingPayment
                        ? null
                        : () {
                      context.read<BookingBloc>().add(
                        CreateRazorpayOrder(
                          booking['bookingId'],
                        ),
                      );
                    },
                    child: state.creatingPayment
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      "Pay ₹${booking['totalAmount']} Here",
                      style:
                      const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              /// PAY AT HOTEL
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentAtHotelPage(
                        amount: booking['totalAmount'],
                      ),
                    ),
                  );
                },
                child: Text(
                  "Pay ₹${booking['totalAmount']} At Hotel",
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail(String label, dynamic value,
      {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value?.toString() ?? "-",
            style: TextStyle(
              fontWeight:
              bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
