//
//  AlertModel.swift
//  JokeGenerator
//
//  Created by Денис Карпов on 05.06.2024.
//

import Foundation

struct AlertModel {
	let title: String
	let message: String
	let buttonText: String
	let action: () -> Void
}
