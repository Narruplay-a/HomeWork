//
//  CalendarScreen.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 16.07.2021.
//

import SwiftUI

struct CalendarScreen: View {
    @ObservedObject var model: CalendarModel
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List(model.ipoData) { ipoItemData in
                IPOItem(data: ipoItemData)
                    .onTapGesture {
                        self.navigationService.show(view:
                                                        CompanyOverviewScreen(model: CompanyOverviewModel(symbol: ipoItemData.symbol)).anyView)
                    }
            }
            .padding(.top, 20)
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            navigationService.showTabBar()
            navigationService.updateNavigation(with: "Календарь IPO")
            model.requestData()
        }
    }
    
    static var tabItem: some View {
        VStack {
            Image(systemName: "calendar")
            Text("Календарь")
        }
    }
}
