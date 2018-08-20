//
//  CarTypesListVC.swift
//  QuadWheels
//
//  Created by Jitendra on 01/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class ModelsListVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loaderView: LoadingView!

    // MARK: - Properties
    
    internal var manufacturerInfo: ManufacturerInfo?
    
    internal var modelsArray: [ModelName]?
    
    internal let cellIdentifier: String = "ModelsCell"
    
    internal var pagingModel: PagingViewModel<[ModelName:ModelName], ModelName>!

    // MARK: - View Hierarchy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let manufacturerId = manufacturerInfo?.id else { return }

        let parameters = ["manufacturer": manufacturerId]
        
        pagingModel = PagingViewModel<[ModelName:ModelName], ModelName>(endPoint: .mainTypes,
                                                                        parameters: parameters,
                                                                        transform: { result -> [ModelName] in
                                                                        
            return Array(result.values)
        })
        
        loadModels()
    }
    
    // MARK: - Loader Method
    
    internal func loadModels() {
        
        let loadingInfo = pagingModel.loadMoreData { [weak self] (data, error, page) in
            
            ActivityIndicator.stopAnimating()

            DispatchQueue.main.async {
                if let data = data {
                    self?.modelsArray = data
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
                ActivityIndicator.startAnimating(cancel: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                })
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
            self?.loadModels()
        }
        alertController.addAction(retryAction)

        let dismissAction = UIAlertAction(title: "Go Back", style: .destructive) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    internal func showInfoAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Info",
                                                message: message,
                                                preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
