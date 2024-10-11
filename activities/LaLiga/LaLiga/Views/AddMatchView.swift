//
//  AddMatchView.swift
//  LaLiga
//
//  Created by PEZ on 11/10/24.
//

import SwiftUI

struct AddMatchView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var settingsData: SettingsData
    
    @State private var season: String = ""
    @State private var date: String = ""
    @State private var homeTeam: String = ""
    @State private var awayTeam: String = ""
    @State private var fthg: String = ""
    @State private var ftag: String = ""
    @State private var ftr: String = ""
    @State private var hthg: String = ""
    @State private var htag: String = ""
    @State private var htr: String = ""

    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Form {
                TextField("Date", text: $date)
                TextField("Home Team", text: $homeTeam)
                TextField("Away Team", text: $awayTeam)
                TextField("Full-Time Home Goals", text: $fthg)
                TextField("Full-Time Away Goals", text: $ftag)
                
                Button(action: {
                    // Check for empty fields
                    if date.isEmpty || homeTeam.isEmpty || awayTeam.isEmpty || fthg.isEmpty || ftag.isEmpty {
                        alertMessage = "Debes ingresar información en todos los campos."
                        showAlert = true
                        return
                    }
                    
                    // Hardcode season
                    season = "2023-24"
                    // Hardcode half time result
                    hthg = "0"
                    htag = "0"
                    htr = "D"
                    // Calculate full time result (winner)
                    ftr = fthg > ftag ? "H" : ftag > fthg ? "A" : "D"
                    
                    // New match object
                    let newMatch = MatchModel (
                        id: UUID().uuidString,
                        Season: season,
                        Date: date,
                        HomeTeam: homeTeam,
                        AwayTeam: awayTeam,
                        FTHG: fthg,
                        FTAG: ftag,
                        FTR: ftr,
                        HTHG: hthg,
                        HTAG: htag,
                        HTR: htr,
                        isCustom: true
                    )
                    
                    // Add match to firebase and matchList
                    modelData.addMatch(match: newMatch)
                }) {
                    Text("Add Match")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 5)
            }
            .scrollContentBackground(.hidden)
        }
        .ignoresSafeArea(.all)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    AddMatchView()
        .environmentObject(ModelData())
        .environmentObject(SettingsData())
}
