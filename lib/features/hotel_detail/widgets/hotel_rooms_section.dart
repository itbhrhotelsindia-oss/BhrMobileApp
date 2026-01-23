import 'package:flutter/material.dart';
import '../model/hotel_detail_model.dart';
import '../model/room_model.dart';

class HotelRoomsSection extends StatelessWidget {
  final List<RoomModel> rooms;

  const HotelRoomsSection({
    super.key,
    required this.rooms,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Available Rooms",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ...rooms.map((room) => _RoomCard(room)).toList(),

        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// ROOM CARD
/// ------------------------------------------------------------
class _RoomCard extends StatelessWidget {
  final RoomModel room;

  const _RoomCard(this.room);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ROOM IMAGE
            if (room.images.isNotEmpty)
              Image.network(
                room.images.first,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, loading) {
                  if (loading == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (_, __, ___) =>
                const SizedBox(
                  height: 200,
                  child: Icon(Icons.broken_image),
                ),
              ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ROOM NAME
                  Text(
                    room.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// DESCRIPTION
                  Text(
                    room.description,
                    style: const TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// AMENITIES
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: room.amenities
                        .map(
                          (a) => Chip(
                        label: Text(
                          a,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor:
                        Colors.amber.withOpacity(0.15),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

