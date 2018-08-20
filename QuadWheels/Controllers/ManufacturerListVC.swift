//
//  ViewController.swift
//  QuadWheels
//
//  Created by Jitendra on 01/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class ManufacturerListVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loaderView: LoadingView!

    // MARK: - Properties

    internal var manufacturerInfoArray: [ManufacturerInfo]?
    
    internal let cellIdentifier: String = "ManufacturerCell"
    
    internal var pagingModel: PagingViewModel<[ManufacturerId:ManufacturerName], ManufacturerInfo>!
    
    // MARK: - View Hierarchy
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pagingModel = PagingViewModel<[ManufacturerId:ManufacturerName], ManufacturerInfo>(endPoint: .manufacturer,
                                                                                           transform: { result -> [ManufacturerInfo] in
                                                                                    
            //Sorting received data based on `id` & storing in datasource.
            return result.keys.sorted().map({ ManufacturerInfo($0, result[$0]!) })
        })
        
        loadManufacturers()
    }
    
    // MARK: - Loader Method
    
    internal func loadManufacturers() {
        
        let loadingInfo = pagingModel.loadMoreData { [weak self] (data, error, page) in
            
            ActivityIndicator.stopAnimating()

            DispatchQueue.main.async {
                if let data = data {
                    self?.manufacturerInfoArray = data
                    self?.tableView.reloadData()
                    self?.loaderView.hide()
                } else if let error = error {
                    if page == 0 {
                        self?.showErrorAlert(with: error.localizedDescription)
                    } else {
                        self?.loaderView.showMessage("Error loading data.", animateLoader: false, autoHide: 5.0)
                    }
                }
            }
        }
        
        if loadingInfo.isLoading {
            if loadingInfo.page == 0 {
                ActivityIndicator.startAnimating()
            } else {
                loaderView.showMessage("Loading...", animateLoader: true)
            }
        } else {
            loaderView.hide()
        }
    }
    
    // MARK: - Alerts
    
    private func showErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadManufacturers()
        }
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Navigation
    
    internal func pushModelsScene(with info: ManufacturerInfo) {
        guard let modelsVC = Navigation.getViewController(type: ModelsListVC.self,
                                                          identifer: "ModelsList") else { return }
        modelsVC.manufacturerInfo = info
        navigationController?.pushViewController(modelsVC, animated: true)
    }
}
