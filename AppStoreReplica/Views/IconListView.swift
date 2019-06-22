//
//  Created by Edwin Bosire on 22/06/2019.
//  Copyright © 2019 Edwin Bosire. All rights reserved.
//

import SwiftUI

struct IconListView : View {
    @EnvironmentObject var storage: Storage
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(storage.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75, alignment: .center)
                    .cornerRadius(8)
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(storage.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .truncationMode(.tail)
                        .lineLimit(nil)
                    
                    
                    Text(storage.slug)
                        .font(.body)
                        .color(.secondary)
                }
                Spacer()
                
                Button(action: getAction) {
                    Text("GET")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(8)
                        .padding(.leading,15)
                        .padding( .trailing,15)
                    }
                    .background(Color(white: 0.95))
                    .cornerRadius(18)
                    .clipped()
                
                
            }
            if storage.showsSeparator { // hiding views if we don't have a header title
                Rectangle()
                    .fill(Color.init(white: 0.9))
                    .frame(height: 1)
                    .padding(.leading, 80)
            }
            
        }
    }
    
    func getAction() {
        print("Get action tapped")
    }
}

#if DEBUG
struct IconListView_Previews : PreviewProvider {
    static var previews: some View {
        IconListView()
            .environmentObject(Storage())
            .previewLayout(.fixed(width: 375, height: 270/3))
    }
}
#endif

protocol AppStoreCellConfigurable {
    
    var cellTitle: String { get set }
    var imageName: String { get set }
    var slug: String { get set }
    var note: String { get set }
    var appDescription: String { get set }
    var showSeparator: Bool { get set }
    
}

extension AppStoreCellConfigurable {
    var showSeparator: Bool {
        get { return true }
        set {}
    }
}

class IconListCellView: UICollectionViewCell, AppStoreCellConfigurable {
    var storage = Storage()
    var cellTitle: String = "" { didSet { storage.title = cellTitle} }
    var imageName: String = "" { didSet { storage.image = imageName } }
    var slug: String = "" { didSet { storage.slug = slug } }
    var note: String = "" { didSet { storage.note = note } }
    var appDescription = "" { didSet { storage.appDescription = appDescription } }
    
    var showSeparator = true {
        didSet {
            storage.showsSeparator = showSeparator
        }
    }
    
    static var reuseIdentifier = "IconListCellViewIdentifier"
    
    lazy var integratedView = IconListView().environmentObject(storage)
    
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
