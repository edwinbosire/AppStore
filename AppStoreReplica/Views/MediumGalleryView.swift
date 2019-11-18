//
//  Created by Edwin Bosire on 22/06/2019.
//  Copyright © 2019 Edwin Bosire. All rights reserved.
//

import SwiftUI

struct MediumGalleryView : View {
    @EnvironmentObject var storage: Storage

    var body: some View {
        VStack (alignment: .leading) {
            IconListView()
            Image(storage.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 1, minHeight: 1.0)
                .cornerRadius(8)
                .clipped()
            
            Text(storage.appDescription)
                .font(.body)
            
        }
    }
}

#if DEBUG
struct MediumGalleryView_Previews : PreviewProvider {
    static var previews: some View {
        MediumGalleryView()
            .environmentObject(Storage())
            .previewLayout(.fixed(width: 300, height: 300))

    }
}
#endif


class MediumGalleryCellView: UICollectionViewCell, AppStoreCellConfigurable {
    var storage = Storage()
    var cellTitle: String = "" { didSet { storage.title = cellTitle} }
    var imageName: String = "" { didSet { storage.image = imageName } }
    var slug: String = "" { didSet { storage.slug = slug } }
    var note: String = "" { didSet { storage.note = note } }
    var appDescription = "" { didSet { storage.appDescription = appDescription } }

    static var reuseIdentifier = "MediumGalleryCellViewIdentifier"
    
    lazy var integratedView: some View = MediumGalleryView().environmentObject(storage)
    
    lazy var cellView = UIHostingController(rootView: self.integratedView).view!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //                self.contentView.layer.borderWidth = 1
        //                self.contentView.layer.borderColor = (UIColor.red).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellView)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
