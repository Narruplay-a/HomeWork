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
    @ObservedObject var model       : StockListModel
    
    @State var reloadList: Bool = false
    @Resolved var navigationService : NavigationProtocol
    @Resolved var storeService      : StoreProtocol
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Picker("", selection: $model.segmentSelectedIndex) {
                Text("США")
                    .font(.system(size: 20))
                    .tag(0)
                Text("Россия")
                    .font(.system(size: 20))
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.leading, .trailing, .top], 20)
            
            List(model.stockData) { stock in
                VStack {
                    StockListItem(symbol: stock.symbol, name: stock.name, hideFavoriteIcon: false)
                        .onTapGesture {
                            self.navigationService.show(view:
                                                            CompanyOverviewScreen(model: CompanyOverviewModel(symbol: stock.symbol)).anyView)
                        }.onAppear {
                            if model.stockData.count > 10 && model.stockData.last?.symbol == stock.symbol {
                                model.requestAdditionalData()
                            }
                        }
                    
                    if model.stockData.count > 10 && model.stockData.last?.symbol == stock.symbol {
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
            model.requestInitialData()
        }
    }
    
    static var tabItem: some View {
        VStack {
            Image(systemName: "table")
            Text("Акции")
        }
    }
}
