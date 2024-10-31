//
//  ProductListViewController.swift
//  MVVMDemo
//
//  Created by Admin on 25/10/24.
//

import UIKit
class ProductListViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        
    }
    
    
}

extension ProductListViewController {
    func configuration(){
        self.productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        initViewModel()
        observeEvent()
        
    }
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    // data binding observe karega ----- connection
    // we are using closure as ann intermediatory between viewModel and view
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else{return}
            switch event {
            case .loading:
                print("Product loading...")
            case .stopLoading:
                print("Products loading...")
            case .dataLoaded:
                print("Data loaded...")
                print(self.viewModel.products)
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension ProductListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else{
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}
