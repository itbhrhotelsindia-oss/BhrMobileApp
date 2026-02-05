// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../bloc/booking_bloc.dart';
// import '../bloc/booking_state.dart';
// import '../view/booking_results_page.dart';
//
// class BookingRedirectListener extends StatelessWidget {
//   final Widget child;
//
//   const BookingRedirectListener({
//     super.key,
//     required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<BookingBloc, BookingState>(
//       listenWhen: (prev, curr) =>
//       prev.redirectUrl != curr.redirectUrl &&
//           curr.redirectUrl != null,
//       listener: (context, state) {
//         Navigator.of(context).pop(); // close dialog
//
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) => BookingResultsPage(
//               redirectUrl: state.redirectUrl!,
//             ),
//           ),
//         );
//       },
//       child: child,
//     );
//   }
// }
