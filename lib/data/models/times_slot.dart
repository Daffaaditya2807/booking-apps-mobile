class TimeSlot {
  final String time;
  final int remainingSlots;
  final bool available;

  TimeSlot({
    required this.time,
    required this.remainingSlots,
    required this.available,
  });
}

class LoketInfo {
  final int totalLoket;
  final int capacityPerLoket;
  final int totalCapacity;

  LoketInfo({
    required this.totalLoket,
    required this.capacityPerLoket,
    required this.totalCapacity,
  });
}
