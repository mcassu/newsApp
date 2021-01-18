//
//  Alert.swift
//  newsApp
//
//  Created by Cassu on 13/01/21.
//  Copyright © 2021 Cassu. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    static func loading(isLoading: Bool) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: "Aguarde...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            var vc: UIViewController? = nil
     
            loadingIndicator.hidesWhenStopped = true
            
            if #available(iOS 13.0, *) {
                loadingIndicator.style = UIActivityIndicatorView.Style.medium
                for scene in UIApplication.shared.connectedScenes {
                    if scene.activationState == .foregroundActive {
                        vc = ((scene as? UIWindowScene)!.delegate as! UIWindowSceneDelegate).window!!.rootViewController
                        break
                    }
                }
            } else {
                loadingIndicator.style = UIActivityIndicatorView.Style.gray
            }
            loadingIndicator.startAnimating()
            
            alert.view.addSubview(loadingIndicator)
            
            guard let rootVC = vc else {
                if isLoading {
                    NewsViewController().present(alert, animated: true, completion: nil)
                }else {
                    NewsViewController().dismiss(animated: true, completion: nil)
                }
                return
            }
            
            if isLoading {
                rootVC.present(alert, animated: true, completion: nil)
            }else {
                rootVC.dismiss(animated: true, completion: nil)
            }
        }
    }
}
