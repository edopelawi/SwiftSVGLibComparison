//
//  SVGCell.swift
//  SVGPlayground
//
//  Created by Ricardo Pramana Suranta on 24/07/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import Foundation

/**
Protocol for cells used to render SVG sources.
*/
protocol SVGCell  {

	/**
	Configures this instance to render the passed source.
	*/
	func configure(for source: String)
}
