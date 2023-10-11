```metadata
ref: "03"
description_md: |
  Learn how inheritance and polymorphism enable you to create flexible, reusable code. Create a subclass, define its `init` method and override an inherited method.
short_description: |
  Learn how inheritance and polymorphism enable you to create flexible, reusable code. Create a subclass, define its `init` method and override an inherited method.
authors_notes_md: |
  
```

Use `$[//]` anywhere on the line to omit the line from transcript.

# Lesson 3: Inheritance & Polymorphism

In this demo, you'll create a subclass of `MuseumObject`. You'll _move_ `primaryImageSmall` to this subclass, then learn how to write the subclass's `init` and override `showImage()`.

Open the playground in the starter folder. First of all, notice that `MuseumObject` is a class, not a struct. Inheritance only works with classes.

### Removing `primaryImageSmall` from `MuseumObject` `$[//]`

You'll start by creating a `PublicDomainObject` subclass of `MuseumObject`. The `primaryImageSmall` property is a string, and it's non-empty only for _public domain_ art objects, so it makes sense to _remove_ this property from `MuseumObject` and have it only in `PublicDomainObject`.

In `MuseumObject`, comment out or delete these lines:

```swift
let primaryImageSmall: String
primaryImageSmall: String,
self.primaryImageSmall = primaryImageSmall
```

Scroll down to the creation of a `MuseumObject`, to fix the error. Comment out or delete this line:

```swift
primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg",
```

Then, scroll back to `showImage()` and modify it to always open `SFSafariViewController`:

```swift
guard let url = URL(string: objectURL) else { return }
PlaygroundPage.current.liveView = SFSafariViewController(url: url)
```

Now, every instance of `MuseumObject` shows its image by loading its page in Safari.

There's another error down here in `MuseumObjectView`, which you'll fix after creating your subclass.

### Creating `PublicDomainObject` Subclass `$[//]`

And<!----> you're ready to create your subclass:

```swift
class PublicDomainObject: MuseumObject {
  
}
```

This is how you subclass `MuseumObject`: `PublicDomainObject: MuseumObject`. In other words, `PublicDomainObject` _is a_ `MuseumObject`. It _inherits_ all the properties and methods of `MuseumObject`, and you can add more properties and methods, or override `MuseumObject` methods and redefine them to do something different.

Next, add the property you removed from `MuseumObject`:

```swift
let primaryImageSmall: String
```

Because you've added a property to this subclass, you need to define its `init` method. Start by copying and editing the signature of the `init` in `MuseumObject`:

```swift
init(objectID: Int,
     title: String,
     objectURL: String,
     primaryImageSmall: String, 
     creditLine: String, = tru
     isPublicDomain: Bool = true) { }   
```

Uncomment or insert `primaryImageSmall: String,`, then set the default value of `isPublicDomain`.

Now, in the `init` body, set your new property, then call `MuseumObject`'s `init`:

```swift
self.primaryImageSmall = primaryImageSmall
super.init(objectID: objectID,
           title: title,
           objectURL: objectURL,
           creditLine: creditLine,
           isPublicDomain: isPublicDomain)
```

And override `showImage()`:

```swift
override func showImage() {
  PlaygroundPage.current.setLiveView(MuseumObjectView(object: self))
}
```

Now, every instance of `PublicDomainObject` shows its image in `MuseumObjectView(object:)`.

Scroll down to `MuseumObjectView` and change its parameter to be a `PublicDomainObject`:

```swift
let object: PublicDomainObject
```

### Instantiating `PublicDomainObject` `$[//]`

Next, create an instance of your new subclass — copy-paste and edit the `MuseumObject` declaration:

```swift
let object_pd =
PublicDomainObject(objectID: 436535,
                   title: "Wheat Field with Cypresses",
                   objectURL: "https://www.metmuseum.org/art/collection/search/436535",
                   primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg"
                   creditLine: "Purchase, The Annenberg Foundation Gift, 1993")
``` 

Remember: You set a default value for `isPublicDomain`, so you don't have to include it here.

Now, you've created the same art object as a `MuseumObject` _and_ as a `PublicDomainObject`. 

First, call `showImage()` with the `MuseumObject` instance:

```swift
object.showImage()
```

![bordered](images/02-object-show-image.png "MuseumObject showImage()") `$[//]`

It displays the art object's web page because a `MuseumObject` always calls `SFSafariViewController`.

Comment out `object.showImage()` and call `showImage()` with your `PublicDomainObject`:

```swift
object_pd.showImage()
```

![bordered](images/03-object_pd-show-image.png "PublicDomainObject showImage()") `$[//]`

As expected, you get the `MuseumObjectView`, because that's what the `PublicDomainObject` method calls.

That ends this demo. Continue with the lesson for a summary.

