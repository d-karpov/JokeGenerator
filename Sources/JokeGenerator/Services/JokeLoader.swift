//
//  JokeLoader.swift
//  JokeGenerator
//
//  Created by Денис Карпов on 05.06.2024.
//

import Foundation

struct JokeLoader {
	
	static func loadJoke(handler: @escaping (Result<JokeModel, any Error>) -> Void) {
		NetworkService.fetch(from: "https://official-joke-api.appspot.com/random_joke") { result in
			switch result {
			case .success(let data):
				do {
					let jokeModel = try JSONDecoder().decode(JokeModel.self, from: data)
					handler(.success(jokeModel))
				} catch {
					handler(.failure(error))
				}
			case .failure(let error):
				handler(.failure(error))
			}
		}
	}
}
