//
//  ParkDataController.swift
//  Lab4-AMAD
//
//  Created by Matthew Coker on 3/4/20.
//  Copyright © 2020 Matthew Coker. All rights reserved.
//

import Foundation

enum JsonError: Error {
    case BadURL
    case BadResponse
    case CouldNotParse
}

class ParkDataController {
    var currentParks = ParkData()
    var onDataUpdate: ((_ data: [Park]) -> Void)?
    
    func loadJson(stateCode: String) throws {
        let urlPath = "https://developer.nps.gov/api/v1/parks?stateCode=\(stateCode)&api_key=tFHMeOIEJt4lk5j4Gt8xC8iDJWQno4fyeAyJSUgC"
        
        guard let url = URL(string: urlPath) else {
            print("bad url")
            return
        }
        
        //valid url so make the request and give it a completetion handler closure
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            //downcase to URLResponse since we made and https request
            let httpResponse = response as! HTTPURLResponse
            
            //get the status code
            let statusCode = httpResponse.statusCode
            
            //make sure we got a good response
            guard statusCode == 200 else {
                print("file download error. status code: \(statusCode)")
                return
            }
            //download successful
            print("download complete")
            //parse json asynch
            DispatchQueue.main.async {self.parseJson(rawData: data!)}
        })
        
        //must call resume to run session and execute request
        session.resume()
    }
    
    //parses the raw http response and notifies the view controller
    func parseJson(rawData: Data)  {
        do {
            //try to decode the response
            let parsedData = try JSONDecoder().decode(ParkData.self, from: rawData)
            //clear out old data
            currentParks.data.removeAll()
            //add all the park entries to our class property that stores the current parks
            for park in parsedData.data {
                currentParks.data.append(park)
            }
        } catch {
            //something went wrong parsing the data — throw error!
            print("json error")
            print(error.localizedDescription)
        }
        print("parsejson done")
        
        //pass data back to requesting object
        onDataUpdate?(currentParks.data)
    }
}
