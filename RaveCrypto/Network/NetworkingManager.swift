//
//  NetworkingManager.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 8.07.2023.
//

import Foundation
import Combine

class NetworkingManager {
    
    static func download<T: Decodable>(url: URL, dataType: T.Type? = nil, decoder: JSONDecoder = .init(), receiveValue: @escaping (T) -> Void) -> AnyCancellable {

        let session = URLSession.shared
        let cancellable: AnyCancellable
        let receiveCompletion: ((Subscribers.Completion<Error>) -> Void) = { (completion) -> Void in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
       let publisher = session.dataTaskPublisher(for: url)
                               .subscribe(on: DispatchQueue.global())
                               .tryMap { (output) -> Data in
                                          guard let response = output.response as? HTTPURLResponse,
                                                  response.statusCode >= 200 && response.statusCode < 300 else {
                                              throw URLError(.badServerResponse)
                                          }
                                          
                                          return output.data }
                               .receive(on: DispatchQueue.main)
                               .eraseToAnyPublisher()
        
        if let dataType = dataType {
            cancellable = publisher.decode(type: dataType, decoder: decoder)
                                   .sink(receiveCompletion: receiveCompletion,
                                         receiveValue: receiveValue)
        } else {
            cancellable = publisher.tryMap({ (data) -> T in return data as! T })
                                   .sink(receiveCompletion: receiveCompletion,
                                         receiveValue: receiveValue)
        }
        
        return cancellable
    }
}
