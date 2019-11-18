//
//  AppsListView.swift
//  AppStore1
//
//  Created by Test_Env on 22/06/2019.
//  Copyright © 2019 Tiago Bastos. All rights reserved.
//

import SwiftUI

struct AppsListView : View {
    var apps = [App]()
    var body: some View {
//        NavigationView {
            List(apps) { AppListRow(app: $0) }
//                .navigationBarTitle(Text("Best New Apps"), displayMode: .inline)
//        }
    }
}

struct AppListRow: View {
    var app: App
    
    var body: some View {
        HStack(alignment: VerticalAlignment.center) {
            Image(app.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 85, height: 85, alignment: .center)
                .cornerRadius(10)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(app.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(nil)

                
                Text("Some sub heading")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                
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
            }.padding(.leading, 10)
            
        }
        
    }
    
    func getAction() {
        print("Get action")
    }
}
#if DEBUG
struct AppsListView_Previews : PreviewProvider {
    static var previews: some View {
        AppsListView(apps: DataLoaderService.getBestNewApps())
    }
}
#endif
