//
//  ErrorWrapper.swift
//  Scrumdinger (iOS)
//
//  Created by Alessa De Leon Chavez on 2022-04-08.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id:UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance:String){
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
