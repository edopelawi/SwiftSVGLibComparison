//
//  ViewController.swift
//  SVGPlayground
//
//  Created by Ricardo Pramana Suranta on 04/07/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit
import SwiftSVG

class ViewController: UIViewController {

	@IBOutlet private weak var svgView: SVGView!

	override func viewDidLoad() {
		super.viewDidLoad()
		loadSVG()
	}

	private func loadSVG() {
		// TODO: Somehow, this part due to SVGView's rendering process. Try to uncomment this line when we changed the library version.
		// svgView.SVGName = "insurance"
	}

}

