//
//  CompanyOverviewScreen.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import CoreServicePackage
import HWUIComponents

struct CompanyOverviewScreen: View {
    @Resolved var navigationService: NavigationProtocol
    @Resolved var storeService: StoreProtocol
    
    @ObservedObject var model: CompanyOverviewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                        TickerTempView(name: model.company?.symbol ?? "!")
                        Spacer()
                    }.padding([.bottom, .top], 20)
                    
                    
                    Text("Тикер")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(model.company?.symbol ?? "")
                        .font(.system(size: 14))
                        .padding(.bottom, 15)
                    Text("Наименование")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(model.company?.name ?? "")
                        .font(.system(size: 14))
                        .padding(.bottom, 15)
                    Text("Страна регистрации")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(model.company?.country ?? "")
                        .font(.system(size: 14))
                        .padding(.bottom, 15)
                    Text("Описание")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(model.company?.description ?? "")
                        .font(.system(size: 14))
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom , 100)
            }
            
            if let companyEntity = model.company {
                VStack {
                    Spacer()
                    Button {
                        self.navigationService.show(view: CompanyDetailScreen(model: CompanyDetailModel(company: companyEntity)).anyView)
                    } label: {
                        Text("Детальная информация о компании")
                            .font(.system(size: 16).bold())
                            .foregroundColor(.white)
                            .padding(.all, 20)
                    }
                    .background(Color.blue)
                    .cornerRadius(6)
                    .padding([.top, .bottom], 20)
                }
                .padding([.leading, .trailing], 20)
            }
        }
        .onAppear {
            navigationService.updateNavigation(with: model.symbol)
            navigationService.hideTabBar()
            model.loadCompanyData()
        }
        .onReceive(model.$isDataLoading) { value in
            if value {
                navigationService.present(view: LoadingModal().anyView)
            } else {
                navigationService.dismiss()
            }
        }.onReceive(model.$isDataEmpty, perform: { value in
            if value {
                navigationService.present(view: ErrorModal(shouldShowModal: $model.isDataEmpty).anyView)
            } else {
                navigationService.dismiss()
            }
        })
    }
}
