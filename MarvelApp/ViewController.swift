//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rafael González on 30/04/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var keyLoader = KeyLoader.shared
    var characterManager : CharacterServiceManager?
    
    var characterID: Int?
    var characterName: String?
    var characterPos: Int?
    
    

    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(keyLoader.getAPIParams())
        //print(keyLoader.getQueryString())
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        
        
        characterManager = CharacterServiceManager()
        
        characterManager?.loadCharacterData(queryString: keyLoader.getQueryString(limit: Constants.numberOfItemsRequested, offset: 0) ){
            DispatchQueue.main.async {
                print("Completion executed!!")
                self.characterCollectionView.reloadData()
                //move offset param to retieve next block of character
                self.characterManager?.offset = (self.characterManager?.countCharacter())!
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacterSegue"{
            let characterDetailVC = segue.destination as? CharacterDetailViewController
            characterDetailVC?.characterID = characterID
            //characterDetailVC?.characterName.text = characterName
            characterDetailVC?.characterPos = characterPos
        }
    }
    
}



extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (characterManager?.countCharacter())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
        cell.characterName.text = characterManager?.getCharacter(at: indexPath.row).name
        let url = URL(string: (characterManager?.getCharacter(at: indexPath.row).thumbnail.url)!)
        cell.characterImage.sd_setImage(with: url)
        cell.characterID = characterManager?.getCharacter(at: indexPath.row).id
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        characterPos = indexPath.row
        
        print("Posicion en el Collection: ", characterPos)
        print("Nombre en el Collection: ", characterManager?.getCharacter(at: characterPos!).name)
        
        characterID = characterManager?.getCharacter(at: characterPos!).id
        characterName = characterManager?.getCharacter(at: characterPos!).name
        
        
        
        performSegue(withIdentifier: "showCharacterSegue", sender: Any.self)
    }
    
    
    
    
    
    /*override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if identifier == "showCharacterSegue"{
            characterID = characterManager?.getCharacter(at: characterPos!).id
        }
    }*/
    

}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ////        size of scrollview content
//                print("contentSize.height", scrollView.contentSize.height)
        ////        screen's available space for scrollview element
//                print("bounds.height:", scrollView.bounds.height)
        ////        contentOffset y = contentSize.height - bounds.height
//                print("contentOffset y:", scrollView.contentOffset.y)
         
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollviewHeight = scrollView.bounds.height

        if (offsetY > (contentHeight - scrollviewHeight)) && (!characterManager!.maxItemsLoaded && !characterManager!.isLoading ){
            print("calling API...")
            self.characterManager!.isLoading = true
            let queryString = keyLoader.getQueryString(limit: Constants.numberOfItemsRequested, offset: self.characterManager!.offset)
                print("qs:",queryString)

            self.characterManager!.loadCharacterData(queryString: queryString){
                DispatchQueue.main.async {
                    self.characterCollectionView.reloadData()
                    print("char com:",self.characterManager!.countCharacter())
                    print("actual offset: ", self.characterManager!.offset)
                    self.characterManager!.offset = self.characterManager!.countCharacter()
                    print("new offset: ", self.characterManager!.offset)
                    self.characterManager!.isLoading = false
                }
            }
        }
        else{
            print("Don't call API...")
        }
    }
}

