//
//  NavigationService.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 12.07.2021.
//

import SwiftUI

final class NavigationService: ObservableObject {
    static let shared = NavigationService()
    
    private weak var navigation: CustomNavigationViewModel?
    private weak var tabBar: CustomTabBarModel?
    
    func registerTabBarView(with model: CustomTabBarModel) {
        self.tabBar = model
    }

    func registerNavigationView(with model: CustomNavigationViewModel) {
        self.navigation = model
    }
    
    func selectTab(with index: Int) {
        guard index < tabBar?.screens.count ?? 0 else { return }
        
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
