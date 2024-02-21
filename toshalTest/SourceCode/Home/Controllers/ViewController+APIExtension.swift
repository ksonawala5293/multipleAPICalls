//
//  ViewController+APIExtension.swift
//  toshalTest
//
//  Created by Jekil Patel on 22/02/24.
//

import Foundation
import UIKit
import Alamofire

//MARK: - API calls
extension ViewController {
    func callAPIToFetchRegToken() {
        let urlStr = BaseURL + CreateTokenAPI
        
        let params = ["clientId" : token,
                      "clientSecret" : Secret
        ]
        
        AF.request(urlStr, method: .post, parameters: params).responseDecodable(of: TokenModel.self) { [self] response in
            
            switch response.result {
                
            case .success(_):
                if let authToken = response.response?.allHeaderFields["authentication"] as? String {
                    defaults.set(authToken, forKey: "authentication")
                    print(defaults.object(forKey:"authentication") as? String ?? "")

                    if Connectivity.isConnectedToInternet {
                        callAPIToGetHomeData()
                    } else {
                        showErrorAlert(for: .home)
                    }
                }
                break
                
            case .failure(_):
                print("Failed to auth token")
                break
            }
        }
    }
    
    func callAPIToGetHomeData() {
        let urlStr = BaseURL + HomeAPI
       
        let authToken = defaults.object(forKey:"authentication") as? String ?? ""
        let headers: HTTPHeaders = [
            "Authentication": authToken,
            "Accept": "application/json"
        ]
        
        AF.request(urlStr, method: .get, headers: headers).responseDecodable(of: HomeBaseModel.self) {[weak self] response in
                        
            self?.bannerIndicator.stopAnimating()
            
            if response.response?.statusCode == 200 {
                self?.handleHomeResponse(with: response)
            } else if response.response?.statusCode == 401 {
                
                self?.group.enter()
                
                let queue = DispatchQueue(label: "queue")
                queue.async {
                    self?.callAPIToRefreshToken()
                }
                
                self?.group.notify(queue: queue) {
                    self?.callAPIToGetHomeData()
                }
            }
        }
    }
    
    func callAPIToRefreshToken() {
        let urlStr = BaseURL + RefreshTokenAPI
        
        let params = ["clientId" : token,
                      "clientSecret" : Secret
        ]
        
        AF.request(urlStr, method: .post, parameters: params).responseDecodable(of: TokenModel.self) { [self] response in
            
            switch response.result {
                
            case .success(_):
                if let authToken = response.response?.allHeaderFields["authentication"] as? String {
                    defaults.set(authToken, forKey: "authentication")
                    print(defaults.object(forKey:"authentication") as? String ?? "")
                    
                    group.leave()
                }
                break
                
            case .failure(_):
                print("Failed to refresh auth token")
                break
            }
        }
    }
}
