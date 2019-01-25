//
//  ColorPickerViewController.swift
//  ColorPicker
//
//  Created by goeun on 17/01/2019.
//  Copyright © 2019 goeun. All rights reserved.
//

import UIKit

protocol ColorPickerChangeDelegate {
    func colorChanged(color: UIColor)
}

class ColorPickerViewController: UIViewController {
    let cellIdentifier: String = "colorCell"
    var colors = [UIColor]()
    
    var delegate: ColorPickerChangeDelegate?
    
    lazy var colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        createColorPalette()
        setCollectionView()
    }
    
    func setCollectionView() {
        self.view.addSubview(colorCollectionView)
        
        colorCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        colorCollectionView.backgroundColor = .white
        
        colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        colorCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        colorCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        colorCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        colorCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func createColorPalette() {
        for brightnessValue in 0..<9 {
            let brightness = CGFloat(brightnessValue) / CGFloat(9)
            let color = UIColor(hue: 0, saturation: 0, brightness: brightness, alpha: 1)
            colors.append(color)
        }
        
        colors.append(UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1))
        
        for hueValue in 0..<11 {
            for saturationValue in 0..<10 {
                let hue = 1.0 - CGFloat(hueValue) / CGFloat(11)
                let saturation = 1.0 - CGFloat(saturationValue) / CGFloat(10)
                let color = UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: 1, alpha: 1)
                colors.append(color)
            }
        }
    }
}

extension ColorPickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
}

extension ColorPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedColor = self.colors[indexPath.row]
        delegate?.colorChanged(color: selectedColor)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ColorPickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = self.view.frame.width/10
        
        return CGSize(width: cellSize, height: cellSize)
    }
}
