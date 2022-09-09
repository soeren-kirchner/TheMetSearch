//
//  TheMetSearchTestsSampleData.swift
//  TheMetSearchTests
//
//  Created by Sören Kirchner on 09.09.22.
//

import Foundation
@testable import TheMetSearch

struct SampleData {
    
    struct Sample_436533 {
        let data = """
        {
        "objectID":436533,
        "isHighlight":false,
        "accessionNumber":"1992.374",
        "accessionYear":"1992",
        "isPublicDomain":true,
        "primaryImage":"https://images.metmuseum.org/CRDImages/ep/original/DT1947.jpg",
        "primaryImageSmall":"https://images.metmuseum.org/CRDImages/ep/web-large/DT1947.jpg",
        "additionalImages":[
        
        ],
        "constituents":[
        {
            "constituentID":161947,
            "role":"Artist",
            "name":"Vincent van Gogh",
            "constituentULAN_URL":"http://vocab.getty.edu/page/ulan/500115588",
            "constituentWikidata_URL":"https://www.wikidata.org/wiki/Q5582",
            "gender":""
        }
        ],
        "department":"European Paintings",
        "objectName":"Painting",
        "title":"Shoes",
        "culture":"",
        "period":"",
        "dynasty":"",
        "reign":"",
        "portfolio":"",
        "artistRole":"Artist",
        "artistPrefix":"",
        "artistDisplayName":"Vincent van Gogh",
        "artistDisplayBio":"Dutch, Zundert 1853–1890 Auvers-sur-Oise",
        "artistSuffix":"",
        "artistAlphaSort":"Gogh, Vincent van",
        "artistNationality":"Dutch",
        "artistBeginDate":"1853",
        "artistEndDate":"1890",
        "artistGender":"",
        "artistWikidata_URL":"https://www.wikidata.org/wiki/Q5582",
        "artistULAN_URL":"http://vocab.getty.edu/page/ulan/500115588",
        "objectDate":"1888",
        "objectBeginDate":1888,
        "objectEndDate":1888,
        "medium":"Oil on canvas",
        "dimensions":"18 x 21 3/4 in. (45.7 x 55.2 cm)",
        "measurements":[
        {
            "elementName":"Overall",
            "elementDescription":null,
            "elementMeasurements":{
                "Height":45.7201,
                "Width":55.2451
            }
        }
        ],
        "creditLine":"Purchase, The Annenberg Foundation Gift, 1992",
        "geographyType":"",
        "city":"",
        "state":"",
        "county":"",
        "country":"",
        "region":"",
        "subregion":"",
        "locale":"",
        "locus":"",
        "excavation":"",
        "river":"",
        "classification":"Paintings",
        "rightsAndReproduction":"",
        "linkResource":"",
        "metadataDate":"2022-08-03T04:54:59.807Z",
        "repository":"Metropolitan Museum of Art, New York, NY",
        "objectURL":"https://www.metmuseum.org/art/collection/search/436533",
        "tags":[
        {
            "term":"Still Life",
            "AAT_URL":"http://vocab.getty.edu/page/aat/300015638",
            "Wikidata_URL":"https://www.wikidata.org/wiki/Q170571"
        },
        {
            "term":"Shoes",
            "AAT_URL":"http://vocab.getty.edu/page/aat/300046065",
            "Wikidata_URL":"https://www.wikidata.org/wiki/Q22676"
        }
        ],
        "objectWikidata_URL":"https://www.wikidata.org/wiki/Q19911520",
        "isTimelineWork":true,
        "GalleryNumber":"822"
        }
        """.data(using: .utf8)!
        let expectedResult = MetObject(objectID: 436533,
                                       title: "Shoes",
                                       artistDisplayName: "Vincent van Gogh",
                                       department: "European Paintings",
                                       objectName: "Painting",
                                       culture: "", period: "",
                                       medium: "Oil on canvas",
                                       dimensions: "18 x 21 3/4 in. (45.7 x 55.2 cm)",
                                       primaryImage: "https://images.metmuseum.org/CRDImages/ep/original/DT1947.jpg",
                                       primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/web-large/DT1947.jpg",
                                       additionalImages: [])
    }
    
    struct Sample_CorruptedJson {
        let data = """
        {
        "objectID":436533,
        "isHighlight":false,
        "accessionNumber":"1992.374",
        "accessionYear":"1992",
        "isPublicDomain":true,
        "primaryImage":"https://images.metmuseum.org/CRDImages/ep/original/DT1947.jpg",
        "primaryImageSmall":"https://images.metmuseum.org/CRDImages/ep/web-large/DT1947.jpg",
        "additionalImages":[
        
        ],
        "constituents":[
        {
            "constituentID":161947,
            "role":"Artist",
            "name":"Vincent van Gogh",
            "constituentULAN_URL":"http://vocab.getty.edu/page/ulan/500115588",
            "constituentWikidata_URL":"https://www.wikidata.org/wiki/Q5582",
            "gender":
        """.data(using: .utf8)!
        let expectedResult = MetObject(objectID: 436533,
                                       title: "Shoes",
                                       artistDisplayName: "Vincent van Gogh",
                                       department: "European Paintings",
                                       objectName: "Painting",
                                       culture: "", period: "",
                                       medium: "Oil on canvas",
                                       dimensions: "18 x 21 3/4 in. (45.7 x 55.2 cm)",
                                       primaryImage: "https://images.metmuseum.org/CRDImages/ep/original/DT1947.jpg",
                                       primaryImageSmall: "https://images.metmuseum.org/CRDImages/ep/web-large/DT1947.jpg",
                                       additionalImages: [])
    }
    
}


