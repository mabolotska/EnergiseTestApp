//
//  NetworkReachability.swift
//  EnergiseTestApp


import UIKit
import Alamofire

class NetworkReachability {
  static let shared = NetworkReachability()
  let offlineAlertController: UIAlertController = {
      let alertController = UIAlertController(title: "No Network", 
                                              message: "Please connect to network and try again",
                                              preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default)
      alertController.addAction(okAction)
      return alertController
  }()

    func showOfflineAlert() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(offlineAlertController, animated: true, completion: nil)
        }
    }


  func dismissOfflineAlert() {
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let rootViewController = windowScene.windows.first?.rootViewController {
          rootViewController.dismiss(animated: true, completion: nil)
      }
  }


  let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")

  func startNetworkMonitoring() {
    reachabilityManager?.startListening { status in
      switch status {
      case .notReachable:
        self.showOfflineAlert()
      case .reachable(.cellular):
        self.dismissOfflineAlert()
      case .reachable(.ethernetOrWiFi):
        self.dismissOfflineAlert()
      case .unknown:
        print("Unknown network state")
      }
    }
  }

}
