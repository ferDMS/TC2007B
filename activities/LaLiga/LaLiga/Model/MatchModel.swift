//
//  MatchModel.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//

import Foundation

struct MatchModel: Identifiable {
    var id: String
    var Season: String
    var Date: String
    var HomeTeam: String
    var AwayTeam: String
    var FTHG: String
    var FTAG: String
    var FTR: String
    var HTHG: String
    var HTAG: String
    var HTR: String
    var isCustom: Bool = false
}

struct TeamGoals: Identifiable {
    let id = UUID()
    let team: String
    let goals: Int
}

struct TeamWins: Identifiable {
    let id = UUID()
    let team: String
    let wins: Int
}

struct TeamPerformance: Identifiable {
    var id = UUID()
    var season: String
    var goals: Int
}
