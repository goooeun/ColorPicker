//
//  ViewController.swift
//  ColorPicker
//
//  Created by goeun on 16/01/2019.
//  Copyright © 2019 goeun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorButton = ColorPickerButton()
        
        self.view.addSubview(colorButton)
        
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        colorButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
}
