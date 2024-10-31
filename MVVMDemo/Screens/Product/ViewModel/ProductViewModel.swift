//
//  ProductViewModel.swift
//  MVVMDemo
//
//  Created by Pritam Bhadrashette on 24/10/24.
//

import Foundation

final class ProductViewModel {
    var products : [ProductModel] = []
    var eventHandler : ((_ event : Event) -> Void)?
    
    func fetchProducts(){
        self.eventHandler?(.loading)
        APIManager.shared.fetchProduct { response in
            self.eventHandler?(.stopLoading)
            switch response{
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error (Error?)
    }
}
