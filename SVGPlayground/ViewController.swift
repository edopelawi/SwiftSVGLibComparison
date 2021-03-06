//
//  ViewController.swift
//  SVGPlayground
//
//  Created by Ricardo Pramana Suranta on 04/07/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit
import SwiftSVG
import Macaw

final class ViewController: UIViewController {

	@IBOutlet private weak var tableView: UITableView!

	enum Section: Int {
		case macaw = 0
		case swiftSVG
		case macawRemote
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureTableView()
	}

	private func configureTableView() {

		let macawNib = UINib(nibName: MacawSVGCell.reuseIdentifier, bundle: Bundle.main)
		let swiftSVGNib = UINib(nibName: SwiftSVGCell.reuseIdentifier, bundle: Bundle.main)
		let macawRemoteNib = UINib(nibName: MacawRemoteSVGCell.reuseIdentifier, bundle: Bundle.main)

		tableView.register(macawNib, forCellReuseIdentifier: MacawSVGCell.reuseIdentifier)
		tableView.register(swiftSVGNib, forCellReuseIdentifier: SwiftSVGCell.reuseIdentifier)
		tableView.register(macawRemoteNib, forCellReuseIdentifier: MacawRemoteSVGCell.reuseIdentifier)
	}

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		guard let validSection = Section(rawValue: section) else {
			return 0
		}

		switch validSection {
		case .macaw:
			return 10

		case .swiftSVG:
			return 0 // TODO: There's an issue in SwiftSVG rendering, so we're not using it for the time being.

		case .macawRemote:
			return 10
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let reuseIdentifier = cellIdentifier(for: indexPath) else {
			return UITableViewCell()
		}

		return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
	}

	private func cellIdentifier(for indexPath: IndexPath) -> String? {

		guard let validSection = Section(rawValue: indexPath.section) else {
			return nil
		}

		switch validSection {
		case .macaw:
			return MacawSVGCell.reuseIdentifier

		case .swiftSVG:
			return SwiftSVGCell.reuseIdentifier

		case .macawRemote:
			return MacawRemoteSVGCell.reuseIdentifier
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		guard let validSection = Section(rawValue: indexPath.section) else {
			return 1.1
		}

		switch validSection {
		case .macaw:
			return MacawSVGCell.preferredHeight

		case .swiftSVG:
			return SwiftSVGCell.preferredHeight

		case .macawRemote:
			return MacawRemoteSVGCell.preferredHeight
		}
	}
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		guard let validSection = Section(rawValue: section) else {
			return nil
		}

		switch validSection {
		case .macaw:
			return "Macaw Renderers"

		case .swiftSVG:
			return "Swift SVG Renderers"

		case .macawRemote:
			return "Macaw Renderer + Remote loading"
		}
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		guard let svgCell = cell as? SVGCell,
			let section = Section(rawValue: indexPath.section) else {
				return
		}

		let oddRow = (indexPath.row % 2) != 0

		switch section {
		case .macaw, .swiftSVG:
			svgCell.configure(for: "insurance")

		case .macawRemote:

			let url: String

			if oddRow {
				url = "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/adobe.svg"
			} else {
				url = "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/betterplace.svg"
			}

			svgCell.configure(for: url)
		}
	}

}
