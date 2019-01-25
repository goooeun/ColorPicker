//
//  ColorPickerButton.swift
//  ColorPicker
//
//  Created by goeun on 24/01/2019.
//  Copyright © 2019 goeun. All rights reserved.
//

import UIKit

class ColorPickerButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.addTarget(self, action: #selector(touchUpColorPickerButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorPickerButton: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @objc func touchUpColorPickerButton(_ sender: UIButton) {
        let controller = ColorPickerViewController()
        controller.delegate = self
        controller.preferredContentSize = CGSize(width: 300, height: 360)
        controller.modalPresentationStyle = .popover
        
        if let popOverController = controller.popoverPresentationController {
            popOverController.sourceView = sender
            popOverController.sourceRect = sender.bounds
            popOverController.permittedArrowDirections = [.any]
            popOverController.delegate = self
        }
        
        window?.rootViewController?.present(controller, animated: true, completion: nil)
    }
}

extension ColorPickerButton: ColorPickerChangeDelegate {
    func colorChanged(color: UIColor) {
        self.backgroundColor = color
    }
}
