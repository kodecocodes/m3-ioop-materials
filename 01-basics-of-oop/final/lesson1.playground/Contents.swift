
import PlaygroundSupport
import CoreLocation

let melbourne = CLLocation(latitude: -37.840935, longitude: 144.946457)
let ballarat = CLLocation(latitude: -37.5622, longitude: 143.8503)

// Procedural programming function
// DONE: Add more inputs
func computeTravelTime(from: CLLocation,
                       to: CLLocation,
                       averageSpeed: Double,
                       actualDistance: Double) -> Double {
  // compute point-to-point distance
  // assume some average driving speed?
  actualDistance/averageSpeed
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

// DONE: Instantiate TravelMode
let audrey = TravelMode(mode: "walking", averageSpeed: 4.5)
//audrey.mode
//audrey.actualDistance(melbourne, ballarat)

// DONE: Add Walking subclass
class Walking: TravelMode {
  override func actualDistance(_ from: CLLocation, _ to: CLLocation) -> Double {
    // use map info about walking paths, low-traffic roads, hills
    42
  }
}

// DONE: Instantiate Walking
let tim = Walking(mode: "walking", averageSpeed: 6)
tim.actualDistance(melbourne, ballarat)
tim.computeTravelTime(from: melbourne, to: ballarat)

// DONE: Add Driving subclass
class Driving: TravelMode {
  override func actualDistance(_ from: CLLocation, _ to: CLLocation) -> Double {
    // use map info about roads, tollways
    57
  }

  // DONE: Over load computeTravelTime
  func computeTravelTime(from: CLLocation,
                         to: CLLocation,
                         traffic: Double,
                         parking: Double) -> Double {
    actualDistance(from, to)/averageSpeed * traffic + parking
  }
}

// DONE: Instantiate Driving
let car = Driving(mode: "driving", averageSpeed: 50)
let hours = car.computeTravelTime(from: melbourne, to: ballarat)
let realHours = car.computeTravelTime(
  from: melbourne,
  to: ballarat,
  traffic: 1.2,
  parking: 0.5)

//tim.computeTravelTime(
//  from: melbourne,
//  to: ballarat,
//  traffic: 1.2,
//  parking: 0.5)

PlaygroundPage.current.finishExecution()
