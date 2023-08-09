//
//  OneCheapFlightVC.swift
//  TravelAppWB
//
//  Created by Alex M on 08.08.2023.
//

import UIKit

class OneCheapFlightVC: UIViewController {

    private var flight: Flight

    init(flight: Flight) {
        self.flight = flight
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7954172492, green: 0.06422527134, blue: 0.6702669859, alpha: 1)
        navigationItem.title = "Подробная информация"
        setup()
        layout()
        setupGestures()
    }

    private let contentMainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9660720229, green: 0.9660721421, blue: 0.9660720229, alpha: 1)
        return view
    }()


    private let arrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.5982286334, green: 0.004385416862, blue: 0.5994241834, alpha: 1)
        imageView.image = UIImage(systemName: "arrow.down")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    private let startCityLabel = CustomLabel(
        titleColor: #colorLiteral(red: 0.7954172492, green: 0.06422527134, blue: 0.6702669859, alpha: 1),
        font: UIFont(name: "Arial-BoldMT", size: 22),
        numberOfLines: 3,
        textAlignment: .left)


    private let endCityLabel = CustomLabel(
        titleColor: #colorLiteral(red: 0.7954172492, green: 0.06422527134, blue: 0.6702669859, alpha: 1),
        font: UIFont(name: "Arial-BoldMT", size: 22),
        numberOfLines: 3,
        textAlignment: .left)


    private let startDateLabel = CustomLabel(
        titleColor: .systemGray,
        font: UIFont(name: "ArialMT", size: 18),
        numberOfLines: 2,
        textAlignment: .left)


    private let endDateLabel = CustomLabel(
        titleColor: .systemGray,
        font: UIFont(name: "ArialMT", size: 18),
        numberOfLines: 2,
        textAlignment: .left)


    private let priceLabel = CustomLabel(
        titleColor: #colorLiteral(red: 0.5982286334, green: 0.004385416862, blue: 0.5994241834, alpha: 1),
        font: UIFont(name: "Arial-BoldMT", size: 26),
        textAlignment: .left)


    private let searchToken = CustomLabel(
        titleColor: #colorLiteral(red: 0.7954172492, green: 0.06422527134, blue: 0.6702669859, alpha: 1),
        font: UIFont(name: "Arial-BoldMT", size: 22),
        numberOfLines: 2,
        textAlignment: .left)


    private let likeButtonView = LikeButtonView(frame: .zero)


    func setup() {
        startCityLabel.text = "Город отправления: \n\(flight.startCity) \n(\(flight.startLocationCode))"
        endCityLabel.text = "Город прибытия: \n\(flight.endCity) \n(\(flight.endLocationCode))"
        startDateLabel.text = "Дата отправления: \n\(dateConverter(flight.startDate))"
        endDateLabel.text = "Дата возращения: \n\(dateConverter(flight.endDate))"
        priceLabel.text = "Стоимость: \(flight.price) ₽"
        likeButtonView.setIsLiked(newLikeStatus: flight.isLiked)
        searchToken.text = "Код поиска рейса: \n\(flight.searchToken)"
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
        changeLikeStatusForFlight(flightSearchToken: flight.searchToken)
    }

    private func changeLikeStatusForFlight(flightSearchToken: String) {
        guard let index = LocalData.default.flights.firstIndex(where: { $0.searchToken == flightSearchToken }) else { return }

        if LocalData.default.flights[index].isLiked == nil {
            LocalData.default.flights[index].isLiked = true
        } else {
            LocalData.default.flights[index].isLiked?.toggle()
        }
        flight = LocalData.default.flights[index]
        likeButtonView.setIsLiked(newLikeStatus: flight.isLiked)
    }

    private func layout() {
        view.addSubview(contentMainView)

        [   startCityLabel,
            endCityLabel,
            startDateLabel,
            endDateLabel,
            priceLabel,
            arrowView,
            searchToken,
            likeButtonView,
        ].forEach { contentMainView.addSubview($0) }

        NSLayoutConstraint.activate([
            contentMainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20),
            contentMainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            contentMainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -7),
            contentMainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),

            startCityLabel.topAnchor.constraint(equalTo: contentMainView.topAnchor, constant: 10),
            startCityLabel.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 10),
            startCityLabel.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -10),

            startDateLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor,constant: 10),
            startDateLabel.leadingAnchor.constraint(equalTo: startCityLabel.leadingAnchor),
            startDateLabel.trailingAnchor.constraint(equalTo: startCityLabel.trailingAnchor),

            arrowView.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 40),
            arrowView.centerXAnchor.constraint(equalTo: contentMainView.centerXAnchor),
            arrowView.heightAnchor.constraint(equalToConstant: 50),
            arrowView.widthAnchor.constraint(equalToConstant: 50),

            endCityLabel.topAnchor.constraint(equalTo: arrowView.bottomAnchor, constant: 40),
            endCityLabel.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 10),
            endCityLabel.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -10),

            endDateLabel.topAnchor.constraint(equalTo: endCityLabel.bottomAnchor,constant: 10),
            endDateLabel.leadingAnchor.constraint(equalTo: endCityLabel.leadingAnchor),
            endDateLabel.trailingAnchor.constraint(equalTo: endCityLabel.trailingAnchor),

            likeButtonView.bottomAnchor.constraint(equalTo: contentMainView.bottomAnchor, constant: -10),
            likeButtonView.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -10),
            likeButtonView.heightAnchor.constraint(equalToConstant: 50),
            likeButtonView.widthAnchor.constraint(equalToConstant: 50),

            searchToken.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor,constant: 40),
            searchToken.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 10),
            searchToken.trailingAnchor.constraint(equalTo: contentMainView.trailingAnchor, constant: -10),

            priceLabel.centerYAnchor.constraint(equalTo: likeButtonView.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: contentMainView.leadingAnchor, constant: 10),
        ])
    }
}






