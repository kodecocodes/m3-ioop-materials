
import PlaygroundSupport
import SwiftUI
import SafariServices

struct MuseumObject {
  // DONE: Declare properties
  let objectID: Int
  var title: String
  let objectURL: String
  let primaryImageSmall: String
  let creditLine: String
  private let isPublicDomain: Bool

  // DONE: Define initializer for class
  init(objectID: Int,
       title: String,
       objectURL: String,
       primaryImageSmall: String,
       creditLine: String,
       isPublicDomain: Bool) {
    self.objectID = objectID
    self.title = title
    self.objectURL = objectURL
    self.primaryImageSmall = primaryImageSmall
    self.creditLine = creditLine
    self.isPublicDomain = isPublicDomain
  }

  // DONE: Implement this method
  func showImage() {
    if isPublicDomain {
      PlaygroundPage.current.setLiveView(MuseumObjectView(object: self))
    } else {
      guard let url = URL(string: objectURL) else { return }
      PlaygroundPage.current.liveView = SFSafariViewController(url: url)
    }
  }

  mutating func changeTitle(to newTitle: String) {
    title = newTitle
  }
}

// DONE: Instantiate objects
let object_pd =
MuseumObject(objectID: 436535,
             title: "Wheat Field with Cypresses",
             objectURL: "https://www.metmuseum.org/art/collection/search/436535",
             primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg",
             creditLine: "Purchase, The Annenberg Foundation Gift, 1993",
             isPublicDomain: true)
let object =
MuseumObject(objectID: 13061,
             title: "Cypress and Poppies",
             objectURL: "https://www.metmuseum.org/art/collection/search/13061",
             primaryImageSmall: "",
             creditLine: "Gift of Iola Stetson Haverstick, 1982",
             isPublicDomain: false)

var object2 = object_pd
//object2.title = "Sunflowers"
object2.changeTitle(to: "Sunflowers")

// DONE: Call showImage()
//object_pd.showImage()
//object.showImage()
object2.showImage()

struct MuseumObjectView: View {
  let object: MuseumObject

  public var body: some View {
    VStack {
      Text(object.title)
        .multilineTextAlignment(.leading)
        .font(.callout)
        .frame(minHeight: 44)
        .padding(.horizontal)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)

      AsyncImage(url: URL(string: object.primaryImageSmall)) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        Text("Display image here")
      }
      .frame(width: 600.0, height: 600.0, alignment: .center)

      Text(object.creditLine)
        .font(.caption)
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
    }
    .padding()
  }
}
