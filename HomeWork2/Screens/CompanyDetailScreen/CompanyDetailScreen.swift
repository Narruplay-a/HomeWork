//
//  CompanyDetailScreen.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import CoreServicePackage

struct CompanyDetailScreen: View {
    @Resolved
    var navigationService   : NavigationProtocol
    
    @ObservedObject
    var viewModel           : CompanyDetailViewModel

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text("Биржа")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                        Text(viewModel.company.exchange)
                            .font(.system(size: 14))
                            .padding(.bottom, 15)
                        Text("Сектор")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(viewModel.company.sector)
                            .font(.system(size: 14))
                            .padding(.bottom, 15)
                        Text("Индустрия")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(viewModel.company.industry)
                            .font(.system(size: 14))
                            .padding(.bottom, 15)
                        Text("Капитализация")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(viewModel.company.marketCapitalization)
                            .font(.system(size: 14))
                    }

                    if let value = viewModel.company.dividendPerShare {
                        Text("Дивиденды на акцию")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.top, 15)
                        Text(String(format: "%.2f", value))
                            .font(.system(size: 14))
                    }
    
                    if let value = viewModel.company.PERatio {
                        Text("P/E")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.top, 15)
                        Text(String(format: "%.2f", value))
                            .font(.system(size: 14))
                    }
    
                    if let value = viewModel.company.eps {
                        Text("EPS")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.top, 15)
                        Text(String(format: "%.2f", value))
                            .font(.system(size: 14))
                    }
                }
                
                Spacer()
            }.padding([.leading, .trailing], 16)
        }
        .onAppear {
            navigationService.updateNavigation(with: viewModel.company.symbol)
        }
    }
}
