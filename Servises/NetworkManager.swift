//
//  NetworkManager.swift
//  TravelAppWB
//
//  Created by Alex M on 07.08.2023.
//


import UIKit

final class NetworkManager {


    func getCheapFlightsData(completion: (([Flight]?) -> Void)?) {

        let urlString = "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap"

        guard let apiURL = URL(string: urlString),
              let httpBody = "{\"startLocationCode\":\"LED\"}".data(using: .utf8) else {
            return
        }

        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error {
                print("ERROR: \(error.localizedDescription)")
                completion?(nil)
                return
            }

            if (response as? HTTPURLResponse)?.statusCode != 200 {

                print("Status code != 200")
                completion?(nil)
                return
            }

            guard let data else {
                print("data is nil")
                completion?(nil)
                return
            }


            do {
                let answer = try JSONDecoder().decode(Flights.self, from: data)
                completion?(answer.flights)
            }
            catch {
                print(error)
            }

            completion?(nil)
        }

        task.resume()
    }

}
