//
//  Created by Edwin Bosire on 22/06/2019.
//  Copyright © 2019 Edwin Bosire. All rights reserved.
//

import SwiftUI

struct LargeGalleryView : View {
    @EnvironmentObject var storage: Storage

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: -5) {
                Text(storage.note.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .color(.blue)
                Text(storage.title).font(.title).fontWeight(.medium)
                Text(storage.slug).font(.title).color(.secondary)
            }
            Image(storage.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .relativeSize(width: 1, height: 1)
                .cornerRadius(8)
                .clipped()
            
        }
    }
}

#if DEBUG
struct LargeGalleryView_Previews : PreviewProvider {
    static var previews: some View {
        LargeGalleryView()
            .environmentObject(Storage())
            .previewLayout(.fixed(width: 300, height: 280))
    }
}
#endif


import Combine
class Storage: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var title = "Fox Factory" { didSet{ update() }}
    var image = "foxFactory" { didSet { update() } }
    var slug = "Play the Honey Havest now"  { didSet { update() } }
    var note = "New Update"  { didSet { update() } }
    var headerTitle = "What We're playing"  { didSet { update() } }
    var appDescription = "Editorial comment" { didSet { update() } }
    
    var shouldShowSeeAllButton = true  { didSet { update() } }
    var showsSeparator = false { didSet { update() }}
    func update() {
        didChange.send(())
    }
}
