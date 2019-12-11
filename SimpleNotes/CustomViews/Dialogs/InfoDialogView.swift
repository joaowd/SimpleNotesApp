//
//  InfoDialogView.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import LBTATools

public class InfoDialogView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func showInfo(text: String, infoType: InfoDialogType){
        _createView(text, infoType)
        _show()
    }
    
    private func _createView(_ text: String, _ infoType: InfoDialogType) {
        self.clipsToBounds = true
        self.backgroundColor = infoType.rawValue
        self.tag = 0
        
        let textLabel: UILabel = UILabel.init(text: text, font: .boldSystemFont(ofSize: 14), textColor: UIColor.Theme.white, numberOfLines: 2)
        stack(textLabel, alignment: .center).padBottom(12).padLeft(8).padRight(8).anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    
    private func _show() {
        let keyWindow: UIWindow? = UIApplication.shared.windows.first {$0.isKeyWindow}
        let dialogHeight: CGFloat = (keyWindow?.safeAreaInsets.top)! + LocalConstants().alertDialogHeight
        self.frame = CGRect.init(x: 0, y: 0, width: (keyWindow?.bounds.width)!, height: dialogHeight)
        keyWindow?.addSubview(self)
        Animations.slideVerticaly(self, showAnimation: true, completion: { success in self._hide() })
    }
    
    private func _hide() {
        Animations.slideVerticaly(self, showAnimation: false, delay: 2.75, completion: { success in self._removeView() })
    }
    
    private func _removeView(){
        self.viewWithTag(0)?.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}