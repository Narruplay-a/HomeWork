//
//  HomeWork2App.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 12.07.2021.
//

import SwiftUI
import CoreServicePackage

@main
struct HomeWork2App: App {
    init() {
        Servicer.shared.register(with: .application) {
            return NavigationService() as NavigationProtocol
        }
        
        Servicer.shared.register(with: .application) {
            return StoreService() as StoreProtocol
        }
        
        Servicer.shared.register(with: .application) {
            return ApiService() as ApiServiceProtocol
        }
    }
    
    var body: some Scene {
        WindowGroup {
            CustomTabBarView(model: CustomTabBarModel(screens: getScreens()))
        }
    }
}

private extension HomeWork2App {
    func getScreens() -> [TabScreen] {
        return [getFirstScreen(), getSecondScreen(), getThirdScreen()]
    }
    
    func getFirstScreen() -> TabScreen {
        let contentView = StockListScreen(model: StockListModel())

        let navigationView = CustomNavigationView<StockListScreen>(view: contentView.anyView, id: 0)
        
        return TabScreen(item: navigationView.anyView, tabItem: StockListScreen.tabItem.anyView)
    }
    
    func getSecondScreen() -> TabScreen {
        let contentView = FavoriteScreen(model: FavoriteModel())

        return TabScreen(item: contentView.anyView, tabItem: FavoriteScreen.tabItem.anyView)
    }

    func getThirdScreen() -> TabScreen {
        let contentView = CalendarScreen(model: CalendarModel())

        return TabScreen(item: contentView.anyView, tabItem: CalendarScreen.tabItem.anyView)
    }
}
