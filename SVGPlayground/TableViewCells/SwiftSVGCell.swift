//
//  SwiftSVGCell.swift
//  SVGPlayground
//
//  Created by Ricardo Pramana Suranta on 05/07/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit
import SwiftSVG

final class SwiftSVGCell: UITableViewCell {

	static let preferredHeight: CGFloat = 70.0
	static let reuseIdentifier: String = "SwiftSVGCell"

	@IBOutlet private weak var swiftSVGView: SwiftSVG.SVGView!
	@IBOutlet private weak var explanationLabel: UILabel!

	/**
	Configures this cell to display the passed `filename`, without the file format (`.svg`).
	*/
	func configure(for filename: String) {
		explanationLabel.text = "SwiftSVG: \(filename)"
		swiftSVGView.SVGName = filename
	}
}
