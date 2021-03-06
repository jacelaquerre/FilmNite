//
//  SwipeHostView.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 11/29/20.
//

import Foundation
import UIKit
import SwiftUI

class SwipeHostView : UIViewController{

    @IBOutlet weak var SwipeContainer: UIView!
    @IBOutlet weak var sessionIDLabel: UILabel!
    
    private var model = Card(name: "", imageName: "", released: "0", bio: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addSwipeView()
        getSessionMovies(sessionID: globalSessionID)
        print(sessionMovieList.movieList)
        sessionIDLabel.text = globalSessionID
        let swipeView = SwipeView()
        let controller = UIHostingController(rootView: swipeView)
        addChild(controller)
        controller.view.frame = SwipeContainer.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        SwipeContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            controller.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    @IBAction func finishSwiping(_ sender: Any) {
        print("to common movies...")
        self.performSegue(withIdentifier: "toCommonMovies", sender: self)
    }
}
