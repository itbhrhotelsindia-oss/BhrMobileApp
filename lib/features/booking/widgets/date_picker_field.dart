// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../bloc/booking_bloc.dart';
// import '../bloc/booking_event.dart';
// import '../bloc/booking_state.dart';
//
// class DatePickerField extends StatelessWidget {
//   const DatePickerField({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BookingBloc, BookingState>(
//       builder: (context, state) {
//         final checkIn = state.data.checkIn;
//         final checkOut = state.data.checkOut;
//
//         final text = checkIn == null || checkOut == null
//             ? "Select check-in & check-out dates"
//             : "${_fmt(checkIn)}  →  ${_fmt(checkOut)}";
//
//         return ListTile(
//           leading: const Icon(Icons.date_range),
//           title: Text(text),
//           onTap: () async {
//             final range = await showDateRangePicker(
//               context: context,
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(
//                 const Duration(days: 365),
//               ),
//             );
//
//             if (range != null) {
//               context.read<BookingBloc>().add(
//                 UpdateDates(
//                   range.start,
//                   range.end,
//                 ),
//               );
//             }
//           },
//         );
//       },
//     );
//   }
//
//   String _fmt(DateTime d) =>
//       "${d.day}/${d.month}/${d.year}";
// }
