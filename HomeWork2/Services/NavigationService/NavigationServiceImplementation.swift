//
//  NavigationService.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 12.07.2021.
//

import SwiftUI

final class NavigationService: ObservableObject, NavigationProtocol {
    private var navigation: NavigationModelProtocol?
    private var tabBar: NavigationTabModelProtocol?
    
    var selectedTab: Int {
        return tabBar?.selectedIndex ?? 0
    }
    
    func registerTabBarView(with model: NavigationTabModelProtocol) {
        self.tabBar = model
    }

    func registerNavigationView(with model: NavigationModelProtocol) {
        self.navigation = model
    }
    
    func selectTab(with index: Int) {
        tabBar?.selectedIndex = index
    }
    
    func present(view: AnyView) {
        tabBar?.present(view: view)
    }
    
    func dismiss() {
        tabBar?.dismissPresentedView()
    }
    
    func show(view: AnyView) {
        navigation?.push(view)
    }
    
    func back(toRoot: Bool) {
        navigation?.pop(to: toRoot ? .root : .previous)
    }
    
    func showTabBar() {
        tabBar?.isTabBarVisible = true
    }
    
    func hideTabBar() {
        tabBar?.isTabBarVisible = false
    }
    
    func updateNavigation(with title: String) {
        navigation?.title = title
    }
}
