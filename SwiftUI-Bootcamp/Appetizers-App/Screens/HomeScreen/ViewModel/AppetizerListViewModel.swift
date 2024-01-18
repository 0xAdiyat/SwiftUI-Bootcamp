//
//  AppetizerListViewModel.swift
//  SwiftUI-Bootcamp
//
//  Created by Ahsaf Hussain Adiyat on 18/1/24.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject{
    
    @Published var alertItem: APAlertItem?
    
    @Published var appetizers: [Appetizer] = []
    
    @Published var isLoading: Bool = false
    
    @Published var isShowingDetail = false
    
    @Published var selectedAppetizer: Appetizer?
    
    func getAppetizers(){
        isLoading = true
        NetworkManager.shared.getAppetizers { result in
            DispatchQueue.main.async{ [self] in
                isLoading = false
                switch result {
                    case let .success(appetizers):
                        self.appetizers = appetizers
                        
                    case let .failure(err):
                        switch err{
                                
                            case .invalidURL:
                                alertItem = APAlertContext.invalidURL
                            
                            case .invalidResponse:
                                alertItem = APAlertContext.invalidResponse
                            case .invalidData:
                                alertItem = APAlertContext.invalidData
                            case .unableToComplete:
                                alertItem = APAlertContext.unableToComplete
                        }

                }
            }
        }
    }

}
