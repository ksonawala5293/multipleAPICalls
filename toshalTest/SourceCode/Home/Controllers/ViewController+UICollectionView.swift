//
//  ViewController+UICollectionView.swift
//  toshalTest
//
//  Created by Jekil Patel on 21/02/24.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate {
    //Write Delegate Code Here
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionBanner {
            return homeData?.data?.bannerImages?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BannerCVC
            
            if let imagePath = homeData?.data?.bannerImages?[indexPath.item].image {
                let combinedPath = BaseURL + ImageURL + imagePath
                cell.showImage(with: combinedPath)
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == collectionBanner {
            pageControl.currentPage = indexPath.item
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionBanner {
            return CGSize(width: UIScreen.main.bounds.width - 20, height: 150)
        }
        return CGSize(width: 0, height: 0)
    }
}
