//
//  DatosView.swift
//  Pokemon2024
//
//  Created by PEZ on 15/08/24.
//

import SwiftUI

struct DatosView: View {
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                Text("Charmander")
                    .font(.title)
                    .foregroundStyle(.orange)
                    .bold()
                
                Spacer()
                
                Text("Fuego")
                    .padding(10)
                    .background(.orange)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
            .padding(.bottom, 7.0)
            
            Text("La llama de su cola indica su fuerza vital. Si está debil, su llama arderá tenue.")
        }
        
    }
}

#Preview {
    DatosView()
}
