import SwiftUI
import Charts

struct DashboardView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var settingsData: SettingsData
    
    @State private var selectedTeam: String?
    
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
                    
                    NavigationLink(destination: SettingsView()) {
                        Text("Go to Settings")
                            .font(.title2)
                            .padding()
                            .cornerRadius(10)
                    }
                    .buttonStyle(BorderedButtonStyle())
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
                        Chart(modelData.teamGoals.prefix(5)) { teamGoal in
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
                        Chart(modelData.teamWins) { teamWin in
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
                            ForEach(modelData.teamWins.prefix(10), id: \.team) { teamWin in
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
            .background(settingsData.bgColor.color)
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(ModelData())
        .environmentObject(SettingsData())
}
