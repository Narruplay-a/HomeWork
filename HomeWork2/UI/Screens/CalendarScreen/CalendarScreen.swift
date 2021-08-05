//
//  CalendarScreen.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 16.07.2021.
//

import SwiftUI
import CoreServicePackage
import HWUIComponents

struct CalendarScreen: View {
    @ObservedObject var model: CalendarModel
    @Resolved var navigationService: NavigationProtocol
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                HStack {
                    Spacer()
                    Text("Календарь IPO")
                        .lineLimit(0)
                        .font(.system(size: 18).bold())
                        .fixedSize(horizontal: false, vertical: false)
                        .padding(.bottom, 10)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.05))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            
            VStack(alignment: .leading, spacing: 0) {
                List(model.ipoData) { ipoItemData in
                    IPOItem(symbol: ipoItemData.symbol, date: ipoItemData.date)
                }
                .padding(.top, 20)
                .frame(maxHeight: .infinity)
            }
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        .onAppear {
            model.requestData()
        }
    }
    
    static var tabItem: some View {
        VStack {
            Image(systemName: "calendar")
            Text("Календарь IPO")
        }
    }
}
