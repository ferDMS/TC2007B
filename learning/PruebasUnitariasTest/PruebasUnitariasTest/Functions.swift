//
//  Functions.swift
//  PruebasUnitariasTestTests
//
//  Created by PEZ on 11/10/24.
//

import Foundation

func calcTotalWithTip(base: Double, tip: Double) -> Double {
    if tip < 0 || tip > 100 {
        return tip.isNaN ? 0 : 0
    }
    return base + base * (tip / 100)
}
