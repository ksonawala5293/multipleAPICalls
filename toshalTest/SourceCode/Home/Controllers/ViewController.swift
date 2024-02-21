//
//  ViewController.swift
//  toshalTest
//
//  Created by Jekil Patel on 21/02/24.
//

import UIKit
import Alamofire

enum errorAlertType {
    case token
    case home
}

class ViewController: UIViewController {
    
    //MARK: - IBoutlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bannerIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionBanner: UICollectionView!
    
    //MARK: - Constants
    var token = ""
    let defaults = UserDefaults.standard
    var homeData: HomeBaseModel?
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        token = CommonMethods().getDeviceToken()
        
        if Connectivity.isConnectedToInternet {
            callAPIToFetchRegToken()
        } else {
            showErrorAlert(for: .token)
        }
    }
}

//MARK: - Custom methods
extension ViewController {
    func showErrorAlert(for type: errorAlertType) {
        let alert = UIAlertController(title: "", message: "No internet found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
            switch action.style{
            case .default:
                switch type {
                case .token:
                    self.callAPIToFetchRegToken()
                case .home:
                    self.callAPIToGetHomeData()
                }
                
            case .cancel:
                break
                
            case .destructive:
                break
                
            @unknown default:
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupBannerCollection() {
        collectionBanner.dataSource = self
        collectionBanner.delegate = self
        collectionBanner.register(UINib(nibName: "BannerCVC", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        setupPageControl()
        collectionBanner.reloadData()
    }
    
    func setupPageControl() {
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = homeData?.data?.bannerImages?.count ?? 0
    }
    
    func handleHomeResponse(with response: AFDataResponse<HomeBaseModel>) {
        switch response.result {
            
        case .success(let data):
            homeData = data
            print(homeData as Any)
            
            setupBannerCollection()
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
