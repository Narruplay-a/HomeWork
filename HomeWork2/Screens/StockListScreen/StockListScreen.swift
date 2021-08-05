//
//  StockListScreen.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import Combine
import CoreServicePackage
import HWUIComponents

struct StockListScreen: View {
    @Resolved
    var navigationService   : NavigationProtocol
    @ObservedObject
    var viewModel           : StockListViewModel
    @State
    var reloadList          : Bool                  = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Picker("", selection: $viewModel.segmentSelectedIndex) {
                Text("США")
                    .font(.system(size: 20))
                    .tag(0)
                Text("Россия")
                    .font(.system(size: 20))
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.leading, .trailing, .top], 20)
            
            if !reloadList { EmptyView() }
            
            List(viewModel.stockData) { stock in
                VStack {
                    StockListItem(symbol: stock.symbol,
                                  name: stock.name,
                                  hideFavoriteIcon: viewModel.isStockIsFavorite(stock.symbol),
                                  favoriteCallback: { symbol in
                                    self.viewModel.addToFavorite(symbol)
                                    self.reloadList.toggle()
                                  })
                        .onTapGesture {
                            self.navigationService.show(view:
                                                            CompanyOverviewScreen(viewModel: CompanyOverviewViewModel(symbol: stock.symbol)).anyView)
                        }.onAppear {
                            if viewModel.stockData.count > 10 && viewModel.stockData.last?.symbol == stock.symbol {
                                viewModel.requestData(initial: false)
                            }
                        }
                    
                    if viewModel.stockData.count > 10 && viewModel.stockData.last?.symbol == stock.symbol {
                        Text("Загрузка данных..")
                            .padding(.all, 20)
                    }
                }
            }
            
            .padding(.top, 20)
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            navigationService.showTabBar()
            navigationService.updateNavigation(with: "Акции компаний")
            viewModel.requestData(initial: true)
            
            reloadList.toggle()
        }
    }
    
    static var tabItem: some View {
        VStack {
            Image(systemName: "table")
            Text("Акции")
        }
    }
}
