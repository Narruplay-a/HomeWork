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
    @Resolved
    var navigationService   : NavigationProtocol

    @ObservedObject
    var viewModel           : CompanyOverviewViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                        TickerTempView(name: viewModel.company?.symbol ?? "!")
                        Spacer()
                    }.padding([.bottom, .top], 20)
                    
                    
                    Text("Тикер")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(viewModel.company?.symbol ?? "")
                        .font(.system(size: 14))
                        .padding(.bottom, 15)
                    Text("Наименование")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(viewModel.company?.name ?? "")
                        .font(.system(size: 14))
                        .padding(.bottom, 15)
                    Text("Страна регистрации")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(viewModel.company?.country ?? "")
                        .font(.system(size: 14))
                        .padding(.bottom, 15)
                    Text("Описание")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(viewModel.company?.description ?? "")
                        .font(.system(size: 14))
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom , 100)
            }
            
            if let companyEntity = viewModel.company {
                VStack {
                    Spacer()
                    Button {
                        self.navigationService.show(view:
                                                        CompanyDetailScreen(viewModel: CompanyDetailViewModel(company: companyEntity)).anyView)
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
            navigationService.updateNavigation(with: viewModel.symbol)
            navigationService.hideTabBar()
            
            viewModel.loadCompanyData()
        }
        .onReceive(viewModel.$isDataLoading) { value in
            if value {
                navigationService.present(view: LoadingModal().anyView)
            } else {
                navigationService.dismiss()
            }
        }.onReceive(viewModel.$isDataEmpty, perform: { value in
            if value {
                navigationService.present(view: ErrorModal(shouldShowModal: $viewModel.isDataEmpty).anyView)
            } else {
                navigationService.dismiss()
            }
        })
    }
}
