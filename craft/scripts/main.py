import vehicle_stats
import control_stream

def main():
    control = control_stream.ControlStream()
    vstats = vehicle_stats.VehicleStats()
    control.sendTelemetryUpdate(vstats)

if __name__ == "__main__":
    main()
