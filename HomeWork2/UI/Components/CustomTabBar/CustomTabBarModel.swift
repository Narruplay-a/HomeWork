//
//  TabBarModel.swift
//  Osago
//
//  Created by Adel Khaziakhmetov on 02.07.2021.
//

import SwiftUI
import Combine

final class CustomTabBarModel: ObservableObject {
    var viewToPresentSubject: PassthroughSubject = PassthroughSubject<AnyView?, Never>()
    var viewToPresent: AnyView?
    
    @Published var selectedIndex: Int
    @Published var isTabBarVisible = true
    @Published var screens: [TabScreen]
    var currentScreen: AnyView {
        guard screens.count > selectedIndex else { return screens.first?.item ?? AnyView(EmptyView()) }
        
        return screens[selectedIndex].item
    }
    
    init(screens: [TabScreen], selectedIndex: Int = 0) {
        self.screens = screens
        self.selectedIndex = selectedIndex
        
        if screens.count == 1  {
            isTabBarVisible = false
        }
    }
    
    func updateScreens(screens: [TabScreen], selectedIndex: Int = 0, isTabBarVisible: Bool) {
        self.screens = screens
        self.selectedIndex = selectedIndex
        self.isTabBarVisible = isTabBarVisible
    }
    
    func selectTab(for index: Int) {
        self.selectedIndex = index
    }
    
    func present(view: AnyView) {
        viewToPresent = view
        viewToPresentSubject.send(view)
    }
    
    func dismissPresentedView() {
        viewToPresent = nil
        viewToPresentSubject.send(nil)
    }
}

final class TabScreen {
    var tabItem: AnyView?
    var item: AnyView
    
    init(item: AnyView, tabItem: AnyView? = nil) {
        self.item = item
        self.tabItem = tabItem
    }
}
