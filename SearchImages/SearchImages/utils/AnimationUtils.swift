//
//  AnimationUtils.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func shake(for duration: TimeInterval = 0.35, withTranslation translation: CGFloat = 8) {

        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()


        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.4) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }

        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)

        propertyAnimator.startAnimation()
        notificationFeedbackGenerator.notificationOccurred(.error)
    }
}

