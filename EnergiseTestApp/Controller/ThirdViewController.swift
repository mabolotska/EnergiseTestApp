//
//  ThirdViewController.swift
//  EnergiseTestApp
//

import UIKit
import StoreKit
import WebKit

class ThirdViewController: UIViewController{
    private let tableView = UITableView()
    let buttonTitles = ["Rate App", "Share App", "Contact us"]


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        setViews()
        setupUI()

    }

    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ButtonsTableCell.self, forCellReuseIdentifier: ButtonsTableCell.identifier)
        tableView.rowHeight = 100

    }
    func promptForReview() {
        SKStoreReviewController.requestReviewInCurrentScene()
    }

    func shareText() {
        let textToShare = "Hello, this is the text you want to share!"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        present(activityViewController, animated: true, completion: nil)
    }
    func loadUrl() {
     let vc = WebViewController()
     navigationController?.pushViewController(vc, animated: true)
    }


}


extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsTableCell.identifier, for: indexPath) as! ButtonsTableCell
        cell.cellButton.setTitle(buttonTitles[indexPath.row], for: .normal)
        switch indexPath.row {
        case 0:
            cell.buttonAction = {
                self.promptForReview()
            }
        case 1:
            cell.buttonAction = {
                self.shareText()
            }
        case 2:
            cell.buttonAction = {
                self.loadUrl()
            }
        default:
            break
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}


extension ThirdViewController {

    func setViews() {
        view.addSubview(tableView)
    }

    func setupUI() {
        tableView.snp.makeConstraints { make in
            make.height.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }


    }
}


extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
