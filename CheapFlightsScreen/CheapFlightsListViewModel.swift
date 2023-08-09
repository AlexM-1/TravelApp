//
//  CheapFlightsListViewModel.swift
//  TravelAppWB
//
//  Created by Alex M on 08.08.2023.
//

import Foundation


final class CheapFlightsListViewModel {
    
    var flights: [Flight] { LocalData.default.flights }
    
    enum Action {
        case сheapFlightCellDidTap(Int)
        case likeButtonDidTap(String)
        case viewIsReady
    }
    
    enum State {
        case initial
        case loading
        case loaded
        case error
        case reload(Int)
    }
    
    private let coordinator: AppCoordinator
    
    var stateChanged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    private func fetchCheapFlights() {
        self.state = .loading
        NetworkManager().getCheapFlightsData { flightData in
            if let flightData {
                LocalData.default.flights = flightData
            }
            self.state = .loaded
        }
    }
    
    private func changeLikeStatusForFlight(flightSearchToken: String) {
        guard let index = flights.firstIndex(where: { $0.searchToken == flightSearchToken }) else { return }
        
        if LocalData.default.flights[index].isLiked == nil {
            LocalData.default.flights[index].isLiked = true
            self.state = .reload(index)
        } else {
            LocalData.default.flights[index].isLiked?.toggle()
            self.state = .reload(index)
        }
    }
    
    
    func changeState(_ action: Action) {
        switch action {
            
        case .сheapFlightCellDidTap(let index):
            coordinator.showOneCheapFlightVC(flight: flights[index])
            
        case .likeButtonDidTap(let searchToken):
            changeLikeStatusForFlight(flightSearchToken: searchToken)
            
        case .viewIsReady:
            fetchCheapFlights()
        }
    }
    
}

