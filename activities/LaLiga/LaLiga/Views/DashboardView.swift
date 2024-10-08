import SwiftUI
import Charts

struct DashboardView: View {
    @Environment(ModelData.self) var modelData
    
    @State var bgColor: BackgroundColor
    @State var fontColor: FontColor
    @State private var selectedTeam: String?
    
    var teamGoals: [TeamGoals] {
        var goalsDict: [String: Int] = [:]
        
        for match in modelData.matchesList {
            if let fthg = Int(match.FTHG), let ftag = Int(match.FTAG) {
                goalsDict[match.HomeTeam, default: 0] += fthg
                goalsDict[match.AwayTeam, default: 0] += ftag
            }
        }
        
        return goalsDict.map { TeamGoals(team: $0.key, goals: $0.value) }
            .sorted { $0.goals > $1.goals }
    }
    
    var teamWins: [TeamWins] {
        var winsDict: [String: Int] = [:]
        
        for match in modelData.matchesList {
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
        if (otherWins > 0) {
            result.append(TeamWins(team: "Others", wins: otherWins))
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        Text("Fernando Monroy")
                            .fontWeight(.bold)
                        Spacer()
                        Text("A01750536")
                            .fontWeight(.bold)
                    }
                    
                    NavigationLink(destination: SettingsView(selectedBgColor: bgColor, selectedFontColor: fontColor)) {
                        Text("Go to Settings")
                            .font(.title2)
                            .padding()
                            .background(bgColor.colors[1])
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    
                    Text("Soccer Dashboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                    
                    Image("LaLiga")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding()
                                        
                    VStack(alignment: .leading) {
                        Text("Teams with Most Goals")
                            .font(.title)
                            .fontWeight(.bold)
                        Chart(teamGoals.prefix(5)) { teamGoal in
                            BarMark(
                                x: .value("Goals", teamGoal.goals),
                                y: .value("Team", teamGoal.team)
                            )
                            .foregroundStyle(by: .value("Team", teamGoal.team))
                        }
                        .chartXAxisLabel("Goals")
                        .chartYAxisLabel("Teams")
                    }
                    .padding()
                    .frame(height: 350)
                    
                    VStack(alignment: .leading) {
                        Text("Teams with Most Wins")
                            .font(.title)
                            .fontWeight(.bold)
                        Chart(teamWins) { teamWin in
                            SectorMark(
                                angle: .value("Wins", teamWin.wins),
                                innerRadius: .ratio(0.5),
                                outerRadius: .ratio(1.0)
                            )
                            .foregroundStyle(by: .value("Team", teamWin.team))
                            .annotation(position: .overlay) {
                                Text("\(teamWin.wins)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        .chartLegend(.visible)
                    }
                    .padding()
                    .frame(height: 350)
                    
                    VStack(alignment: .leading) {
                        Text("Performance by Team")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        VStack {
                            ForEach(teamWins.prefix(10), id: \.team) { teamWin in
                                Divider()
                                
                                NavigationLink(destination: DetailView(team: teamWin.team)) {
                                    HStack {
                                        Text(teamWin.team)
                                        Spacer()
                                    }
                                    .padding(.vertical, 10)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    DashboardView(bgColor: BackgroundColor.brown, fontColor: FontColor.black)
        .environment(ModelData())
}
