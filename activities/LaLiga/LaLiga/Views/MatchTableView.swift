//
//  MatchTableView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//

import SwiftUI

struct MatchTableView: View {
    
    @Environment(ModelData.self) var modelData
    
    var matches: [MatchModel] {
        modelData.matches
    }
    
    var body: some View {
        List {
            ForEach(matches) { match in
                MatchRowView(match: match)
            }
        }
    }
}


#Preview {
    MatchTableView()
        .environment(ModelData())
}
