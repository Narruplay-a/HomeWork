//
//  SetExtension.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import Combine

extension Set where Element == AnyCancellable {
    func cancelAll() {
        for cancellable in self {
            cancellable.cancel()
        }
    }
}
