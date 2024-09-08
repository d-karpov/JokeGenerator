//
//  AlertPresenter.swift
//  JokeGenerator
//
//  Created by Денис Карпов on 05.06.2024.
//

import UIKit

struct AlertPresenter {
	
	static func show(with model: AlertModel, at view: UIViewController) {
		let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
		
		let alertAction = UIAlertAction(title: model.buttonText, style: .default) { _ in
			model.action()
		}
		alert.addAction(alertAction)
		
		view.present(alert, animated: true)
	}
}
