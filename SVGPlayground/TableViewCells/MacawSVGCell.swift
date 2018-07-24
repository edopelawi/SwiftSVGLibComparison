//
//  MacawSVGCell.swift
//  SVGPlayground
//
//  Created by Ricardo Pramana Suranta on 05/07/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit
import Macaw

final class MacawSVGCell: UITableViewCell {

	static let preferredHeight: CGFloat = 70.0
	static let reuseIdentifier: String = "MacawSVGCell"

	@IBOutlet private weak var macawSVGView: Macaw.SVGView!

	@IBOutlet private weak var explanationLabel: UILabel!

	override func prepareForReuse() {
		explanationLabel.text = "Macaw:"
		macawSVGView.fileName = nil
	}

}

extension MacawSVGCell: SVGCell {

	/**
	Configures this cell to display the passed `filename`, without the file format (`.svg`).
	*/
	func configure(for source: String) {
		explanationLabel.text = "Macaw: \(source)"
		macawSVGView.fileName = source
	}
}
