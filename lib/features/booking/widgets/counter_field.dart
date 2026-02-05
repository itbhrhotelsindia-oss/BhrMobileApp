// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../bloc/booking_bloc.dart';
// import '../bloc/booking_event.dart';
// import '../bloc/booking_state.dart';
//
// enum CounterType { rooms, adults, children }
//
// class CounterField extends StatelessWidget {
//   final String title;
//   final CounterType type;
//
//   const CounterField({
//     super.key,
//     required this.title,
//     required this.type,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BookingBloc, BookingState>(
//       builder: (context, state) {
//         int value;
//
//         switch (type) {
//           case CounterType.rooms:
//             value = state.data.rooms;
//             break;
//           case CounterType.adults:
//             value = state.data.adults;
//             break;
//           case CounterType.children:
//             value = state.data.children;
//             break;
//         }
//
//         return ListTile(
//           title: Text(title),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _btn(
//                 icon: Icons.remove,
//                 onTap: value > 0
//                     ? () => _update(context, value - 1)
//                     : null,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Text(
//                   value.toString(),
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//               _btn(
//                 icon: Icons.add,
//                 onTap: () => _update(context, value + 1),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _update(BuildContext context, int v) {
//     final bloc = context.read<BookingBloc>();
//
//     switch (type) {
//       case CounterType.rooms:
//         bloc.add(UpdateRooms(v));
//         break;
//       case CounterType.adults:
//         bloc.add(UpdateAdults(v));
//         break;
//       case CounterType.children:
//         bloc.add(UpdateChildren(v));
//         break;
//     }
//   }
//
//   Widget _btn({
//     required IconData icon,
//     VoidCallback? onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(50),
//       child: Padding(
//         padding: const EdgeInsets.all(6),
//         child: Icon(icon),
//       ),
//     );
//   }
// }
