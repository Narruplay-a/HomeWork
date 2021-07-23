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
    private let transitions: (push: AnyTransition, pop: AnyTransition) = (AnyTransition.opacity, AnyTransition.opacity)
    
    public init(view: AnyView, id: Int) {
        model = CustomNavigationViewModel(screenStack: ScreenStack(screens: [Screen(screen: view)]), id: id)
    }
    
    public init(navigationStack: [AnyView], id: Int) {
        let stack: [Screen] = navigationStack.map { Screen(screen: $0) }
        model = CustomNavigationViewModel(screenStack: ScreenStack(screens: stack), id: id)
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
            print(String(format: "Appear: %ld", model.id))
            navigationService.registerNavigationView(with: model)
        }.onReceive(model.navigationSubject, perform: { _ in
            self.model.pop()
        })
    }
}
