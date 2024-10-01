//
//  MatchRowView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//

import SwiftUI

struct MatchRowView: View {
    var match: MatchModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(match.HomeTeam)
                    .font(.headline)
                Text("vs")
                Text(match.AwayTeam)
                    .font(.headline)
            }
            
            Text("Date: \(match.Date)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("Full-Time: \(match.FTHG) - \(match.FTAG)")
                Text("Result: \(match.FTR)")
            }
            .font(.body)
            
            HStack {
                Text("Half-Time: \(match.HTHG) - \(match.HTAG)")
                Text("Result: \(match.HTR)")
            }
            .font(.body)
        }
        .padding()
    }
}

#Preview {
    MatchRowView(match: .init(id: "11000", Season: "2023-24", Date: "2023-10-02", HomeTeam: "Barcelona", AwayTeam: "Real Madrid", FTHG: "3", FTAG: "2", FTR: "H", HTHG: "1", HTAG: "1", HTR: "D"))
}
