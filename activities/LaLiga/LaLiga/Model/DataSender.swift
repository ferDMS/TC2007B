//
//  DataSender.swift
//  LaLiga
//
//  Created by PEZ on 11/10/24.
//

import Foundation
import Firebase

class DataSender {
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
            "HTR": matchItem.HTR,
            "isCustom": matchItem.isCustom
        ]) {error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(docRef.documentID)")
            }
        }
        
        self.matchesList.append(matchItem)
    }
}
