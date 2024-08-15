//
//  MasDatosView.swift
//  Pokemon2024
//
//  Created by PEZ on 15/08/24.
//

import SwiftUI

struct MasDatosView: View {
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("Evoluciones:")
                .font(.title2)
                .foregroundStyle(.orange)
                .bold()
            
            HStack {
                
                VStack {
                    Image("charmeleon")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Charmeleon")
                }
                
                VStack {
                    Image("charizard")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Charizard")
                }
            }
        }
    }
}

#Preview {
    MasDatosView()
}
