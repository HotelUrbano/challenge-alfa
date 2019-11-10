//
//  Coordinator.swift
//  Challange HURB - Alpha
//
//  Created by Luiz Fernando Cunha Duarte on 05/11/19.
//  Copyright © 2019 Luiz Fernando Cunha Duarte. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var presentedViewController: UIViewController?
    
    var dataManager = DataManager()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
        self.dataManager.coordinatorComunicationDelegate = self
    }
    
    func start() {
        let startViewController = try! InitialViewController.initializeFromStoryboard()
        startViewController.coordinator = self
        presentedViewController = startViewController
        navigationController.pushViewController(startViewController, animated: false)
    }
    
    func instantiateView(for state: AppState) {
        switch state {
        case .loading:
            break
        case .loadingError:
            self.popUpAlert()
        case .feedPrepared:
            self.instatiateFeed()
        }
    }
        
    private func popUpAlert() {
        let alert = UIAlertController(title: "Erro de Conexão",
                                      message: "Não foi possível carregar as ofertas. Tente novemente mais tarde",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        guard let presentedViewController = presentedViewController else { fatalError("Nenhuma view controller foi instaciada")}
        presentedViewController.present(alert,animated: true)
    }
    
    private func instatiateFeed() {
        let feedViewController = try! FeedViewController.initializeFromStoryboard()
        feedViewController.coordinator = self
        feedViewController.dataSource = FeedDataSource(hotels: dataManager.hotels,
                                                       packages: dataManager.packages)
        presentedViewController = feedViewController
        navigationController.pushViewController(feedViewController, animated: true)
    }
    
}

extension MainCoordinator: CoordinatorComunicationDelegate {
    var coordinator: MainCoordinator? {
        return self
    }
}

enum AppState {
    case loading,loadingError,feedPrepared
}
