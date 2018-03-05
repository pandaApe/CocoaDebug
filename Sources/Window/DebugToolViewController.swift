//
//  DebugTool.swift
//  demo
//
//  Created by liman on 26/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class DebugToolViewController: UIViewController, DebugToolBubbleDelegate {

    var bubble = DebugToolBubble(frame: CGRect(origin: DebugToolBubble.originalPosition, size: DebugToolBubble.size))

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.addSubview(self.bubble)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.bubble.updateOrientation(newSize: size)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bubble.delegate = self
        self.view.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        WindowHelper.shared.displayedList = false
    }

    func shouldReceive(point: CGPoint) -> Bool {
        if WindowHelper.shared.displayedList {
            return true
        }
        return self.bubble.frame.contains(point)
    }
    
    //MARK: - DebugToolBubbleDelegate
    func didTapDebugToolBubble() {
        WindowHelper.shared.displayedList = true
        let storyboard = UIStoryboard(name: "Manager", bundle: Bundle(for: DebugToolViewController.self))
        guard let vc = storyboard.instantiateInitialViewController() else {return}
        self.present(vc, animated: true, completion: nil)
    }
}
