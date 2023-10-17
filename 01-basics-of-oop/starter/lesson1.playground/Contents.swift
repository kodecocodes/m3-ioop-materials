
import PlaygroundSupport
import CoreLocation

let melbourne = CLLocation(latitude: -37.840935, longitude: 144.946457)
let ballarat = CLLocation(latitude: -37.5622, longitude: 143.8503)

// Procedural programming function
// TODO: Add more inputs
func computeTravelTime(from: CLLocation, to: CLLocation) -> Double {
  // compute point-to-point distance
  // assume some average driving speed?
  42
}

// Object-oriented programming classes
class TravelMode: Identifiable {
  let id = UUID()
  private let mode: String
  let averageSpeed: Double

  init(mode: String, averageSpeed: Double) {
    self.mode = mode
    self.averageSpeed = averageSpeed
  }

  func actualDistance(_ from: CLLocation, _ to: CLLocation) -> Double {
    // use relevant map info for each specific travel mode
    fatalError("Implement this method for \(mode).")
  }

  func computeTravelTime(from: CLLocation, to: CLLocation) -> Double {
    actualDistance(from, to)/averageSpeed
  }
}

// TODO: Instantiate TravelMode


// TODO: Add Walking subclass


// TODO: Instantiate Walking


// TODO: Add Driving subclass
// TODO: Over load computeTravelTime

// TODO: Instantiate Driving



PlaygroundPage.current.finishExecution()
