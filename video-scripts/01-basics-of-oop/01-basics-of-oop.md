```metadata
ref: "01"
description_md: |
  Learn the basic principles of object-oriented programming: encapsulation, abstraction, inheritance and polymorphism.
short_description: |
  Learn the basic principles of object-oriented programming: encapsulation, abstraction, inheritance and polymorphism.
authors_notes_md: |
  
```

Use `$[//]` anywhere on the line to omit the line from transcript.

# Lesson 1: Basics of Object-Oriented Programming

In this demo, you'll take a quick look at the difference between procedural programming and object-oriented programming. I'm using an Xcode playground and writing in Swift. If you're following along, start up Xcode and open the **module1-lesson1** playground in the starter folder.

This playground imports two Swift frameworks:

```swift
import PlaygroundSupport
import CoreLocation
```

`PlaygroundSupport` helps manage the execution of the playground page. In the next lesson, you'll use it to show views, but all it does here is `finishExecution()`, right at the end:

```swift
PlaygroundPage.current.finishExecution()
``` 

`CoreLocation` provides the location data type used in the demo examples. And here are two locations you'll use:

```swift
let melbourne = CLLocation(latitude: -37.840935, longitude: 144.946457)
let ballarat = CLLocation(latitude: -37.5622, longitude: 143.8503)
```

### Procedural Programming `$[//]`

First up is an example of a procedural programming function that computes the travel time between two `CLLocation` values. I haven't written the actual code, but it would compute the point-to-point distance between the `from` and `to` values and use some average speed, probably assuming the travel mode is driving.

Now suppose the programmer decides or is told to modify the function so it's more accurate for other travel modes, like walking, cycling or public transport. Maybe add some parameters for average speed and actual distance:

```swift
func computeTravelTime(from: CLLocation,
                       to: CLLocation,
                       averageSpeed: Double,
                       actualDistance: Double) -> Double {
  actualDistance/averageSpeed
}
```

Making this change breaks every call to this function in the program and, wherever it's called, you now need to precede it by a calculation of `actualDistance`. And you probably need to include some branching code to set these new parameter values for the different travel modes.

Later, you might want to fine-tune the driving calculation to allow for traffic level and the average time to find parking. But these values aren't relevant to the other travel modes, so you'd need to call a different function.

### Object-Oriented Programming `$[//]`

Now, look at the `TravelMode` class. `TravelMode` is a very general concept that covers walking, cycling, driving and public transport.

```swift
class TravelMode: Identifiable {
  let id = UUID()
```

`Identifiable` is a standard library protocol that makes it easier to iterate over collections of `TravelMode` objects. Its only requirement is the `id` property, which must be a unique value for each instance, and `UUID()` takes care of this without any fuss. You don't need to know what its actual value is — it'll just do its job quietly.

There are two other properties:

```swift
private let mode: String
let averageSpeed: Double
```

`mode` is walking, cycling, driving or public transport. After you create a `TravelMode` object, the app's code can't access it. You'll check this for yourself soon.

You supply the value of `averageSpeed` when you create a `TravelMode` object: It's an estimate that depends on the mode and user- or time-specific factors like how fast the user can walk or cycle, or whether the driving is on city streets or highways.

You pass values for these two properties in the initializer:

```swift
init(mode: String, averageSpeed: Double) {
  self.mode = mode
  self.averageSpeed = averageSpeed
}
```

`self.` refers to the object itself. Here, it differentiates the object's properties from the parameters, which have the same names.

Down below the class definition, instantiate `TravelMode`:

```swift
let audrey = TravelMode(mode: "walking", averageSpeed: 4.5)
```

That's 4.5 km/hr.

Now, test what I said about not being able to access `mode`:

```swift
audrey.mode
```

Soon you see an error message: _'mode' is inaccessible due to 'private' protection level_. This is an example of **abstraction**: Other parts of your app can interact with an object only through its _public_ interface.

Comment out or delete the line `audrey.mode`.

Back in `TravelMode`, look at the two methods:

```swift
func actualDistance(_ from: CLLocation, _ to: CLLocation) -> Double {
  // use relevant map info for each specific travel mode
  fatalError("Implement this method for \(mode).")
}

func computeTravelTime(from: CLLocation, to: CLLocation) -> Double {
  actualDistance(from, to)/averageSpeed
}
```

`computeTravelTime(from:to:)` _looks_ just like the original procedural programming function, but it uses `actualDistance()`, which uses data that's specific to each travel mode, and the `averageSpeed` that was used to instantiate the `TravelMode` object. Everything you need for `computeTravelTime(from:to:)` is _encapsulated_ in the object, and the app's code just needs to provide the `from` and `to` locations. 

`actualDistance(_:_:)` is a _placeholder_ function. Having a method like this means you shouldn't create instances of this class. Instead, you should define a subclass and _override_ this method to suit objects of that type. It's a kind of back-door way of creating an _abstract class_.

Try calling it with your `TravelMode` object:

```swift
audrey.actualDistance(melbourne, ballarat)
```

Click the run button to execute the playground.

There's an error flag and, in the console, this message appears:

```
__lldb_expr_3/module1-lesson1.playground:27: Fatal error: Implement this method for walking.
```

If you don't want your class to be "sort of abstract", you could implement `actualDistance(_:_:)` to return the point-to-point distance — "as the crow flies".

For now, comment out or delete this method call. If the error message sticks around, select, from the **Product** menu, **Clear All Issues**.

Leave `actualDistance(_:_:)` as a placeholder, because you're about to create some subclasses!

```swift
class Walking: TravelMode {

}
```

Writing `:TravelMode` after the class name means `Walking` _is-a_ `TravelMode`. It _inherits_ all the properties and methods of `TravelMode`, so you don't include them in its definition. The only thing you need to write is the method that isn't implemented in `TravelMode`:

```swift
override func actualDistance(_ from: CLLocation, _ to: CLLocation) -> Double {
  // use map info about walking paths, low-traffic roads, hills
  42
}
```

42 is only a placeholder value — you have to return _something_.

Now, instantiate your subclass:

```swift
let tim = Walking(mode: "walking", averageSpeed: 6)
```

Tim is younger and taller than me, so I'm guessing he walks faster. 

Call that pesky method:

```swift
tim.actualDistance(melbourne, ballarat)
```

Also call `computeTravelTime(from:to:)`:

```swift
tim.computeTravelTime(from: melbourne, to: ballarat)
```

Run the playground. `actualDistance` is 42, so travel time is 7 hours.

Now, write one more subclass:

```swift
class Driving: TravelMode {
  override func actualDistance(_ from: CLLocation, _ to: CLLocation) -> Double {
    // use map info about roads, tollways
    57
  }
}
```

57's another placeholder value, different from Walking's 42.

Instantiate a `Driving` object:

```swift
let car = Driving(mode: "driving", averageSpeed: 50)
```

50 km/hr is about right for `averageSpeed`, as much of the distance is on a highway.

And compute its travel time:

```swift
let hours = car.computeTravelTime(from: melbourne, to: ballarat)
```

Run the playground. The travel time value actually isn't far off, considering it's using placeholder values, but it's different from the `Walking` object's travel time, because it's using its own version of `actualDistance` and `averageSpeed`. That's _polymorphism_ in action!

So far, `Driving` works the same as `Walking`. How do you set it up to use traffic level and parking time? Instead of overriding `computeTravelTime`, you _overload_ it: You add parameters to create a different function signature. A `Driving` object can call this version of `computeTravelTime`, but no other subclass type can.

```swift
func computeTravelTime(from: CLLocation,
                       to: CLLocation,
                       traffic: Double,
                       parking: Double) -> Double {
  actualDistance(from, to)/averageSpeed * traffic + parking
}
```

Try this out:

```swift
let minutes = 60 * car.computeTravelTime(
  from: melbourne,
  to: ballarat,
  traffic: 1.2,
  parking: 0.5)
```

Run the playground. As you'd expect, travel time is now more than the inherited method's calculation.

Just check to see if `tim` can call this method: Start typing...

```swift
tim.c
```

Nope, only the `TravelMode` method appears in the menu. If you force it, by copy-pasting, you get an error flag: Extra arguments.

That ends this demo. Continue with the lesson for a summary.

