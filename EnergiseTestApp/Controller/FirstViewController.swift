//
//  ViewController.swift
//  EnergiseTestApp
//

import UIKit
import SnapKit

final class FirstViewController: UIViewController {

    var timer: Timer?
    var milliseconds = 0

    private let timerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .selected)
        button.tintColor = .black
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        return button
    }()
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "00:00"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
      timerButton.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
    }

    private func setupViews() {
        [timerButton, timerLabel].forEach { view.addSubview($0)}
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startPulsatingAnimation()
    }

    @objc func timerButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            startTimer()
            sender.layer.removeAllAnimations()
        } else {
            stopTimer()
            startPulsatingAnimation()
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }

    @objc func updateTimerLabel() {
        milliseconds += 1
        let seconds = milliseconds / 10
        let minutes = seconds / 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds % 60)
        timerLabel.text = formattedTime
    }


    func stopTimer() {
        timer?.invalidate()
        timer = nil
        milliseconds = 0
        timerLabel.text = "00:00"
    }

    func startPulsatingAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .repeat], animations: {

            self.timerButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction],
                           animations: {
                self.timerButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            )
        }
    }

}

private extension FirstViewController {
    private func setupConstraints() {
        timerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }

        timerLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timerButton.snp.top).offset(-30)
            make.centerX.equalToSuperview()
        }
    }
}
