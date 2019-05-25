//
//  CollectionViewController.swift
//  SizeItemCollectionview
//
//  Created by Đặng Khánh  on 5/23/19.
//  Copyright © 2019 Khánh Trắng. All rights reserved.
//

import UIKit
import Photos
import PhotosUI


class CollectionViewController: UICollectionViewController {

    var photos : PHFetchResult<PHAsset>! = CollectionViewController.loadPhoto()
    
    var imageManager = PHImageManager()
    
    static func loadPhoto() -> PHFetchResult<PHAsset> {
        let allPhotoOptions = PHFetchOptions()
        allPhotoOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allPhotoOptions)
    }
    
    //MARK: Item Size
    private let kMinInterItemSpacing : CGFloat = 2
    private let kMinimunmLineSpacing   : CGFloat = 2
    private let kEdgeInset          = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 4)
    private var isPortrait           : Bool = true
    private var numberOfSectionInRow : CGFloat {
        return isPortrait ? 4 : 6
    }

    private var itemSize : CGSize {
        let width = UIScreen.main.bounds.width
        let itemWidth = (width - kEdgeInset.left - kEdgeInset.right - (numberOfSectionInRow - 1) * kMinInterItemSpacing) / numberOfSectionInRow
        let itemHeigh = itemWidth
        return CGSize(width: itemWidth, height: itemHeigh)
    }

    var assetGirdThumnailSize : CGSize = CGSize.zero
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        let scale = UIScreen.main.scale
        assetGirdThumnailSize = CGSize(width: itemSize.width * scale, height: itemSize.height * scale)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let colectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        colectionViewFlowLayout.itemSize = itemSize
        colectionViewFlowLayout.minimumLineSpacing = kMinimunmLineSpacing
        colectionViewFlowLayout.minimumInteritemSpacing = kMinInterItemSpacing
        colectionViewFlowLayout.sectionInset = kEdgeInset
    

        
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
   
        let asset = photos[indexPath.row]
        
        cell?.presentingAssetId = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: assetGirdThumnailSize, contentMode: .aspectFill, options: nil) { (image, info) in
            if cell?.presentingAssetId == asset.localIdentifier {
                cell?.imageCell.image = image
            }
        }
        
        cell?.backgroundColor = .lightGray

    
        return cell!
    }

  

}
