import UIKit
import SwiftUI

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let headerKind = "headerKind"
    private var dataSource: UICollectionViewDiffableDataSource<AppStoreCategory, App>!
    
    private lazy var headerView = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(34)),
        elementKind: self.headerKind,
        alignment: .topLeading
    )
    
    var appCategories: [AppStoreCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = makeNavigationBarAvatar()
        collectionView.backgroundColor = .white
        
        registerCells()
        
        DataLoaderService.load { [weak self] (categories) in
            self?.appCategories = categories
            self?.configureDataSource()
            self?.createLayout()
        }
    }
    
    // TODO: Find a better way of doing this
    private func makeNavigationBarAvatar() -> UIBarButtonItem {
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageview.image = UIImage(named: "steve_profile")
        imageview.contentMode = .scaleAspectFit
        imageview.layer.cornerRadius = 20
        imageview.layer.masksToBounds = true
        containView.addSubview(imageview)
        return UIBarButtonItem(customView: containView)
    }

    // Annoying issue when createLayout() is called on viewDidLoad where the collection view scrolls to the bottom + other unwanted
    // animation artefacts
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
    
    func registerCells() {
        collectionView?.register(LargeGalleryCellView.self,
                                 forCellWithReuseIdentifier: LargeGalleryCellView.reuseIdentifier)
        
        collectionView?.register(MediumGalleryCellView.self,
                                 forCellWithReuseIdentifier: MediumGalleryCellView.reuseIdentifier)
        
        collectionView?.register(IconListCellView.self,
                                 forCellWithReuseIdentifier: IconListCellView.reuseIdentifier)
        
        collectionView?.register(HeaderViewCollectionViewHeader.self,
                                 forSupplementaryViewOfKind: headerKind,
                                 withReuseIdentifier: HeaderViewCollectionViewHeader.reuseIdentifier)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let apps = self.appCategories?[indexPath.section].apps else {
            return
            
        }

        let detailViewController = UIHostingController(rootView: AppsListView(apps: apps))
        detailViewController.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    // setup datasource
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<AppStoreCategory, App>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, app) -> UICollectionViewCell? in
            let reusableString: String
            
            guard let appCategory = self.appCategories?[indexPath.section] else {
                fatalError("There are no section items found")
            }
            
            switch appCategory.layout {
            case .largeGallery:
                reusableString = LargeGalleryCellView.reuseIdentifier
            case .mediumGallery:
                reusableString = MediumGalleryCellView.reuseIdentifier
            case .mediumListGallery:
                reusableString = IconListCellView.reuseIdentifier
                
            default: fatalError("unsupported layout")
            }
            
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableString, for: indexPath) as? AppStoreCellConfigurable
            
            cell?.note = app.note ?? "Note"
            cell?.cellTitle = app.name
            cell?.imageName = app.imageName
            cell?.slug = app.desc ?? "App details goes here"
            cell?.appDescription = app.desc ?? "Editorial content here"
            
            cell?.showSeparator = (indexPath.row + 1) % 3 != 0
            return cell as? UICollectionViewCell
        })
        
        dataSource.supplementaryViewProvider = configureSupplementaryViews
        
        let snapShot = NSDiffableDataSourceSnapshot<AppStoreCategory, App>()
        snapShot.appendSections(appCategories!)
        for category in appCategories! {
            snapShot.appendItems(category.apps, toSection: category)
        }
        
        dataSource.apply(snapShot)
    }
    
    private func configureSupplementaryViews(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        
        guard let appCategory = appCategories?[indexPath.section] else {
            fatalError("There are no section items found")
        }
        
        switch kind {
        case headerKind:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: headerKind, withReuseIdentifier: HeaderViewCollectionViewHeader.reuseIdentifier, for: indexPath) as! HeaderViewCollectionViewHeader
            
            header.title = appCategory.name
            return header
        default:
            return nil
        }
    }
    
    private func createLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            guard let section = self.appCategories?[sectionIndex] else {
                fatalError()
            }
            
            switch section.layout {
            case .largeGallery:
                return self.largeGalleryLayout()
            case .mediumGallery:
                return self.mediumGalleryLayout()
            case .mediumListGallery:
                return self.iconsSmallLayout(environment: environment)
            default: fatalError("Unexpected layout")
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
}


extension FeaturedAppsController {
    static let itemGroupContentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 10)
    static let sectionContentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)

    //  +-------------------------------------------------------+
    //  |    -----------------                              ----|
    //  |    ----------------------                         ----|
    //  |    ----------------------------------             ----|
    //  |                                                       |
    //  |    +----------------------------------- +         +---|
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    |                                    |         |   |
    //  |    +----------------------------------- +         +---|
    //  |                                                       |
    //  +-------------------------------------------------------+
    
    private func largeGalleryLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize )
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalWidth(0.9))
        let itemsGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        itemsGroup.contentInsets = FeaturedAppsController.itemGroupContentInsets
        
        let section = NSCollectionLayoutSection(group: itemsGroup)
        section.contentInsets = FeaturedAppsController.sectionContentInsets
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    //  +----------------------------------------------------------+
    //  |   -----------------                           ---------  |
    //  |                                                          |
    //  |   +------+                                          +----|
    //  |   |      |  ------                     +-----+      |    |
    //  |   |      |  -------------------        |     |      |    |
    //  |   +------+  -------------------        +-----+      +----|
    //  |                                                          |
    //  |                                                          |
    //  |   +------------------------------------------+      +----|
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   |                                          |      |    |
    //  |   +-----------------------------------+             +----|
    //  |                                                          |
    //  |   ---------------------------                            |
    //  +----------------------------------------------------------+
    //
    // Medium is the wrong word, maybe promotionLayout or featuredLayout? 🤔
    func mediumGalleryLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)
        
        let itemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension:.fractionalWidth(0.9),
                                               heightDimension: .fractionalWidth(1.0)),
            subitems: [item])
        itemsGroup.contentInsets = FeaturedAppsController.itemGroupContentInsets
        
        
        let section = NSCollectionLayoutSection(group: itemsGroup)
        section.boundarySupplementaryItems = [headerView]
        section.contentInsets = FeaturedAppsController.sectionContentInsets
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    //  +----------------------------------------------------------+
    //  |   -----------------                           ---------  |
    //  |                                                          |
    //  |   +------+                                          +----|
    //  |   |      |  ------                     +-----+      |    |
    //  |   |      |  -------------------        |     |      |    |
    //  |   +------+                             +-----+      +----|
    //  |                                                          |
    //  |           -----------------------------------------------|
    //  |   +------+                                          +----|
    //  |   |      |  ------                     +-----+      |    |
    //  |   |      |  -------------------        |     |      |    |
    //  |   +------+                             +-----+      +----|
    //  |                                                          |
    //  |           -----------------------------------------------|
    //  |   +------+                                          +----|
    //  |   |      |  ------                     +-----+      |    |
    //  |   |      |  -------------------        |     |      |    |
    //  |   +------+                             +-----+      +----|
    //  |                                                          |
    //  +----------------------------------------------------------+
    // use environment to change layout for iphone/ipad
    private func iconsSmallLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let itemsGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitem: item, count: 3)
        itemsGroup.contentInsets = FeaturedAppsController.itemGroupContentInsets
        
        let nestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .absolute(300)),
            subitems: [itemsGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [headerView]
        section.contentInsets = FeaturedAppsController.sectionContentInsets
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

}
