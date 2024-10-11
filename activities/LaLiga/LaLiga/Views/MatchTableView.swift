//
//  MatchTableView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//

import SwiftUI

struct MatchTableView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var filter: (MatchModel) -> Bool
    
    var body: some View {
        List {
            ForEach(modelData.matchesList.filter(filter)) { match in
                MatchRowView(match: match)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
    }
}


#Preview {
    MatchTableView(filter: {match in match.HomeTeam.starts(with: "Barcelona")})
        .environmentObject(ModelData())
}
