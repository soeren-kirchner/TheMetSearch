//
//  Object.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

struct Object: Decodable {
    let objectID: Int
    let title: String
    let artistDisplayName: String
    let department: String
    let objectName: String
    let culture: String
    let period: String
    let medium: String
    let dimensions: String
    let primaryImage: String
    let primaryImageSmall: String
    let additionalImages: [String]
  
}

extension Object {
    static let example = Object(objectID: 471911, title: "Portal from the Church of San Leonardo al Frigido", artistDisplayName: "Biduinus", department: "The Cloisters", objectName: "Portal", culture: "Italian", period: "", medium: "Marble (Carrara marble)", dimensions: "13 ft. 2 in. × 76 in. × 14 in. (401.3 × 193 × 35.6 cm)", primaryImage: "https://images.metmuseum.org/CRDImages/cl/original/DP132217.jpg", primaryImageSmall: "https://images.metmuseum.org/CRDImages/cl/web-large/DP132217.jpg", additionalImages: ["https://images.metmuseum.org/CRDImages/cl/original/DP167911.jpg", "https://images.metmuseum.org/CRDImages/cl/original/DP169537.jpg", "https://images.metmuseum.org/CRDImages/cl/original/DP169538.jpg", "https://images.metmuseum.org/CRDImages/cl/original/DP169536.jpg", "https://images.metmuseum.org/CRDImages/cl/original/DP167910.jpg", "https://images.metmuseum.org/CRDImages/cl/original/DP167912.jpg", "https://images.metmuseum.org/CRDImages/cl/original/DP167909.jpg", "https://images.metmuseum.org/CRDImages/cl/original/DP167913.jpg"])
    
    static let example2 = Object(objectID: 339130, title: "Compositional Sketches for the Virgin Adoring the Christ Child, with and without the Infant St. John the Baptist; Diagram of a Perspectival Projection (recto); Slight Doodles (verso)", artistDisplayName: "Leonardo da Vinci", department: "Drawings and Prints", objectName: "Drawing", culture: "", period: "", medium: "Pen and brown ink (recto and verso)", dimensions: "7 15/16 x 5 1/4in. (20.2 x 13.3cm)", primaryImage: "https://images.metmuseum.org/CRDImages/dp/original/DT232678.jpg", primaryImageSmall: "https://images.metmuseum.org/CRDImages/dp/web-large/DT232678.jpg", additionalImages: ["https://images.metmuseum.org/CRDImages/dp/original/DT339729.jpg", "https://images.metmuseum.org/CRDImages/dp/original/DT339730.jpg"])
}
