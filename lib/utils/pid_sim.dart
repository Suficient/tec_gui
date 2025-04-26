class PIDController {
  double Kp;
  double Ki;
  double Kd;
  double setpoint;
  double max;
  double min;
  double integral = 0.0;
  double previousError = 0.0;
  double? previousTime;

  PIDController(
    this.Kp,
    this.Ki,
    this.Kd,
    this.setpoint, {
    double maxOutput = double.infinity,
    double minOutput = double.negativeInfinity,
  })  : max = maxOutput,
        min = minOutput;

  bool update(double currentTemp, double currentTime) {
    if (previousTime == null) {
      previousTime = currentTime;
      return false;
    }

    double dt = currentTime - previousTime!;
    if (dt <= 0) {
      return false;
    }

    double error = currentTemp - setpoint; // Positive = too hot
    integral += error * dt;
    
    // anti-windup
    integral = integral.clamp(min * 0.1, max * 0.1);
    
    double derivative = (error - previousError) / dt;
    double output = (Kp * error) + (Ki * integral) + (Kd * derivative);
    
    previousError = error;
    previousTime = currentTime;

    return output > 0; // Cooler ON when output > 0
  }
}

double dTdt(double T, bool coolerOn, double P, double thermalMass, 
           double h, double A, [double tAmbient = 35.0]) {
  double qCooler = coolerOn ? -P : 0.0;
  double QAmbient = h * A * (tAmbient - T);
  return (qCooler + QAmbient) / thermalMass;
}

Map<String, dynamic> calcTemperatureChange({
  required double dt,
  required PIDController pid,
  required double thermalMass,
  required double h,
  required double A,
  required double P,
  required double tAmbient,
  required double tau,
  required double currentTemp,
  required double currentTime,
  required double qCooler,
}) {
  // Get PID decision
  bool coolerOn = pid.update(currentTemp, currentTime);
  
  // Update cooler power with inertia
  double targetQ = coolerOn ? -P : 0.0;
  qCooler += (targetQ - qCooler) * dt / tau;
  
  // Calculate temperature change using RK4
  double k1 = dTdt(currentTemp, coolerOn, P, thermalMass, h, A, tAmbient) * dt;
  double k2Temp = currentTemp + 0.5 * k1;
  double k2 = dTdt(k2Temp, coolerOn, P, thermalMass, h, A, tAmbient) * dt;
  double k3Temp = currentTemp + 0.5 * k2;
  double k3 = dTdt(k3Temp, coolerOn, P, thermalMass, h, A, tAmbient) * dt;
  double k4Temp = currentTemp + k3;
  double k4 = dTdt(k4Temp, coolerOn, P, thermalMass, h, A, tAmbient) * dt;
  currentTemp += (k1 + 2 * k2 + 2 * k3 + k4) / 6;

  return {
    'currentTime': currentTime,
    'currentTemp': currentTemp,
    'coolerOn': coolerOn,
    'qCooler': qCooler,
  };
}