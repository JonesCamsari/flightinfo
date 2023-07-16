class AllState {
  final String icas24;
  final String? callsign;
  final String originCountry;
  final int? timePosition;
  final int lastContact;
  final double? longitude;
  final double? latitude;
  final double? baroAltitude;
  final bool onGround;
  final double? velocity;
  final double? trueTrack;
  final double? verticalRate;
  final List<int>? sensors;
  final double? geoAltitude;
  final String? squawk;
  final bool spi;
  final int positionSource;
  final int category;

  AllState({
    required this.icas24,
    this.callsign,
    required this.originCountry,
    this.timePosition,
    required this.lastContact,
    this.longitude,
    this.latitude,
    this.baroAltitude,
    required this.onGround,
    this.velocity,
    this.trueTrack,
    this.verticalRate,
    this.sensors,
    this.geoAltitude,
    this.squawk,
    required this.spi,
    required this.positionSource,
    required this.category,
  });

  factory AllState.fromJson(List<dynamic> json) {
    return AllState(
      icas24: json[0] as String,
      callsign: json[1] as String?,
      originCountry: json[2] as String,
      timePosition: json[3] != null ? (json[3] as int?) ?? 0 : null,
      lastContact: json[4] as int,
      longitude: (json[5] != null && json[5] is double) ? json[5] as double : null,
      latitude: (json[6] != null && json[6] is double) ? json[6] as double : null,
      baroAltitude: (json[7] != null && json[7] is double) ? json[7] as double : null,
      onGround: json[8] as bool,
      velocity: (json[9] != null && json[9] is double) ? json[9] as double : null,
      trueTrack: (json[10] != null && json[10] is double) ? json[10] as double : null,
      verticalRate: (json[11] != null && json[11] is double) ? json[11] as double : null,
      sensors: json[12] != null ? List<int>.from(json[12]) : null,
      geoAltitude: (json[13] != null && json[13] is double) ? json[13] as double : null,
      squawk: json[14] as String?,
      spi: json[15] as bool,
      positionSource: json[16] as int,
      category: json.length > 17 && json[17] != null ? json[17] as int : 0,
    );
  }

}
