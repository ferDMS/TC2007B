//
//  PokeFotoView.swift
//  Pokemon2024
//
//  Created by PEZ on 15/08/24.
//

import SwiftUI

struct PokeFotoView: View {
    var body: some View {
        Image("charmander")
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.orange, lineWidth: 5)
            }
            .background(Circle().fill(Color.black))
            .shadow(color: .orange, radius:30)
    }
}

#Preview {
    PokeFotoView()
}
