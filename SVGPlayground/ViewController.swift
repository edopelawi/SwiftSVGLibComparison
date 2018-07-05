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

class ViewController: UIViewController {

	@IBOutlet private weak var swiftSVGView: SwiftSVG.SVGView!
	@IBOutlet private weak var macawSVGView: Macaw.SVGView!

	override func viewDidLoad() {
		super.viewDidLoad()
		loadSVG()
	}

	private func loadSVG() {

		// TODO: Somehow, this part due to SVGView's rendering process. Try to uncomment this line when we changed the library version.
		// swiftSVGView.SVGName = "insurance"

		macawSVGView.fileName = "insurance"
	}

}

