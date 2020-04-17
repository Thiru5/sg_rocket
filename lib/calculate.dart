class Calculation {
  double calculate(double distance) {
    double fare = 92.0 + distance + 3.2 * 10.0;
    if (fare < 92) {
      fare = 0.92;
    } else if (fare >= 217) {
      fare = 2.17;
    }
    {}
    return fare;
  }

  double calculateGojek(double distance) {
    double fare = 4.10 + distance / 1000 * 0.675;
    return fare;
  }

  double calculateGrab(double distance, double duration) {
    double fare = 2.5 + (distance / 1000 * 0.5) + (duration / 60 * 0.16);
    if (fare < 6.00) {
      fare = 6.00;
    }
    return fare;
  }
}