class ERP {
  final String fare;
  final String day;
  final String starttime;
  final String endtime;
  final String zone;
  ERP({this.fare, this.day, this.starttime, this.endtime, this.zone});

  ERP.fromJson(Map<String, dynamic> json)
      : fare = json['ChargeAmount'],
        day = json['DayType'],
        starttime = json['StartTime'],
        endtime = json['EndTime'],
        zone = json['ZoneID'];
}
