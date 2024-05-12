//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by DISMOV on 11/05/24.
//

import UIKit
import SDWebImage

class CharacterDetailViewController: UIViewController {

    var keyLoader = KeyLoader.shared
    var characterManager : CharacterServiceManager?
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterUrl: UILabel!
    
    @IBOutlet weak var characterDesc: UILabel!
    
    var characterID: Int?
    var characterPos: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CARGO DETALLE")
        print("Nombre en el detail: ", characterName)
        //print(characterID)
        print("Posicion en el detail: ", characterPos)
        //let url = URL(string: (characterManager?.getCharacter(at: characterPos!).thumbnail.url)!)
        //characterImage.sd_setImage(with: url)
        //characterDesc.text = characterManager?.getCharacter(at: characterPos!).description
        //characterUrl = characterManager?.getCharacter(at: characterPos!).urls.
        
    }
        
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
