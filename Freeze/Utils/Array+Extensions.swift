//
//  Array+Extensions.swift
//  Freeze
//
//  Created by Jan Podmolík on 07.02.2021.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}
