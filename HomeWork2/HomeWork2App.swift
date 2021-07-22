//
//  HomeWork2App.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 12.07.2021.
//

import SwiftUI

@main
struct HomeWork2App: App {
    var body: some Scene {
        WindowGroup {
            CustomTabBarView(model: CustomTabBarModel(screens: getScreens()))
                .environmentObject(NavigationService.shared)
        }
    }
}

extension HomeWork2App {
    func getScreens() -> [TabScreen] {
        return [getFirstScreen(), getSecondScreen(), getThirdScreen()]
    }
    
    func getFirstScreen() -> TabScreen {
        let contentView = StockListScreen(model: StockListModel())
            .environmentObject(NavigationService.shared)
            .environmentObject(StoreService.shared)
        let navigationView = CustomNavigationView<StockListScreen>(transition: .none, view: contentView.anyView, id: 0)
        
        return TabScreen(item: navigationView.anyView, tabItem: StockListScreen.tabItem.anyView)
    }
    
    func getSecondScreen() -> TabScreen {
        let contentView = FavoriteScreen(model: FavoriteModel(StoreService.shared))
            .environmentObject(NavigationService.shared)
            .environmentObject(StoreService.shared)
//        let navigationView = CustomNavigationView<FavoriteScreen>(transition: .none, view: contentView.anyView, id: 1)

        return TabScreen(item: contentView.anyView, tabItem: FavoriteScreen.tabItem.anyView)
    }

    func getThirdScreen() -> TabScreen {
        let contentView = CalendarScreen(model: CalendarModel())
            .environmentObject(NavigationService.shared)
            .environmentObject(StoreService.shared)
//        let navigationView = CustomNavigationView<CalendarScreen>(transition: .none, view: contentView.anyView, id: 2)

        return TabScreen(item: contentView.anyView, tabItem: CalendarScreen.tabItem.anyView)
        
    }
}
