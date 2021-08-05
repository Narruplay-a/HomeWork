//
//  HomeWork2App.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 12.07.2021.
//

import SwiftUI
import CoreServicePackage
import HWUIComponents

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
            CustomTabBarView(model: getTabBarModel())
        }
    }
}

private extension HomeWork2App {
    func getTabBarModel() -> CustomTabBarModel {
        let model = CustomTabBarModel(screens: getScreens())
        let navigation: NavigationProtocol = Servicer.shared.resolve()
        navigation.registerTabBarView(with: model)
        
        return model
    }
    
    func getScreens() -> [TabScreen] {
        return [getFirstScreen(), getSecondScreen(), getThirdScreen()]
    }
    
    func getFirstScreen() -> TabScreen {
        let contentView = StockListScreen(viewModel: StockListViewModel())
        let navigationView = CustomNavigationView<StockListScreen>(view: contentView.anyView, id: 0)
        let navigation: NavigationProtocol = Servicer.shared.resolve()
        navigation.registerNavigationView(with: navigationView.model)
        
        return TabScreen(item: navigationView.anyView, tabItem: StockListScreen.tabItem.anyView)
    }
    
    func getSecondScreen() -> TabScreen {
        let contentView = FavoriteScreen(viewModel: FavoriteViewModel())

        return TabScreen(item: contentView.anyView, tabItem: FavoriteScreen.tabItem.anyView)
    }

    func getThirdScreen() -> TabScreen {
        let contentView = CalendarScreen(viewModel: CalendarViewModel())

        return TabScreen(item: contentView.anyView, tabItem: CalendarScreen.tabItem.anyView)
    }
}
