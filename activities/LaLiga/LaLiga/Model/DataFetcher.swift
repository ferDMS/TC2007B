//
//  ViewController.swift
//  LaLiga
//
//  Created by PEZ on 08/10/24.
//

import Foundation
import Firebase

class DataFetcher {
    let db = Firestore.firestore()
    
    var matchesList: [MatchModel] = []
    
    func getData() {
        self.matchesList.removeAll()
        
        db.collection("matches").order(by: "Season").getDocuments{(querySnapshot, err) in
            if err != nil {
                print ("Error en la llamada a firebase: \(err!)")
            }
            else {
                if querySnapshot != nil {
                    
                    var matchesListIn : [MatchModel] = []
                    
                    // For every document in the collection
                    for documentItem in querySnapshot!.documents {
                        let data = documentItem.data()
                        
                        // Obtained data
                        let id = documentItem.documentID
                        let season = data["Season"] as! String
                        let date = data["Date"] as! String
                        let homeTeam = data["HomeTeam"] as! String
                        let awayTeam = data["AwayTeam"] as! String
                        let fthg = data["FTHG"] as! String
                        let ftag = data["FTAG"] as! String
                        let ftr = data["FTR"] as! String
                        let hthg = data["HTHG"] as! String
                        let htag = data["HTAG"] as! String
                        let htr = data["HTR"] as! String
                        let isCustom = data["isCustom"] as? Bool ?? false
                        
                        // Generate match object
                        let newMatch = MatchModel(
                            id: id,
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
                            isCustom: isCustom
                        )
                        
                        // Append object to list
                        matchesListIn.append(newMatch)
                    }
                    
                    print("Obtained \(matchesListIn.count) matches")
                    self.matchesList = matchesListIn
                    
                    // Update local copy of matches
                } else {
                    print("No data")
                }
            }
        }
    }
    
    func deleteData(matchItem: MatchModel) {
        let docRef = db.collection("matches").document(matchItem.id)
        
        // Delete the document
        docRef.delete() { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document successfully deleted with ID: \(matchItem.id)")
            }
        }
        
        matchesList.removeAll(where: { $0.id == matchItem.id })
    }
    
    init() {
        getData()
    }
}
