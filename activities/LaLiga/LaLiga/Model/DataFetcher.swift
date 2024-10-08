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
    
    func addData(matchItem : MatchModel) {
        
        let docRef = db.collection("matches").document(matchItem.id)
        
        docRef.setData([
            "Season": matchItem.Season,
            "Date": matchItem.Date,
            "HomeTeam": matchItem.HomeTeam,
            "AwayTeam": matchItem.AwayTeam,
            "FTHG": matchItem.FTHG,
            "FTAG": matchItem.FTAG,
            "FTR": matchItem.FTR,
            "HTHG": matchItem.HTHG,
            "HTAG": matchItem.HTAG,
            "HTR": matchItem.HTR
        ]) {error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(docRef.documentID)")
            }
        }
        
        self.matchesList.append(matchItem)
    }
    
    func getData() {
        self.matchesList = []
        
        db.collection("matches").order(by: "Season").getDocuments{(querySnapshot, err) in
            if err != nil {
                print ("Error en la llamada a firebase: \(err!)")
            }
            else {
                if querySnapshot != nil {
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
                            HTR: htr
                        )
                        
                        // Append object to list
                        self.matchesList.append(newMatch)
                    }
                    
                    // Update local copy of matches
                    print("Obtained \(self.matchesList.count) matches")
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
