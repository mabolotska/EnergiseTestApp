//
//  ButtonsTableCell.swift
//  EnergiseTestApp
//


import UIKit

class ButtonsTableCell: UITableViewCell {
    static var identifier: String {"\(Self.self)"}
    var buttonAction: (() -> Void)?


    let cellButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupConstraints()
        cellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(cellButton)
    }


    @objc func buttonTapped() {
        buttonAction?()
    }

}


private extension ButtonsTableCell {
    func setupConstraints() {
        cellButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }

}
