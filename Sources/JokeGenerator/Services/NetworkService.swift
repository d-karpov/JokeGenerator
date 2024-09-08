//
//  NetworkService.swift
//  JokeGenerator
//
//  Created by Денис Карпов on 04.06.2024.
//

import Foundation

struct NetworkService {
	
	enum NetworkServiceErrors: Error {
		case urlError
		case responseCodeError
	}
	
	static func fetch(from url: String, handler: @escaping (Result<Data, Error>) -> Void) {
		guard let url = URL(string: url) else {
			handler(.failure(NetworkServiceErrors.urlError))
			return
		}
		
		let request = URLRequest(url: url)
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let error = error {
				handler(.failure(error))
				return
			}
			
			if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
				handler(.failure(NetworkServiceErrors.responseCodeError))
				return
			}
			
			if let data = data {
				handler(.success(data))
			}
		}
		
		task.resume()
	}
}
