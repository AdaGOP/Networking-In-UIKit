//
//  ViewController.swift
//  NetworkTestingUIKit
//
//  Created by Athoya on 26/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    var service = NetworkService()
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getUser() {
        Task {
            do {
                let user = try await service.getUser()
//                imageUrl = user.image
                updateImage(url: user.image)
            } catch {
                print(error)
            }
        }
    }
    
    func updateImage(url: String) {
        let url = URL(string: url)
        DispatchQueue(label: "background", qos: DispatchQoS.background).async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
}

