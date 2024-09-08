//
//  ViewController.swift
//  JokeGenerator
//
//  Created by Денис Карпов on 02.06.2024.
//

import UIKit

final class JokeSceneViewController: UIViewController {
	
	private lazy var mainStack: UIStackView = makeMainStack()
	private lazy var contentStack: UIStackView = makeContentStack()
	private lazy var buttonsStack: UIStackView = makeButtonsStack()
	private lazy var repeatButton: UIButton = makeButton(color: .white, text: nil, imageName: "repeat")
	private lazy var punchButton: UIButton = makeButton(color: .green, text: "Show punchline", imageName: nil)
	
	private lazy var jokeLabel: UILabel = makeLabel(
		text: "Joke will be here",
		font: .boldSystemFont(ofSize: 24)
	)
	private lazy var loadingIndicator: UIActivityIndicatorView = .init(style: .large)
	private var currentJoke: JokeModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .lightGray
		view.addSubview(mainStack)
		view.addSubview(loadingIndicator)
		layout()
		getJoke()
	}
	
	private func layout() {
		loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		buttonsStack.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[
				mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
				mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
				mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
				mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
				buttonsStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 64),
				loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
				loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
			]
		)
	}
	
	private func showLoadingIndicator() {
		contentStack.layer.opacity = 0
		loadingIndicator.startAnimating()
		punchButton.isEnabled = false
	}
	
	private func hideLoadingIndicator() {
		loadingIndicator.stopAnimating()
		UIView.animate(withDuration: 0.7) {
			self.contentStack.layer.opacity = 1
		}
		punchButton.isEnabled = true
	}
	
	private func setUpJoke() {
		DispatchQueue.main.async {
			guard let currentJoke = self.currentJoke else { return }
			self.jokeLabel.text = currentJoke.setup
			self.hideLoadingIndicator()
		}
	}
	
	private func showErrorAlert(_ error: String) {
		let model = AlertModel(
			title: "Ошибка",
			message: error,
			buttonText: "Тащи ещё",
			action: getJoke
		)
		DispatchQueue.main.async {
			AlertPresenter.show(with: model, at: self)
		}
	}
	
	@objc
	private func showPunch() {
		guard let currentJoke = currentJoke else { return }
		let model = AlertModel(
			title: "Punchline",
			message: currentJoke.punchline,
			buttonText: "OK",
			action: getJoke
		)
		DispatchQueue.main.async {
			AlertPresenter.show(with: model, at: self)
		}
	}
	
	@objc
	private func getJoke() {
		showLoadingIndicator()
		JokeLoader.loadJoke { [weak self] result in
			switch result {
			case .success(let model):
				self?.currentJoke = model
				self?.setUpJoke()
			case .failure(let error):
				self?.showErrorAlert(error.localizedDescription)
			}
			
		}
	}
	
	private func makeMainStack() -> UIStackView {
		let stack = UIStackView()
		stack.spacing = 16
		stack.axis = .vertical
		stack.addArrangedSubview(contentStack)
		stack.addArrangedSubview(buttonsStack)
		return stack
	}
	
	
	private func makeContentStack() -> UIStackView {
		let contentStack = UIStackView()
		contentStack.axis = .vertical
		contentStack.layer.borderColor = UIColor.black.cgColor
		contentStack.layer.borderWidth = 2
		contentStack.layer.cornerRadius = 8
		contentStack.backgroundColor = .gray
		contentStack.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
		contentStack.isLayoutMarginsRelativeArrangement = true
		jokeLabel.numberOfLines = 0
		
		contentStack.addArrangedSubview(jokeLabel)
		return contentStack
	}
	
	private func makeButtonsStack() -> UIStackView {
		let stack = UIStackView()
		stack.spacing = 16
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		repeatButton.addTarget(self, action: #selector(getJoke), for: .touchUpInside)
		punchButton.addTarget(self, action: #selector(showPunch), for: .touchUpInside)
		stack.addArrangedSubview(repeatButton)
		stack.addArrangedSubview(punchButton)
		return stack
	}
	
	private func makeLabel(text: String, font: UIFont) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = font
		return label
	}
	
	private func makeButton(color: UIColor, text: String?, imageName: String?) -> UIButton {
		let button = UIButton(type: .system)
		
		button.setTitle(text, for: .normal)
		button.setTitleColor(.black, for: .normal)
		if let imageName = imageName {
			button.setImage(UIImage(systemName: imageName), for: .normal)
		}
		button.tintColor = .black
		button.backgroundColor = color
		button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
		button.layer.cornerRadius = 8
		button.layer.borderWidth = 2
		button.layer.borderColor = UIColor.black.cgColor
		button.isEnabled = true
		return button
	}
	
}

#Preview {
	JokeSceneViewController()
}
