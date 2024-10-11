//
//  ModelData.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import Foundation
import Combine

class ModelData: ObservableObject {
    @Published var matchesList: [MatchModel] = []
    @Published var teamGoals: [TeamGoals] = []
    @Published var teamWins: [TeamWins] = []
    @Published var teamPerformance: [TeamPerformance] = []
    @Published var teamWinPerformance: [TeamPerformance] = []
    
    init() {
        loadMatches()
    }
    
    private func loadMatches() {
        let dataFetcher = DataFetcher()
        
        // Use a DispatchQueue to periodically check if dataFetcher.matchesList is populated
        DispatchQueue.global().async {
            while dataFetcher.matchesList.isEmpty {
                // Sleep for a short period to avoid busy-waiting
                usleep(100_000) // 100 milliseconds
            }
            
            // Once dataFetcher.matchesList is populated, update matchesList and derived data
            DispatchQueue.main.async {
                self.matchesList = dataFetcher.matchesList
                self.updateDerivedData()
                print("Updated list of matches from Firestore")
            }
        }
    }
    
    func addMatch(match: MatchModel) {
        
        let dataSender = DataSender()
        
        dataSender.addData(matchItem: match)
        
        matchesList.append(match)
    }
    
    private func updateDerivedData() {
        // Update teamGoals
        var goalsDict: [String: Int] = [:]
        for match in matchesList {
            if let fthg = Int(match.FTHG), let ftag = Int(match.FTAG) {
                goalsDict[match.HomeTeam, default: 0] += fthg
                goalsDict[match.AwayTeam, default: 0] += ftag
            }
        }
        teamGoals = goalsDict.map { TeamGoals(team: $0.key, goals: $0.value) }
            .sorted { $0.goals > $1.goals }

        // Update teamWins
        var winsDict: [String: Int] = [:]
        for match in matchesList {
            if match.FTR == "H" {
                winsDict[match.HomeTeam, default: 0] += 1
            } else if match.FTR == "A" {
                winsDict[match.AwayTeam, default: 0] += 1
            }
        }
        let sortedWins = winsDict.map { TeamWins(team: $0.key, wins: $0.value) }
            .sorted { $0.wins > $1.wins }
        let topTeams = sortedWins.prefix(10)
        let otherWins = sortedWins.dropFirst(10).reduce(0) { $0 + $1.wins }
        var result = Array(topTeams)
        if otherWins > 0 {
            result.append(TeamWins(team: "Others", wins: otherWins))
        }
        teamWins = result
    }
}
