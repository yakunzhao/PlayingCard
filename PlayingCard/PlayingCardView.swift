//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Yakun on 2020/3/12.
//  Copyright © 2020 Yakun. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    var rank: Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
     
    private func centeredAttributedString (_ string: String, fontSize: CGFloat) -> NSAttributedString {
        
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }
    
    private var conorString:NSAttributedString {
        return centeredAttributedString(String(rank)+"\n"+suit, fontSize: 50.0)
    }
    
    private lazy var upperLeftCornerLabel = creatCornerLabel()
    private lazy var lowerRightCornerLabel = creatCornerLabel()
    
    private func creatCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = conorString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin
        
        configureCornerLabel(lowerRightCornerLabel)
        lowerRightCornerLabel.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY).offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
        
    }
    
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
    }
    

}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint{
        return CGPoint(x: x+dx, y: y+dy)
    }
}
