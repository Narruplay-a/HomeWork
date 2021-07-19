//
//  CustomNavigationContent.swift
//  Osago
//
//  Created by Adel Khaziakhmetov on 02.07.2021.
//

import SwiftUI
import Combine

public struct CustomNavigationView<Content>: View where Content: View {
    @EnvironmentObject var navigationService: NavigationService
    @ObservedObject var model: CustomNavigationViewModel

    private let navigationBarHeight: CGFloat = 80
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    public init(transition: NavTransition,
                easing: Animation = .easeOut(duration: 0.33),
                view: AnyView) {
        model = CustomNavigationViewModel(easing: easing,
                                         screenStack: ScreenStack(screens: [Screen(screen: view)]))
        switch transition {
            case .custom(let trans):
                transitions = (trans, trans)
            case .none:
                transitions = (.identity, .identity)
        }
    }
    
    public init(transition: NavTransition,
                easing: Animation = .easeOut(duration: 0.33),
                navigationStack: [AnyView]) {
        let stack: [Screen] = navigationStack.map { Screen(screen: $0) }
        model = CustomNavigationViewModel(easing: easing, screenStack: ScreenStack(screens: stack))
        
        switch transition {
            case .custom(let trans):
                transitions = (trans, trans)
            case .none:
                transitions = (.identity, .identity)

        }
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            if model.shouldShowNavigationBar {
                CustomNavigationBarView(model: model.navigationBarModel)
                    .frame(maxWidth: .infinity,
                           minHeight: navigationBarHeight,
                           maxHeight: navigationBarHeight,
                           alignment: .bottom)
            }
            
            model.currentScreen!.screen
                .transition(model.navigationType == .push ? transitions.push : transitions.pop)
                .padding(.top, navigationBarHeight)
        }
        .ignoresSafeArea()
        .onAppear {
            navigationService.registerNavigationView(with: model)
        }.onReceive(model.navigationSubject, perform: { _ in
            self.model.pop()
        })
    }
}
