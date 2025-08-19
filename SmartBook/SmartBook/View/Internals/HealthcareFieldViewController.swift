//
//  HealthcareFieldViewController.swift
//  SmartBook
//
//  Created by Md. Kamrul Hasan on 13/8/25.
//

import UIKit

final class HealthcareFieldViewController: UIViewController {
    
    @IBOutlet private var healthcareFieldCollectionView: UICollectionView!
    private let viewModel = HealthcareFieldViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        healthcareFieldCollectionView.delegate = self
        healthcareFieldCollectionView.dataSource = self
    }
    
    
}

extension HealthcareFieldViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfFields()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoryboardInfo.Identifier.healthcareFieldCell,
            for: indexPath
        ) as! HealthcareFieldCell
        
        cell.layer.borderColor = UIColor.secondaryText.cgColor
        cell.layer.borderWidth = 3
        let field = viewModel.field(at: indexPath.item)
        cell.configure(with: field)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let field = viewModel.field(at: indexPath.item)
        print("Tapped on: \(field.name)")
    }

}
