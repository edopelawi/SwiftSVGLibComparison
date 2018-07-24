//
//  MacawRemoteSVGCell.swift
//  SVGPlayground
//
//  Created by Ricardo Pramana Suranta on 24/07/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit
import Macaw

final class MacawRemoteSVGCell: UITableViewCell {

	static let preferredHeight: CGFloat = 70.0
	static let reuseIdentifier: String = "MacawRemoteSVGCell"

	@IBOutlet private weak var explanationLabel: UILabel!
	@IBOutlet private weak var macawView: MacawView!

	override func prepareForReuse() {
		// TODO: Add code to cancel current download task for the passed URL.
		explanationLabel.text = "Macaw remote:"
		macawView.backgroundColor = UIColor.darkGray
	}

}

extension MacawRemoteSVGCell: SVGCell {

	/**
	Configures this URL to display SVG image from the passed URL.
	*/
	func configure(for source: String) {
		explanationLabel.text = "Macaw remote: \(source)"

		DispatchQueue.global(qos: .default).async { [weak self] in

			self?.downloadSVG(urlString: source) { (svgString: String?) in

				guard let validString = svgString,
					let node = try? SVGParser.parse(text: validString) else {
						return
				}

				DispatchQueue.main.async {
					self?.macawView.node = node
				}
			}
		}
	}

	// MARK: - Private methods

	private func downloadSVG(urlString: String, onFinished: @escaping ((_ svgString: String?) -> ())) {

		guard let url = URL(string: urlString) else {
			return
		}

		let session = URLSession(configuration: .default)

		session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in

			guard let validData = data else {

				onFinished(nil)
				return
			}

			let svgString = String(data: validData, encoding: .utf8)
			onFinished(svgString)
		}
		.resume()
	}
}
