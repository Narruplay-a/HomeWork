//
//  CustomNavigationModel.swift
//  Osago
//
//  Created by Adel Khaziakhmetov on 02.07.2021.
//

import SwiftUI
import Combine
import CoreServicePackage

final class CustomNavigationViewModel: ObservableObject, NavigationModelProtocol {
    @Published var currentScreen: Screen?
    @Published var shouldShowNavigationBar  : Bool      = true
    @Published var shouldShowbackButton     : Bool      = false
    @Published var title                    : String    = ""
    
    let navigationSubject: PassthroughSubject<Bool, Never> = PassthroughSubject()
    lazy var navigationBarModel = CustomNavigationBarModel(navigationSubject: navigationSubject,
                                                           title: $title,
                                                           shouldShowBackButton: $shouldShowbackButton)
    
    private var screenStack: ScreenStack {
        didSet {
            currentScreen = screenStack.top()
        }
    }

    var navigationType: NavType = .push
    var id: Int = 0
 
    private(set) var navigationIndex: Int = 0
    private let easing: Animation = Animation.easeInOut(duration: 0.3)
    
    init(screenStack: ScreenStack, id: Int) {
        self.id = id
        self.screenStack = screenStack
        self.currentScreen = screenStack.top()
        navigationIndex = screenStack.screenCount - 1
    }
    
    func push<S: View>(_ screenView: S) {
        shouldShowbackButton = true
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(screen: AnyView(screenView))
            screenStack.push(screen)
            navigationIndex += 1
        }
    }
    
    func pop(to: PopDestination = .previous) {
        shouldShowbackButton = !(navigationIndex == 1 || to == .root)
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .root:
                screenStack.popToRoot()
                navigationIndex = 0
            case .previous:
                guard navigationIndex > 0 else { return }
                screenStack.popToPrevious()
                navigationIndex -= 1
            }
        }
    }
}

public struct ScreenStack {
    private var screens: [Screen]
    var screenCount: Int { return screens.count }
    
    init(screens: [Screen]) {
        self.screens = screens
    }
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}

struct Screen: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let screen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

enum NavType {
    case push
    case pop
}
