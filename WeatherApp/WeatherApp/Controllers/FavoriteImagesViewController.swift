//
//  FavoriteImagesViewController.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteImagesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   let detailVC = DetailViewController()
    
    var savedImages = [ImageData](){
        didSet {
            
            self.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        changeBackGround()
       loadItems()
    print(savedImages.count)
    }
    
    func loadItems() {
        
        do {
           savedImages = try detailVC.dataPersistance.loadItems()
           
        } catch {
showAlert(title: "Having Some Trouble? ", message: "Please try again later - \(error)")
            print(error)
        }
    
    }
    
  private func changeBackGround() {
       let  randRed = CGFloat.random(in: 0...1)
       let  randBlue = CGFloat.random(in: 0...1)
       let  randGreen = CGFloat.random(in: 0...1)
        
        let myColor = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: 1)
    collectionView.backgroundColor = myColor
    }
   

}

extension FavoriteImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let savedImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedImageCell", for: indexPath) as? FavoritesCollectionViewCell else {
            fatalError("could not downcast to FavoritesCollectionViewCell, check resuse identifier")
        }
        
        let cellInFow = savedImages[indexPath.row]
        
        savedImageCell.configureCell(with: cellInFow)
        savedImageCell.delegate = self
        return savedImageCell
    }
    
    
}

extension FavoriteImagesViewController: ImageCellDelegate{
    
    func didLongPress(_ imageCell: FavoritesCollectionViewCell) {
        
        guard let indexPath = collectionView.indexPath(for: imageCell) else {
                    return
                }
                
        //        present an action sheet
                
                
        //        actions: delete , cancel
                
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
                    self?.deleteImageObject(indexPath: indexPath)
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                alertController.addAction(deleteAction)
                alertController.addAction(cancelAction)
             present(alertController,animated: true)
            }
    
    private func deleteImageObject(indexPath: IndexPath){
        //delete image object from documents directory
        
        do {
            //delete image object from documents directory
            try detailVC.dataPersistance.deleteItem(at: indexPath.row)
            
            //delete image from ImageObjects.
            savedImages.remove(at: indexPath.row)
            
            //delete cell from collection view
//            collectionView.deleteItems(at: [indexPath])
            
            print(indexPath)
        } catch {
            showAlert(title: "Error Deleting Image", message: "Try Again Later - \(error)")
            print("error removing image \(error)")
        }
        
    }
    

    }
    
    

