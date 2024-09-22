//
//  ContentView.swift
//  DefaultsApp
//
//  Created by PEZ on 17/09/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        VStack {
            NavigationStack {
                Button("Guardar MJ") {
                    UserDefaults.standard.setValue("Michael Jordan", forKey: "nombreJugador")
                    UserDefaults.standard.setValue(23, forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Guardar LJ") {
                    UserDefaults.standard.setValue("LeBron James", forKey: "nombreJugador")
                    UserDefaults.standard.setValue(23, forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Guardar KB") {
                    UserDefaults.standard.setValue("Kobe Bryant", forKey: "nombreJugador")
                    UserDefaults.standard.setValue(24, forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Borrar") {
                    UserDefaults.standard.removeObject(forKey: "nombreJugador")
                    UserDefaults.standard.removeObject(forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Ir a Detalle"){
                    DetalleView()
                }
                .buttonStyle(.borderedProminent)
                
                HStack{
                    Button("Play") {
                        self.audioPlayer.play()
                    }
                    Button("Stop") {
                        self.audioPlayer.stop()
                    }
                }
            }
        }
        .padding()
        .onAppear(){
            let sound = Bundle.main.path(forResource: "MarioBros", ofType: "mp3")
            do{
                self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
            }catch{
                print("Error al cargar audio: \(error)")
            }
        }
        
    }
}

#Preview {
    ContentView()
}
