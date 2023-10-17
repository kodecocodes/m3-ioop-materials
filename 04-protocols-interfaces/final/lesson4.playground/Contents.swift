
import PlaygroundSupport
import SwiftUI
import SafariServices

class MuseumObject {
  let objectID: Int
  let title: String
  let objectURL: String
  let creditLine: String
  private let isPublicDomain: Bool

  init(objectID: Int,
       title: String,
       objectURL: String,
       creditLine: String,
       isPublicDomain: Bool) {
    self.objectID = objectID
    self.title = title
    self.objectURL = objectURL
    self.creditLine = creditLine
    self.isPublicDomain = isPublicDomain
  }

  func showImage() {
    guard let url = URL(string: objectURL) else { return }
    PlaygroundPage.current.liveView = SFSafariViewController(url: url)
  }
}

extension MuseumObject: Equatable {
  static func ==(lhs: MuseumObject, rhs: MuseumObject) -> Bool {
    lhs.objectID == rhs.objectID
  }
}

extension MuseumObject: CustomStringConvertible {
  var description: String {
    "\(title): \(creditLine)"
  }
}

let object =
MuseumObject(objectID: 13061,
             title: "Cypress and Poppies",
             objectURL: "https://www.metmuseum.org/art/collection/search/13061",
             creditLine: "Gift of Iola Stetson Haverstick, 1982",
             isPublicDomain: false)

let object2 =
MuseumObject(objectID: 13061,
             title: "Cypress and Poppies",
             objectURL: "https://www.metmuseum.org/art/collection/search/13061",
             creditLine: "Gift of Iola Stetson Haverstick, 1982",
             isPublicDomain: false)

object == object2

print(object)

//object.showImage()

// DONE: Create OnDisplay protocol
protocol OnDisplay {
  var GalleryNumber: String { get }
  func showMap(from: String, to: String)
}

// DONE: Create MuseumObject subclass that conforms to OnDisplay
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

extension OnDisplayObject: OnDisplay {
  func showMap(from: String, to: String) {
    guard !GalleryNumber.isEmpty else { return }
    // implementation
  }
}

// DONE: Create OnDisplayObject instance
let object_od =
OnDisplayObject(objectID: 436535,
                title: "Wheat Field with Cypresses",
                objectURL: "https://www.metmuseum.org/art/collection/search/436535",
                creditLine: "Purchase, The Annenberg Foundation Gift, 1993",
                GalleryNumber: "199",
                isPublicDomain: true)
object_od.showImage()

class PublicDomainObject: MuseumObject {
  let primaryImageSmall: String

  init(objectID: Int,
       title: String,
       objectURL: String,
       creditLine: String,
       primaryImageSmall: String,
       isPublicDomain: Bool = true) {
    self.primaryImageSmall = primaryImageSmall
    super.init(objectID: objectID,
               title: title,
               objectURL: objectURL,
               creditLine: creditLine,
               isPublicDomain: isPublicDomain)
  }

  override func showImage() {
    PlaygroundPage.current.setLiveView(MuseumObjectView(object: self))
  }
}

let object_pd =
PublicDomainObject(objectID: 436535,
                   title: "Wheat Field with Cypresses",
                   objectURL: "https://www.metmuseum.org/art/collection/search/436535",
                   creditLine: "Purchase, The Annenberg Foundation Gift, 1993",
                   primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg")
//                   isPublicDomain: true)
//object_pd.showImage()

struct MuseumObjectView: View {
  let object: PublicDomainObject

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
