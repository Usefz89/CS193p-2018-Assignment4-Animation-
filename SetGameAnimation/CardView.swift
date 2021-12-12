//
//  CardView.swift
//  SetGameGraphical
//
//  Created by Yousef Zuriqi on 07/12/2021.
//

import UIKit

class CardView: UIView {
    
    //Properties of the Card.
    var shape: Shape = .squiggle 
    var shade: Shade = .striped
    var color: UIColor = .red
    var numberOfShapes: NumberOfShapes = .three
    
    enum NumberOfShapes: Int  {
        case one, two, three
    }
    enum Shape: String  {
        case diamond, squiggle, oval
    }
    
    enum Shade {
        case solid, striped, open
    }
    
    // MARK: - Drawing Shapes
    
    private func drawDiamond(in rect: CGRect) -> UIBezierPath {
        let  path = UIBezierPath()
            path.move(to: CGPoint(x: rect.midX, y: (rect.maxY) * Constants.topYFactor))
            path.addLine(to: CGPoint(x: (rect.midX)/2, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: (rect.maxY) * Constants.bottomYFactor))
            path.addLine(to: CGPoint(x: (rect.maxX)*3/4, y: rect.midY))
            path.close()
            return path
    }
    
    private func drawSquiggle(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()

        path.move(to: CGPoint(x: rect.maxX*0.25, y: rect.maxY*0.33))
        
        path.addCurve(
            to: CGPoint(x: rect.maxX*0.75, y: rect.maxY*0.33),
            controlPoint1: CGPoint(x: rect.maxX*0.35, y: rect.maxY*0.23), // dy = 0.10
            controlPoint2: CGPoint(x: rect.maxX*0.6, y: rect.maxY*0.43)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX*0.75, y: rect.maxY*0.53),
            controlPoint: CGPoint(x: rect.maxX*0.9, y: rect.maxY*0.43)
        )
        
        path.addCurve(
            to: CGPoint(x: rect.maxX*0.25, y: rect.maxY*0.53),
            controlPoint1: CGPoint(x: rect.maxX*0.6125, y: rect.maxY*0.63),
            controlPoint2: CGPoint(x: rect.maxX*0.375, y: rect.maxY*0.43)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX*0.25, y: rect.maxY*0.33),
            controlPoint: CGPoint(x: rect.maxX*0.125, y: rect.maxY*0.48)
        )
        
        path.lineJoinStyle = .round
        path.apply(.identity.translatedBy(x: 0, y: 10))
        
        return path
    }
    
    private func drawOval(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath(
            roundedRect: CGRect(
                origin: CGPoint(x: rect.maxX*0.2, y: rect.maxY*0.375),
                size: CGSize(width: rect.width*0.60, height: rect.height*0.2)
            ),
            cornerRadius: rect.height*0.20
        )
        return path
    }
    
    private func drawShape(in rect: CGRect) -> UIBezierPath {
        switch shape {
        case .diamond:
            return drawDiamond(in: rect)
        case .squiggle:
            return drawSquiggle(in: rect)
        case .oval:
            return drawOval(in: rect)
        }
    }
    // MARK: - Number of shapes
    
    private func numberOfShapeToDraw(in rect: CGRect) -> UIBezierPath  {
        switch numberOfShapes {
        case .one:
            return drawShape(in: rect)
            
        case .two:
            let path1 = drawShape(in: rect)
            path1.apply(.identity.translatedBy(x: 0, y: -rect.maxY*0.125))
            
            let path2 = drawShape(in: rect)
            path2.apply(.identity.translatedBy(x: 0, y: rect.maxY*0.125))
            
            //Merge the both paths into one. In order to Return one path
            path1.append(path2)
            
            return path1
            
        case .three:
            let path1 = drawShape(in: rect)
            path1.apply(.identity.translatedBy(x: 0, y: -rect.maxY*0.30))
            
            let path2 = drawShape(in: rect)
            path2.apply(.identity.translatedBy(x: 0, y: 0))
            
            let path3 = drawShape(in: rect)
            path3.apply(.identity.translatedBy(x: 0, y: rect.maxY*0.30))
            
            //Merge the all paths into one. In order to Return one path.
            path1.append(path2)
            path1.append(path3)
            return path1
        }
    }
    
    // MARK: - Shades of Shapes
    private func drawShapesWithShades(in rect: CGRect) {
        switch shade {
        case .solid:
            color.setFill()
            numberOfShapeToDraw(in: rect).fill()
            
        case .open:
            color.setStroke()
            let path = numberOfShapeToDraw(in: rect)
            path.lineWidth = 3
            path.stroke()
            
        case .striped:
            makeShades(in: rect, on: numberOfShapeToDraw(in: rect))

        }
    }
    
    private func makeShades(in rect: CGRect, on path: UIBezierPath) {
        color.setStroke()
        path.addClip()
        path.stroke()
        let linePath = UIBezierPath()
        
        let numberOfLines = Int(rect.width/5)
        for line in 1...numberOfLines {
            linePath.move(to: CGPoint(x: CGFloat( line*5), y: rect.origin.y))
            linePath.addLine(to: CGPoint(x: CGFloat( (line*5) + 10), y: rect.maxY))
            linePath.stroke()
        }
    }

    //MARK: - Draw Function
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let borderRect = UIBezierPath(roundedRect: rect , cornerRadius: 10)
        
        UIColor.black.setStroke()
        borderRect.stroke()
        drawShapesWithShades(in: rect)
    }
    
    //MARK: - Constants
    
    private struct Constants {
        static let topYFactor: CGFloat = 0.4
        static let bottomYFactor: CGFloat = 0.6
    }
}

