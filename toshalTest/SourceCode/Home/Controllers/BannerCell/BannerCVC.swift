//
//  BannerCVC.swift
//  toshalTest
//
//  Created by Jekil Patel on 21/02/24.
//

import UIKit
import Kingfisher

class BannerCVC: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showImage(with path: String) {
        let url = URL(string: path)
        imgBanner.kf.setImage(with: url)
    }

}
