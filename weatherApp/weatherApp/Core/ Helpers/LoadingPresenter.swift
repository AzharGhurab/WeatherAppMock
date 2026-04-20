//
//  LoadingPresenter.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 03/11/1447 AH.
//

import UIKit

enum LoadingPresenter {
    
    private static var loadingView: UIView?
    
    static func show(on view: UIView) {
        hide()
        
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = overlay.center
        indicator.startAnimating()
        
        overlay.addSubview(indicator)
        view.addSubview(overlay)
        
        loadingView = overlay
    }
    
    static func hide() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}
