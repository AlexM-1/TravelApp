
import UIKit

final class AppCoordinator {

    private var navController: UINavigationController

    init(navController: UINavigationController) {
        self.navController = navController
    }

    func startApplication() {
        let viewModel = CheapFlightsListViewModel(coordinator: self)
        let controller = CheapFlightsListVC(viewModel: viewModel)
        self.navController.pushViewController(controller, animated: true)
    }

    func showOneCheapFlightVC(flight: Flight) {
        let controller = OneCheapFlightVC(flight: flight)
        self.navController.pushViewController(controller, animated: true)
    }

}
