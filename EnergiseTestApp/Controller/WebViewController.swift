//
//  WebViewController.swift
//  EnergiseTestApp
//


import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    let optURL = "https://energise.notion.site/Swift-fac45cd4d51640928ce8e7ea38552fc3"
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)

        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        guard let myURL = URL(string: optURL)  else { return }
        let request = URLRequest(url: myURL)
        webView.load(request)
        // Set webView constraints using SnapKit
                webView.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide)
                    make.leading.trailing.bottom.equalToSuperview()
                }
    }
    @objc func doneButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }

}
