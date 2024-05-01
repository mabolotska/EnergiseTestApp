//
//  SecondViewController.swift
//  EnergiseTestApp
//

import UIKit
import MapKit

class SecondViewController: UIViewController {
    var mapData: Map?
    let mapView = MKMapView()

    let countryLabel = UILabel()
    let regionLabel = UILabel()
    let cityLabel = UILabel()
    let zipLabel = UILabel()
    let timezoneLabel = UILabel()
    let ipLabel = UILabel()
    let oneStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .systemBackground
        getData()

    }

    private func setupViews() {
        [mapView, oneStack, reloadButton].forEach {view.addSubview($0)}
        [countryLabel, regionLabel, cityLabel, zipLabel, timezoneLabel, ipLabel].forEach { oneStack.addArrangedSubview($0)}

    }

    func displayLabels() {
        UIView.animate(withDuration: 0.5) {
            self.countryLabel.alpha = 0
            self.cityLabel.alpha = 0
            self.regionLabel.alpha = 0
            self.zipLabel.alpha = 0
            self.timezoneLabel.alpha = 0
            self.ipLabel.alpha = 0
        } completion: { _ in
            self.countryLabel.text = "Country: \(self.mapData?.country ?? "No Country")"
            self.cityLabel.text = "City: \(self.mapData?.city ?? "No City")"
            self.regionLabel.text = "Region: \(self.mapData?.region ?? "No Region")"
            self.zipLabel.text = "Index: \(self.mapData?.zip ?? "No zip")"
            self.timezoneLabel.text = "Timezone: \(self.mapData?.timezone ?? "No Timezone")"
            self.ipLabel.text = "IP: \(self.mapData?.query ?? "No IP")"

            UIView.animate(withDuration: 0.5) {
                self.countryLabel.alpha = 1
                self.cityLabel.alpha = 1
                self.regionLabel.alpha = 1
                self.zipLabel.alpha = 1
                self.timezoneLabel.alpha = 1
                self.ipLabel.alpha = 1
            }
        }
    }


    func displayPosition() {
        let latitude = mapData?.lat ?? 44.7031
        let longitude = mapData?.lon ?? 22.8914

    let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    mapView.addAnnotation(annotation)

    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    mapView.setRegion(region, animated: true)
    }
    func getData() {
        NetworkManager.shared.fetchData(url: Constants.baseURL) { [weak self] (result: Result<Map, Error>) in
            switch result {
            case .success(let geoInfo):
                self?.mapData = geoInfo
                self?.displayPosition()
                self?.displayLabels()
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

    @objc func reloadButtonTapped() {
        getData()
    }


    @objc func refreshData() {
        getData()
    }
}


private extension SecondViewController {
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(150)
            make.leading.trailing.equalToSuperview().inset(50)
        }

        oneStack.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        reloadButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}

