//
//  CheapFlightCell.swift
//  TravelAppWB
//
//  Created by Alex M on 08.08.2023.
//

import UIKit

protocol CheapFlightCellDelegate: AnyObject {
    func likeButtonDidTap(_ sender: CheapFlightCell, searchToken: String)
}

class CheapFlightCell: UITableViewCell {

    weak var delegate: CheapFlightCellDelegate?

    private var searchToken = ""

    private let contentMainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9660720229, green: 0.9660721421, blue: 0.9660720229, alpha: 1)
        return view
    }()


    private let airplaneView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.5982286334, green: 0.004385416862, blue: 0.5994241834, alpha: 1)
        imageView.image = UIImage(systemName: "airplane")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    private let startCityLabel = CustomLabel(
        titleColor: #colorLiteral(red: 0.7954172492, green: 0.06422527134, blue: 0.6702669859, alpha: 1),
        font: UIFont(name: "Arial-BoldMT", size: 18),
        numberOfLines: 2)


    private let endCityLabel = CustomLabel(
        titleColor: #colorLiteral(red: 0.7954172492, green: 0.06422527134, blue: 0.6702669859, alpha: 1),
        font: UIFont(name: "Arial-BoldMT", size: 18),
        numberOfLines: 2)


    private let startDateLabel = CustomLabel(
        titleColor: .systemGray,
        font: UIFont(name: "ArialMT", size: 16))


    private let endDateLabel = CustomLabel(
        titleColor: .systemGray,
        font: UIFont(name: "ArialMT", size: 16))


    private let priceLabel = CustomLabel(
        titleColor: #colorLiteral(red: 0.5982286334, green: 0.004385416862, blue: 0.5994241834, alpha: 1),
        font: UIFont(name: "Arial-BoldMT", size: 22))


    private let likeButtonView = LikeButtonView(frame: .zero)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupCell(flight: Flight) {
        searchToken = flight.searchToken
        startCityLabel.text = flight.startCity
        endCityLabel.text = flight.endCity
        startDateLabel.text = dateConverter(flight.startDate)
        endDateLabel.text = dateConverter(flight.endDate)
        priceLabel.text = "\(flight.price) ₽"
        likeButtonView.setIsLiked(newLikeStatus: flight.isLiked)
    }

    private func dateConverter(_ date: String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss +SSSS Z"
        let dateOut = df.date(from: date)
        df.dateFormat = "d MMM, E"
        return df.string(from: dateOut ?? Date())
    }

    private func setupGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapLikeButton))
        likeButtonView.addGestureRecognizer(gesture)
    }

    @objc func didTapLikeButton() {
        self.delegate?.likeButtonDidTap(self, searchToken: searchToken)
    }

    private func layout() {
        contentView.addSubview(contentMainView)

        [   startCityLabel,
            endCityLabel,
            startDateLabel,
            endDateLabel,
            priceLabel,
            airplaneView,
            likeButtonView,
        ].forEach { contentMainView.addSubview($0) }

        NSLayoutConstraint.activate([
            contentMainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentMainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentMainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            contentMainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            contentView.heightAnchor.constraint(equalToConstant: 150),

            airplaneView.topAnchor.constraint(equalTo: contentMainView.topAnchor, constant: 20),
            airplaneView.centerXAnchor.constraint(equalTo: contentMainView.centerXAnchor),
            airplaneView.heightAnchor.constraint(equalToConstant: 35),
            airplaneView.widthAnchor.constraint(equalToConstant: 35),

            startCityLabel.centerYAnchor.constraint(equalTo: airplaneView.centerYAnchor, constant: 0),
            startCityLabel.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 10),
            startCityLabel.trailingAnchor.constraint(equalTo: airplaneView.leadingAnchor, constant: -10),

            endCityLabel.centerYAnchor.constraint(equalTo: airplaneView.centerYAnchor, constant: 0),
            endCityLabel.leadingAnchor.constraint(equalTo: airplaneView.trailingAnchor, constant: 10),
            endCityLabel.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -10),

            startDateLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor,constant: 10),
            startDateLabel.leadingAnchor.constraint(equalTo: startCityLabel.leadingAnchor),
            startDateLabel.trailingAnchor.constraint(equalTo: startCityLabel.trailingAnchor),

            endDateLabel.topAnchor.constraint(equalTo: endCityLabel.bottomAnchor,constant: 10),
            endDateLabel.leadingAnchor.constraint(equalTo: endCityLabel.leadingAnchor),
            endDateLabel.trailingAnchor.constraint(equalTo: endCityLabel.trailingAnchor),

            likeButtonView.bottomAnchor.constraint(equalTo: contentMainView.bottomAnchor, constant: -10),
            likeButtonView.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -10),
            likeButtonView.heightAnchor.constraint(equalToConstant: 35),
            likeButtonView.widthAnchor.constraint(equalToConstant: 35),

            priceLabel.centerYAnchor.constraint(equalTo: likeButtonView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: likeButtonView.leadingAnchor, constant: -20),

        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        likeButtonView.setIsLiked(newLikeStatus: false)
    }
}
