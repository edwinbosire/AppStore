# AppStore
⚠️ Experimental ⚠️ App Store using SwiftUI + Combinational layouts + Combine + more iOS 13 Goodies


This is an experimental project to see how some of the newly announced iOS 13 features works. A big part of the project is made up of UICollectionViewCompositionalLayout and SwiftUI elements. There is also a dash of Combine framework. I decided to mix and match UIKit & SwiftUI components to see how apps could integrate.

With UICollectionViewCompositionalLayout, i've managed to create 3 layouts without nesting UICollectionViews and all working on the same data type, it truly is amazing.

I created three different UICollectionViews, which are SwiftUI components hosted onto UIKit elements using UIHostingController, which basically takes a SwiftUI View and produces a UIViewController. I've used autolayout as the glue, and used Combine framework to pass data between these two worlds.

![app store image 1](Resources/AppStore1.png)
![app store image 2](Resources/Appstore2.png)
