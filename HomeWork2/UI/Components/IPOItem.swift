//
//  IPOItem.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import SwiftUI

struct IPOItem: View {
    let data: IPOData
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 10) {
                Text("Тикер:")
                    .font(.system(.caption))
                    .foregroundColor(.gray)
                Text(data.symbol)
                    .font(.system(.headline))
            }
            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                Text("Дата:")
                    .font(.system(.caption))
                    .foregroundColor(.gray)
                Text(data.date)
                    .font(.system(.headline))
            }
        }
    }
}
