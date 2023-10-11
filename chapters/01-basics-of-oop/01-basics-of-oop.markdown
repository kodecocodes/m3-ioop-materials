```metadata
number: "1"
title: "Lesson 1: Basics of OOP"
section: 1
free: true
authors:
  # These are applied on a per-chapter basis. If you would like to apply a role to the entire
  # book (i.e. every chapter), use the authors attribute in publish.yaml.
  # Roles: fpe, editor, tech_editor, author, illustrator
  # Use your rw.com username.
  - username: audrey
    role: author
description: |
  Learn the basic principles of object-oriented programming: encapsulation, abstraction, inheritance and polymorphism.
```

# Lesson 1: Basics of Object-Oriented Programming

## Why Should You Learn Object-Oriented Programming?

Object-oriented programming (OOP) has deep roots in computing history, standing almost shoulder-to-shoulder with procedural programming. The mainstream adoption of OOP languages coincided with the personal computer revolution in the 1970s, shaping the foundation for modern apps.

Today, languages like Swift and Kotlin, rooted in OOP, lead the charge in mobile app development. OOP doesn't just offer an approach; it's a boost to productivity and efficiency. With it, modeling your app's data becomes intuitive, code redundancy reduces, and problem-solving turns more straightforward.

In this lesson, we'll delve into OOP's core components, its four essential principles, and its edge over procedural programming.

## Procedural Programming vs. Object-Oriented Programming

You write computer programs to solve problems, and you usually break the problem into smaller parts, taking advantage of the "divide and conquer" principle. Object-oriented programming lets you think about problem-solving in a different way than procedural programming. 

In procedural programming, you solve problems by designing procedures (functions) to work on data. Function calls and data can be anywhere in the program. If you need to change a function's inputs or outputs, you must search the whole program and hope you find everything that you need to update. There's a greater possibility of duplicated code — another source of errors when you make changes to the code.

In object-oriented programming, objects are the core component: They contain their own data and functions, and they interact with each other. You solve problems by designing objects and their interactions. You're more likely to _reuse_ code than to duplicate it, and you can more easily find bugs because you know exactly how and where data can be changed.

In the demo, you'll take a quick look at the difference between procedural programming and object-oriented programming. But before you do that, take a moment to gain some foundational knowledge about structs and classes. 

## Structs & Classes

Object-oriented programming organizes app development around objects. Most apps manage objects like users and the items they use or create in the app — notes, to-dos, items to buy or sell, images or videos, social connections like followers or followed people etc. Here's how you create objects:

- **Struct**s (short for structures) and **class**es are blueprints for creating objects. They _encapsulate_ an object's attributes and behaviors. Attributes are usually called _properties_, and behaviors are _methods_ — functions that an object can call to perform a behavior.
- An **object** is an instance of a struct or class: Each instance has actual values for its properties and can call its methods.

What's the difference between structs and classes? You'll explore this more in the next lesson, but here's an overview:

- **Struct is a value type**, like `Int` or `Bool`; an instance of a struct contains the actual values of its properties. If you pass a struct instance to a function, the function has a _copy_ of that instance: The function cannot change the property values of the _original_ struct instance. Your app's memory stores a struct instance in the _stack_, which the CPU manages and optimizes, so it’s fast and efficient. You can instantiate structs without counting the cost.

- **Class is a reference type**, so an instance of a class actually contains a _reference_ — the location in memory where its data is stored. If you pass a class instance to a function, the function knows the location of its data and can change the values. Your app's memory stores the data of a class instance in the _heap_ and the reference — the location of the data — in the _stack_. Not only is there a two-step process to access the data, your app also needs to keep track of _reference counts_, or how many objects are holding a reference to this data. So instantiating a class is less efficient, and you don't want to do it unless that piece of data is sticking around for a while.

Swift has a preference for structs and recommends you start by using a struct until you need some feature that's only available for classes. A simple piece of data, like `User` or `Note`, is a lightweight object that your app won’t need forever. Typically, you’d model it with a struct.

Use a class when you want to create a shared, mutable state — that is, when you _want_ a function to be able to change its property values. Another good candidate for a class is a _data store_, which is a collection of objects that you'll use throughout your app. 

If you're keen to dive deeper into the distinctions between reference and value types in Swift, take a look at [Reference vs. Value Types in Swift](https://www.kodeco.com/9481-reference-vs-value-types-in-swift). For now, it's time to proceed to the next section where you'll explore the principles of OOP. 

## Principles of OOP

There are four fundamental principles that underlie OOP. Here's what they are and how they can benefit your development process:

- **Encapsulation**: A struct or class bundles an object's properties and methods in one place. You can easily see what data and behaviors your app has to work with.

- **Abstraction**: A struct or class limits access to an object's data. Other parts of your app can interact with an object only through its public interface.

- **Inheritance**: You can create subclasses of a class to share properties and methods. In a subclass, you can add properties or methods, or customize (override) the parent's methods. Swift doesn't allow multiple inheritance: A class can inherit from _at most_ one other class.

- **Polymorphism**: Your app can iterate over a collection containing parent and subclass objects, calling a method that performs according to the method definition of each subclass, or of the parent class.

You'll explore the first two principles in the demo and the last two in Lesson 3.

### What's Good About OOP?

So what are the advantages of OOP? Some reasons why OOP is a powerful tool in app development include: 

- **Modularity**: Encapsulation and abstraction make it easier to debug your app. All of an object's information is in one place, and you know exactly how this information can change. It's also easier to distribute work among team members, with each developer "owning" one or more object types.

- **Problem-solving**: Modularity enables you to divide your app's complexity into smaller problems that are easier to solve.

- **Reusability**: Inheritance lets you reuse code. If you need to add properties or modify methods, you do it in only one place, and have all the subclasses inherit the change.

- **Productivity & efficiency**: Reusable code, along with easier debugging, collaboration and problem-solving, make you a more productive and efficient developer.

Now, I'll introduce a concept known as **protocols** in Swift and **interfaces** in Kotlin. Whichever name you use, this concept is a powerful tool for making your code flexible and reusable without relying on traditional inheritance.

## Protocols/Interfaces

To model your data with inheritance, you must use classes. However, you can't have multiple inheritance, and structs can't use inheritance at all. Yet, Swift favors structs, and the Swift standard library contains many more structs than classes. How do you create reusable code without inheritance? 

The answer is protocols/interfaces. For simplicity, we'll stick to the protocol terminology moving forward.

A protocol defines a functionality or interface that a data type (struct or class) can conform to (adopt). And there's no limit on how many protocols a data type can adopt.

> **Note**: Protocols can’t hold data; they are simply a blueprint or template. You create structures or classes to hold data and they, in turn, conform to protocols.

You'll learn about protocols in Lesson 4.

## Demo

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

## A Brief History

Here's a quick history of how OOP came to be. I'll skip over the early stages of analog computing and assembly language and start with programming languages that can run on any computer architecture, highlighting key milestones along the way.   

Post-WWII, mainframe computers were mostly used for scientific and business computations. Minicomputers arrived in the 1960s, but they were still primarily employed in the professional sector. Apps as we know them didn't exist until the rise of personal computers in the 1970s. Almost in parallel, object-oriented languages became mainstream and now dominate the mobile app development universe.

Around the middle of the 20th century, academic and industrial research groups began to develop programming languages for mainframe computers. IBM created [Fortran](https://en.wikipedia.org/wiki/Fortran) for scientific computation, and a consortium created [COBOL](https://en.wikipedia.org/wiki/COBOL) for business use. Both are still widely used. Originally developed as procedural programming languages, both eventually acquired object-oriented features.  

In 1972, Bell Labs developed the [C programming language](https://en.wikipedia.org/wiki/C_(programming_language)) to write utilities for the Unix operating system of the [PDP-11](https://en.wikipedia.org/wiki/PDP-11) minicomputer and subsequently used it to rewrite the Unix kernel. C is a procedural programming language, but it's the foundation for object-oriented languages like Objective-C, C++, C#, Java, Python, Ruby (via Perl) and Swift.

Kotlin's predecessors include Java and C#. Objective-C and Ruby also inherited from Smalltalk — one of the first object-oriented languages, developed for educational use at Xerox PARC in the 1970s. Smalltalk used ideas from Simula, developed in the 1960s at the Norwegian Computing Center.

## Conclusion

In this lesson, you've learned how object-oriented programming simplifies data modeling for mobile apps. You've also seen how it enables you to encapsulate properties and methods, hide an object's information from the rest of the app and write reusable code. All of these features increase your productivity and efficiency and reduce complexity, making problem-solving easier.

## Quiz
