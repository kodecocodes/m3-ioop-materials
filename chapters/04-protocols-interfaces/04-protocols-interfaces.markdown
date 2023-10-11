```metadata
number: "4"
title: "Lesson 4: Protocols/Interfaces"
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
  Swift protocols enable you to model behavior that isn’t connected to inheritance. Learn how to make a data type conform to a protocol and create your own protocol for museum objects that are on display.
```

# Lesson 4: Protocols/Interfaces

## Introduction

Protocols are a fundamental concept in Swift; they empower you to write code that's flexible, adaptable and easily reusable. Furthermore, they enable you to model behavior that isn’t connected to inheritance. In Swift, a class can inherit from just one parent class, and structs don't have inheritance at all. However, both structs and classes can adopt multiple protocols, allowing you to create your types to suit specific needs.

In this lesson, you'll dive into the world of Swift protocols, exploring their definition, their real-world applications and how they enable you to create code that conforms to specific contracts. By the end, you'll have a solid introduction to protocols and how to leverage them to enhance your iOS development skills. 

So what _is_ a protocol? Here's the official Swift definition:

> A _protocol_ defines a blueprint of methods, properties and other requirements that suit a particular task or piece of functionality. The protocol can then be _adopted_ by a class, structure or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to _conform_ to that protocol.

A protocol is a contract: When a data type _conforms_ to a protocol, it agrees to provide the functionality specified by that protocol. 

### Swift's Standard Library Protocols: Ready-Made Tools for Your Code

Swift has several standard library protocols, offering you powerful tools to solve common programming challenges. Now, you'll explore two essential ones:

- **Equatable**: This protocol allows you to determine whether two instances of a data type are equal. If all of a struct's stored properties are types that conform to `Equatable` — like `Int`, `String`, `Bool` etc. — then you only need to add `: Equatable` after its name. For a class, you must define `static func ==(lhs:rhs:)` to specify how to compare two instances.

Try out an example by extending the `MuseumObject` class to conform to the `Equatable` protocol in Swift.

```swift
extension MuseumObject: Equatable {
  static func ==(lhs: MuseumObject, rhs: MuseumObject) -> Bool {
    // return the condition that determines equality of two instances
  }
}
```

> **Note**: It's common to define a protocol's required methods and computed properties in an `extension`. Xcode helps you out by offering to add protocol stubs.

You'll explore this further in the demo portion of this lesson. 

- **CustomStringConvertible**: Sometimes, you want instances of your type to provide human-readable descriptions of themselves. An instance can convert itself into a descriptive `String`. To conform to this protocol, a struct or class must define a `description` property. Here's an example: 

```swift
extension MuseumObject: CustomStringConvertible {
  var description: String {
    // return human-reader-friendly string
  }
}
```

In the demo, you'll learn more about how this enhances your code's readability.

### Defining Your Own Protocols: Tailoring Your Interfaces

While Swift's standard library protocols are incredibly useful, there will be times when you'll need to define your own protocols. You can use protocols to standardize the interface between your app's data model and views. Here's why and how:

> **Note**: Remember, a _protocol_ in Swift is like an _interface_ in Kotlin, Java or PHP. 

Suppose your app has several data types that produce the same output type, like a `UIImage`, but each data type has a different property name for this image. You can define a protocol with a specific property name, like `image`, and make all your image-producing data types conform to it. Then, any code that needs to use this image knows that its name is always `image`.

```swift
protocol ImageDataProvider {
  var image: UIImage? { get }
}

extension TiltShiftOperation: ImageDataProvider {
  var image: UIImage? { outputImage }
}
```

In this example, `TiltShiftOperation` has a property named `outputImage`, so its `ImageDataProvider` extension defines the computed property `image`, which simply returns `outputImage`.

You can also create protocols to let different data types provide functionality that doesn't fit into an inheritance hierarchy. For example, in a computer game with monsters, you might define protocols for abilities that either the player or the monsters could have: flying, becoming invisible, seeing through walls, etc.

```swift
protocol CanFly {
  var speed: Double
  func fly(direction: Double)
}
```

A protocol definition looks like a struct or class definition. You can specify which properties and methods a conforming data type must have. Notice that you specify only the method _signature_ — each conforming data type must write its own implementation.

Now, you'll walk through a hands-on demonstration to illustrate how protocols are implemented and used in practical scenarios. 

## Demo

In this demo, you'll make `MuseumObject` conform to `Equatable` and `CustomStringConvertible`. Then you'll create a protocol and a subclass of `MuseumObject` that adopts it.

Open the playground in the starter folder or continue with your playground from the previous lesson. You won't change any code in `PublicDomainObject` or `MuseumObjectView`, so fold their code out of the way.

Also fold `MuseumObject` while you try out the Swift standard library protocols `Equatable` and `CustomStringConvertible`.

### `Equatable` `$[//]`

Below `MuseumObject`, add this `extension`:

```swift
extension MuseumObject: Equatable {
}
```

Pause, and you'll see an error message. If it doesn't appear, run the playground.

```
Type 'MuseumObject' does not conform to protocol 'Equatable'
Do you want to add protocol stubs?
```

Click the **Fix** button, and Xcode gives you the method stub you need to fill in:

```swift
static func == (lhs: MuseumObject, rhs: MuseumObject) -> Bool {
  <#code#>
}
```

Replace the code placeholder:

```swift
lhs.objectID == rhs.objectID
```

`objectID` is a unique identifier for `MuseumObject` instances, so you only need to test these values are the same.

Scroll down to `let object` and `let object_pd`. At the end of the previous lesson, you created these objects with the same art object.

```swift
let object =
MuseumObject(objectID: 436535,
             title: "Wheat Field with Cypresses",
             objectURL: "https://www.metmuseum.org/art/collection/search/436535",
             creditLine: "Purchase, The Annenberg Foundation Gift, 1993",
             isPublicDomain: true)
             
let object_pd =
PublicDomainObject(objectID: 436535,
                   title: "Wheat Field with Cypresses",
                   objectURL: "https://www.metmuseum.org/art/collection/search/436535",
                   primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg"
                   creditLine: "Purchase, The Annenberg Foundation Gift, 1993")
```

Below these two declarations, test for equality:

```swift
object == object_pd
```

Click in the margin to run the playground up to this line: In the sidebar, you get `true`, even though `object` is a `MuseumObject` and `object_pd` is a `PublicDomainObject`.

To make sure `==` isn't just returning `true` all the time, the starter playground also has a second `MuseumObject`. If you're continuing with your playground from the previous lesson, copy the _Cypress and Poppies_ object from the transcript below this video to create `object2`:

```swift
let object2 =
MuseumObject(objectID: 13061,
             title: "Cypress and Poppies",
             objectURL: "https://www.metmuseum.org/art/collection/search/13061",
             creditLine: "Gift of Iola Stetson Haverstick, 1982",
             isPublicDomain: false)
```

And test for equality:

```swift
object2 == object
```

And it's false, so `==` works!

### `CustomStringConvertible` `$[//]`

Next, to see what an object's default description looks like, add this line:

```swift
print(object)
```

Run the playground up to this line: In the sidebar, you get a string that's not very informative.

Below the `Equatable extension`, add this code and let Xcode fill in the stub you need:

```swift
extension MuseumObject: CustomStringConvertible {
  var description: String {
    "\(title): \(creditLine)"
  }
}
```

An art object's `title` and `creditLine` are the most meaningful pieces of information for a human reader.

Run the playground at the `print(object)` line: Now, you get:

```
Wheat Field with Cypresses: Purchase, The Annenberg Foundation Gift, 1993
```

And that's how you adopt and use `Equatable` and `CustomStringConvertible`. They'll work for any subclasses of `MuseumObject`, too!

### `OnDisplay` `$[//]`

You can also define your own protocols, to fine-tune your data model.

For example, an art object can be _on display_ in the museum. Not all are — many art objects are in storage or undergoing maintenance. An art object that is on display has a non-empty string for its `GalleryNumber` property. Its web page has a link to show its location on a map of the museum.

Call `showImage()` with `object2`:

```swift
object2.showImage()
```

Run the playground and wait for the web page to appear. Scroll down to see the **On view** line:

![bordered](images/01-safari-on-view.png "Web page: On view...") `$[//]`

Click the **Gallery 774** link:

![bordered](images/02-safari-met-map.png "Web page: Map") `$[//]`

A map appears, with a **Directions** button. Click the button, type **Van Gogh's Cypresses**, then press **Return**

![bordered](images/03-safari-search.png "Web page: Search results") `$[//]`

Select the first search result and wait:

![bordered](images/04-safari-route.png "Web page: Route from Gallery 774 to Gallery 199") `$[//]`

That's a nice bit of functionality built into the website. How would you model that in your app? You've probably guessed that you're not going to create an `OnDisplay` _subclass_ of `MuseumObject` — where would that leave `PublicDomainObject`? The topic of this lesson is protocols, so you're going to create an `OnDisplay` protocol.

### Create `OnDisplay` Protocol `$[//]`

Below `MuseumObjectView`, add this code:

```swift
protocol OnDisplay {
  var GalleryNumber: String { get }
  func showMap(from: String, to: String)
}
```

A data type that wants to adopt `OnDisplay` must have a constant property named `GalleryNumber` and a method with the signature `showMap(from: String, to: String)`.

Protocols cannot require properties to be immutable, so you can't declare `GalleryNumber` with `let`. In a protocol, you declare a read-only property as `var` with a `{ get }` specifier and no `{ set }` specifier.

### Create `OnDisplayObject` Subclass `$[//]`

Now, create an `OnDisplayObject` subclass of `MuseumObject` with a `GalleryNumber` property:

```swift
class OnDisplayObject: MuseumObject {
  let GalleryNumber: String

  init(objectID: Int,
       title: String,
       objectURL: String,
       creditLine: String,
       GalleryNumber: String,
       isPublicDomain: Bool) {
    self.GalleryNumber = GalleryNumber
    super.init(objectID: objectID,
               title: title,
               objectURL: objectURL,
               creditLine: creditLine,
               isPublicDomain: isPublicDomain)
  }
} 
```

This is like `PublicDomainObject`, but with `GalleryNumber` instead of `primaryImageSmall`.

Next, create an extension of `OnDisplayObject` and add a `showMap` method stub:

```swift
extension OnDisplayObject: OnDisplay {
  func showMap(from: String, to: String) {
    guard !GalleryNumber.isEmpty else { return }
    // implementation
  }
}
```

You check that the instance's `GalleryNumber` isn't the empty string.

`OnDisplayObject` inherits from the `MuseumObject` class and conforms to the `OnDisplay` protocol.

### Instantiate `OnDisplayObject` `$[//]`

Now, create an `OnDisplayObject` instance:

```swift
let object_od =
OnDisplayObject(objectID: 436535,
                title: "Wheat Field with Cypresses",
                objectURL: "https://www.metmuseum.org/art/collection/search/436535",
                creditLine: "Purchase, The Annenberg Foundation Gift, 1993",
                GalleryNumber: "199",
                isPublicDomain: true)
```

Call `showImage()` with `object_od` and comment out `object2.showImage()`:

```swift
object_od.showImage()
```

Run the playground.

`OnDisplayObject` is a subclass of `MuseumObject`, so it inherits the parent class's `showImage()`.

That ends this demo. Continue with the lesson for a summary.

## Conclusion

In this lesson, you've scratched the surface of powerful Swift protocols, which enable you to model behavior that isn’t connected to inheritance. Protocols offer a flexible way to define blueprints for methods, properties and requirements, allowing your code to adapt and be more reusable.

Unlike traditional inheritance, both classes and structs can adopt multiple protocols as necessary. Swift has several standard library protocols such as `Equatable` and `CustomStringConvertible`, which you used in this lesson. Additionally, you can define your own to create reusable code that defines interfaces or functionality.

By embracing protocols, you unlock the potential for adaptable Swift code. 

## Quiz
