
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

class PublicDomainObject: MuseumObject {
  let primaryImageSmall: String

  init(objectID: Int,
       title: String,
       objectURL: String,
       primaryImageSmall: String,
       creditLine: String,
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
             primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg",
             creditLine: "Purchase, The Annenberg Foundation Gift, 1993")

let object2 =
MuseumObject(objectID: 13061,
             title: "Cypress and Poppies",
             objectURL: "https://www.metmuseum.org/art/collection/search/13061",
             creditLine: "Gift of Iola Stetson Haverstick, 1982",
             isPublicDomain: false)

//object.showImage()
object_pd.showImage()

// TODO: Create OnDisplay protocol

// TODO: Create MuseumObject subclass that conforms to OnDisplay

