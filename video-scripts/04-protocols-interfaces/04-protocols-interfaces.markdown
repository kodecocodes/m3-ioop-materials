```metadata
ref: "04"
description_md: |
  Swift protocols enable you to model behavior that isn’t connected to inheritance. Learn how to make a data type conform to a protocol and create your own protocol for museum objects that are on display.
short_description: |
  Swift protocols enable you to model behavior that isn’t connected to inheritance. Learn how to make a data type conform to a protocol and create your own protocol for museum objects that are on display.
authors_notes_md: |

```

Use `$[//]` anywhere on the line to omit the line from transcript.

# Lesson 4: Protocols/Interfaces

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
