//
//  MessagePresenter.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 03/11/1447 AH.
//

import UIKit
import SwiftMessages

@MainActor
enum MessagePresenter {
    
    static func showError(_ message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        
        view.configureTheme(.error)
        view.configureContent(title: "Error", body: message)
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .center
        config.duration = .seconds(seconds: 2)
        
        SwiftMessages.show(config: config, view: view)
    }
}
