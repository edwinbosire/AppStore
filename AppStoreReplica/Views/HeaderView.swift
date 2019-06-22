//  Created by Edwin Bosire on 22/06/2019.
//  Copyright © 2019 Edwin Bosire. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct HeaderView : View {
    @EnvironmentObject var storage: Storage
    
    var body: some View {
        VStack {
            if !storage.headerTitle.isEmpty { // hiding views if we don't have a header title
                Rectangle()
                    .fill(Color.init(white: 0.9))
                    .frame(height: 1)
            }
            HStack {
                Text(storage.headerTitle)
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
                
                if storage.shouldShowSeeAllButton {
                    Button(action: viewAllSelected) {
                        Text("See All")
                            .font(.body)
                    }
                }
            }
        }
    }
    
    func viewAllSelected() {
        print("View all tapped")
    }
}

#if DEBUG
struct HeaderView_Previews : PreviewProvider {
    static var previews: some View {
        HeaderView()
            .environmentObject(Storage())
            .previewLayout(.fixed(width: 320, height: 40))
    }
}
#endif



class HeaderViewCollectionViewHeader: UICollectionViewCell, AppStoreCellConfigurable {
    
    static var reuseIdentifier = "HeaderViewCollectionViewHeaderIdentifier"
    var storage = Storage() // We should use a different bindable object
    var title = "" { didSet { storage.headerTitle = title} }
    
    // make these optional in AppStoreCellConfigurable
    var cellTitle: String = ""
    var imageName: String = ""
    var slug: String = ""
    var note: String = ""
    var appDescription: String = ""
    
    lazy var integratedView = HeaderView().environmentObject(storage)
    lazy var cellView = UIHostingController(rootView: self.integratedView).view!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.contentView.layer.borderWidth = 1
        //        self.contentView.layer.borderColor = (UIColor.red).cgColor
    }
    
    // Fit the entire hosted view in our new container
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
