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

	private var latestSVGPath: String?
	private var currentDataTask: URLSessionDataTask?
	private var currentDispatchItem: DispatchWorkItem?

}

extension MacawRemoteSVGCell: SVGCell {

	/**
	Configures this URL to display SVG image from the passed URL.
	*/
	func configure(for source: String) {

		guard source != latestSVGPath else {
			return
		}

		resetNode()
		resetDispatchWorkItems()

		latestSVGPath = source
		explanationLabel.text = "Macaw remote: \(source)"

		let workItem = createWorkItem(forDisplaying: source)
		
		DispatchQueue.global(qos: .default).async(execute: workItem)
		currentDispatchItem = workItem
	}

	// MARK: - Private methods


	private func resetNode() {
		macawView.node = Group()
	}

	private func resetDispatchWorkItems() {
		currentDataTask?.cancel()
		currentDataTask = nil

		currentDispatchItem?.cancel()
		currentDispatchItem = nil
	}

	private func createWorkItem(forDisplaying source: String) -> DispatchWorkItem {

		return DispatchWorkItem() { [weak self] in

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

	private func downloadSVG(urlString: String, onFinished: @escaping ((_ svgString: String?) -> ())) {

		guard let url = URL(string: urlString) else {
			return
		}

		let session = URLSession(configuration: .default)

		currentDataTask = session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in

			guard let validData = data else {

				onFinished(nil)
				return
			}

			let svgString = String(data: validData, encoding: .utf8)
			onFinished(svgString)
		}

		currentDataTask?.resume()
	}
}
