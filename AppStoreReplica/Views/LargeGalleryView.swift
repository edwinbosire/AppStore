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
                    .foregroundColor(.blue)
                Text(storage.title).font(.title).fontWeight(.medium)
                Text(storage.slug).font(.title).foregroundColor(.secondary)
            }
            Image(storage.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 1, minHeight: 1)
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
class Storage: ObservableObject {
    @Published var title = "Fox Factory"
    @Published var image = "foxFactory"
    @Published var slug = "Play the Honey Havest now"
    @Published var note = "New Update"
    @Published var headerTitle = "What We're playing"
    @Published var appDescription = "Editorial comment"
    
    @Published var shouldShowSeeAllButton = true
    @Published var showsSeparator = false
    
}
