//
//  PublicMethods.swift
//
//
//  Created by Denis on 08.09.2024.
//

import UIKit

public final class JokeGenerator {
	
	public static let icon: UIImage? = UIImage(systemName: "smiley")
	public static let appName: String = "JokeGenerator"
	
	public static func assembly() -> UIViewController {
		let view = JokeSceneViewController()
		return view
	}
}
