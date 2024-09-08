//
//  JokeModel.swift
//  JokeGenerator
//
//  Created by Денис Карпов on 05.06.2024.
//

import Foundation

struct JokeModel: Codable {
	let type: String
	let setup: String
	let punchline: String
	let id: Int
}
