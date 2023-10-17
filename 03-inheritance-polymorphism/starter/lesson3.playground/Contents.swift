
import PlaygroundSupport
import SwiftUI
import SafariServices

class MuseumObject {
  let objectID: Int
  let title: String
  let objectURL: String
  // TODO: Move this property to PublicDomainObject
  let primaryImageSmall: String
  let creditLine: String
  private let isPublicDomain: Bool

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

  // TODO: Modify to always open SFSafariViewController
  func showImage() {
    if isPublicDomain {
      PlaygroundPage.current.setLiveView(MuseumObjectView(object: self))
    } else {
      guard let url = URL(string: objectURL) else { return }
      PlaygroundPage.current.liveView = SFSafariViewController(url: url)
    }
  }
}

// TODO: Create PublicDomainObject subclass

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

// Instantiate a MuseumObject
let object =
MuseumObject(objectID: 436535,
             title: "Wheat Field with Cypresses",
             objectURL: "https://www.metmuseum.org/art/collection/search/436535",
             primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/original/DT1567.jpg",
             creditLine: "Purchase, The Annenberg Foundation Gift, 1993",
             isPublicDomain: true)

// TODO: Instantiate the same art object as a PublicDomainObject



object.showImage()
//object_pd.showImage()
