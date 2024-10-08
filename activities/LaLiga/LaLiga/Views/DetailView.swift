import SwiftUI
import Charts

struct DetailView: View {
    @EnvironmentObject var modelData: ModelData
    var team: String
    
    var teamPerformance: [TeamPerformance] {
        var performanceDict: [String: Int] = [:]
        
        for match in modelData.matchesList {
            if match.HomeTeam == team {
                performanceDict[match.Season, default: 0] += Int(match.FTHG) ?? 0
            } else if match.AwayTeam == team {
                performanceDict[match.Season, default: 0] += Int(match.FTAG) ?? 0
            }
        }
        
        // Drop last 2023-24 season since it's not over
        if let lastSeason = performanceDict.keys.max() {
            performanceDict.removeValue(forKey: lastSeason)
        }
        
        return performanceDict.map { TeamPerformance(season: $0.key, goals: $0.value) }
            .sorted { $0.season < $1.season }
    }
    
    var teamWinPerformance: [TeamPerformance] {
        var winDict: [String: Int] = [:]
        
        for match in modelData.matchesList {
            if (match.HomeTeam == team && match.FTR == "H") || (match.AwayTeam == team && match.FTR == "A") {
                winDict[match.Season, default: 0] += 1
            }
        }
        
        // Drop last 2023-24 season since it's not over
        if let lastSeason = winDict.keys.max() {
            winDict.removeValue(forKey: lastSeason)
        }
        
        return winDict.map { TeamPerformance(season: $0.key, goals: $0.value) }
            .sorted { $0.season < $1.season }
    }
    
    var body: some View {
        ScrollView {
            Text("Goal Performance for \(team)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            VStack {
                Chart(teamPerformance) { performance in
                    LineMark(
                        x: .value("Season", performance.season),
                        y: .value("Goals", performance.goals)
                    )
                    .foregroundStyle(.blue)
                }
                .chartXAxisLabel("Season")
                .chartYAxisLabel("Goals")
            }
            .padding()
            .frame(height: 350)
            
            Text("Win Performance for \(team)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            VStack {
                Chart(teamWinPerformance) { performance in
                    AreaMark(
                        x: .value("Season", performance.season),
                        y: .value("Wins", performance.goals)
                    )
                    .foregroundStyle(.green.opacity(0.5))
                    
                    LineMark(
                        x: .value("Season", performance.season),
                        y: .value("Wins", performance.goals)
                    )
                    .foregroundStyle(.green)
                }
                .chartXAxisLabel("Season")
                .chartYAxisLabel("Wins")
            }
            .padding()
            .frame(height: 350)
        }
    }
}

#Preview {
    DetailView(team: "Barcelona")
        .environmentObject(ModelData())
}
