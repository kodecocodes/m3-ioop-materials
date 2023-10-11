```metadata
number: "3"
title: "Lesson 3: Inheritance & Polymorphism"
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
  Learn how inheritance and polymorphism enable you to create flexible, reusable code. Create a subclass, define its `init` method and override an inherited method.
```

# Lesson 3: Inheritance & Polymorphism

## Introduction

In this lesson, you'll learn about two powerful object-oriented programming concepts in Swift: **inheritance** and **polymorphism**. These concepts are essential for creating organized, efficient and flexible coding structures. With inheritance, you'll learn how to establish relationships between classes, enabling the sharing of properties and methods. Then, you'll explore polymorphism, a powerful technique that allows objects of different classes to be treated uniformly, enhancing code reusability and adaptability.

Dive in to discover how these concepts empower you to write cleaner, more maintainable Swift code. 

## Inheritance

Swift has a preference for structs. It recommends you start by using a struct until you need some feature that's only available for classes. **Inheritance** is one of these features — it only works with classes.

Use inheritance to model your app's data if your objects have some properties in common, but some groups of objects have additional properties and/or specific behaviors. Rather than duplicating common code across all instances, you create subclasses that _inherit_ properties and methods from the parent class. Additionally, you can add properties and methods specific to each subclass. 

For example, you could use the Met Museum's art objects' `classification` property to define subclasses of `MuseumObject` — one subclass for each `classification` value. 

![bordered svg width=50%](images/01-class-tree.png "Museum art object classification tree")

The relationship between a subclass and its parent class is an **is-a** relationship: “Painting is-a MuseumObject”.

Each subclass could have properties that are relevant and useful for that specific `classification`. A `Painting` object might have an `artistDisplayName` property, while a `Ceramics` object might have a `region` or `excavation` property. If a subclass has properties that aren't in its parent class, you must define an `init` method that initializes these properties, then calls `super.init` to initialize the other properties.

## Polymorphism

A subclass could also have methods that are relevant and useful for that specific `classification`. You can _override_ a method in the parent class to do something different, such as using additional properties. Polymorphism translates to "many forms". It occurs when each subclass object invokes its own version of a method, giving it many forms. You don't need to write branching code to specify the object's behavior; each object knows exactly what to do.

In this lesson, you'll work with a simple example: You'll create a `PublicDomainObject` subclass of `MuseumObject` and override `showImage()`.

## Demo

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

## Conclusion

Inheritance and polymorphism enable you to create flexible, reusable code. In this lesson, you created a `PublicDomainObject` subclass of `MuseumObject`. It has a property — `primaryImageSmall` — that isn't in the parent class, so you defined its `init` method to set this property and call the parent's `init`. You redefined `showImage()`, then called this method from a `MuseumObject` and from a `PublicDomainObject`. Each object behaved according to its type: The `MuseumObject` used `SFSafariViewController`, and the `PublicDomainObject` used `MuseumObjectView`.

## Quiz
