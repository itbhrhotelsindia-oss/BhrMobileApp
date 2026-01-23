class PoliciesSection {
  final String checkInTime;
  final String checkOutTime;
  final bool petsAllowed;
  final String cancellationPolicy;

  PoliciesSection({
    required this.checkInTime,
    required this.checkOutTime,
    required this.petsAllowed,
    required this.cancellationPolicy,
  });

  factory PoliciesSection.fromJson(Map<String, dynamic> json) {
    return PoliciesSection(
      checkInTime: json['checkInTime'],
      checkOutTime: json['checkOutTime'],
      petsAllowed: json['petsAllowed'],
      cancellationPolicy: json['cancellationPolicy'],
    );
  }
}
