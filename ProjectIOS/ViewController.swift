//
//  ViewController.swift
//  ProjectIOS
//
//  Created by Александр Хижко on 07.03.2021.
//

import UIKit




class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var searchAlbum: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let text = searchAlbum.text
        
        guard segue.identifier == "goToAlbums" else { return }
        guard let newVC = segue.destination as? secondControllerViewController else { return }
        newVC.textFromVC = text!
    }
    
    
}
    


