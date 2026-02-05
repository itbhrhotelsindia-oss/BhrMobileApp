// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../bloc/booking_bloc.dart';
// import 'counter_field.dart';
// import 'date_picker_field.dart';
// import 'booking_button.dart';
//
// class BookingModal {
//   static void open(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius:
//         BorderRadius.vertical(top: Radius.circular(28)),
//       ),
//       builder: (_) {
//         return BlocProvider(
//           create: (_) => BookingBloc(),
//           child: const _BookingContent(),
//         );
//       },
//     );
//   }
// }
//
// class _BookingContent extends StatelessWidget {
//   const _BookingContent();
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<BookingBloc>();
//
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: const [
//           SizedBox(height: 20),
//           Text(
//             "Book Your Stay",
//             style: TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 30),
//           DatePickerField(),
//           CounterField(title: "Rooms", type: CounterType.rooms),
//           CounterField(title: "Adults", type: CounterType.adults),
//           CounterField(title: "Children", type: CounterType.children),
//           SizedBox(height: 30),
//           BookingButton(),
//           SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }
