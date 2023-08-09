//
//  CheapFlightsListVC.swift
//  TravelAppWB
//
//  Created by Alex M on 08.08.2023.
//

import UIKit

class CheapFlightsListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let viewModel: CheapFlightsListViewModel

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init(viewModel: CheapFlightsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7954172492, green: 0.06422527134, blue: 0.6702669859, alpha: 1)
        title = "Актуальные дешевые авиаперелеты"
        bindViewModel()
        setupView()
        viewModel.changeState(.viewIsReady)
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    private func bindViewModel() {
        viewModel.stateChanged = { [weak self] state in
            switch state {
            case .initial:
                print("")
            case .loading:
                DispatchQueue.main.async {
                    self?.activityIndicator.startAnimating()
                    self?.activityIndicator.isHidden = false
                }
            case .loaded:
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.tableView.reloadData()
                }
            case .error:
                print("error")
            case .reload(let index):
                self?.tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CheapFlightCell.self, forCellReuseIdentifier: "CheapFlightCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()


    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        createViewConstraint()
    }


    private func createViewConstraint() {
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ])
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.flights.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheapFlightCell", for: indexPath) as! CheapFlightCell
        cell.delegate = self
        let flight = viewModel.flights[indexPath.row]
        cell.setupCell(flight: flight)
        return cell
    }


    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.changeState(.сheapFlightCellDidTap(indexPath.row))
    }

}



extension CheapFlightsListVC: CheapFlightCellDelegate {
    func likeButtonDidTap(_ sender: CheapFlightCell, searchToken: String) {
        viewModel.changeState(.likeButtonDidTap(searchToken))
    }

}
