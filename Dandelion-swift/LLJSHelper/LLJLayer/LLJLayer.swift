//
//  LLJLayer.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/29.
//

import UIKit

class LLJLayer: NSObject {

    //shapeLayer
    class func shapeLayer(bounds: CGRect, position: CGPoint?, lineWidth: CGFloat?, strokeColor: UIColor?, fillColor: UIColor?, backColor: UIColor?) -> CAShapeLayer {
        let subLayer = CAShapeLayer()
        
        if (position != nil) {
            subLayer.position = position!
        }
        
        if (lineWidth != nil) {
            subLayer.lineWidth = lineWidth!
        }
        
        if (strokeColor != nil) {
            subLayer.strokeColor = strokeColor!.cgColor
        }
        
        if (fillColor != nil) {
            subLayer.fillColor = fillColor!.cgColor
        } else {
            subLayer.fillColor = UIColor.clear.cgColor
        }
        
        if (backColor != nil) {
            subLayer.backgroundColor = backColor!.cgColor
        }
        return subLayer
    }
    
    /*
     * CAEmitterLayer 粒子发射器
     *
     * emitterPosition: 发射器位置
     * emitterSize: 发射器大小
     * emitterMode: 发射类型(详解下面备注一)
     * emitterShape: 发射源的形状(详解下面备注二)
     */
    class func emitterLayer(emitterPosition: CGPoint, emitterSize: CGSize, emitterMode: CAEmitterLayerEmitterMode?, emitterShape: CAEmitterLayerEmitterShape?,lifetime: Float?, shadowColor: UIColor?) -> CAEmitterLayer {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = emitterPosition
        emitterLayer.emitterSize = emitterSize
        emitterLayer.emitterMode = emitterMode ?? CAEmitterLayerEmitterMode.surface
        emitterLayer.emitterShape = emitterShape ?? CAEmitterLayerEmitterShape.circle
        emitterLayer.shadowOpacity = 1.0
        emitterLayer.shadowRadius = 0.0
        emitterLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        emitterLayer.shadowColor = shadowColor?.cgColor;
        emitterLayer.lifetime = lifetime ?? 100000000
        return emitterLayer
    }
    
    /*
     * CAEmitterCell 发射的粒子样式
     *
     * name: 粒子名(充当cell的keyPath)
     * birthRate: 粒子产生的速率
     * lifetime: 粒子生命周期，存活多久 (父cell的生命周期要大于子cell的产生周期，否则还没产生，父cell就消失了！！！)
     * lifetimeRange: 粒子生命周期范围
     * velocity：粒子速度
     * velocityRange: 速度范围
     * xAcceleration:yAcceleration:zAcceleration: x、y、z方向的加速度
     * emissionRange: 粒子发射角度范围
     * scale: 粒子缩放比例
     * color: 粒子颜色
     * greenRange:redRange:blueRange:alphaRange: 粒子颜色red,green,blue,alpha能改变的范围,默认0
     * contents: 粒子的内容，为CGImageRef的对象 (一般设置图片)
     * spin: 粒子旋转速度 spinRange：粒子旋转速度范围
     * redSpeed:blueSpeed:greenSpeed:alphaSpeed : 粒子颜色red,green,blue,alpha在生命周期内的改变速度,默认都是0
     */
    class func emitterCell(name: String, birthRate: Float, lifetime: Float, lifetimeRange: Float?, velocity: CGFloat?, velocityRange: CGFloat?, xAcceleration: CGFloat?, yAcceleration: CGFloat?, zAcceleration: CGFloat?, emissionLatitude: CGFloat?, emissionLongitude: CGFloat?, emissionRange: CGFloat?, scale: CGFloat?, color: UIColor?, greenRange: Float?, redRange: Float?, blueRange: Float?, alphaRange: Float?, contents: Any?, spin: CGFloat?, spinRange: CGFloat?, redSpeed: Float?, blueSpeed: Float?, greenSpeed: Float?, alphaSpeed: Float?, emitterCells: [CAEmitterCell]?) -> CAEmitterCell {
        let emitterCell = CAEmitterCell()
        emitterCell.name = name
        emitterCell.birthRate = birthRate
        emitterCell.lifetime = lifetime
        emitterCell.lifetimeRange = lifetimeRange ?? 0.0
        emitterCell.velocity = velocity ?? 0.0
        emitterCell.velocityRange = velocityRange ?? 0.0
        emitterCell.xAcceleration = xAcceleration ?? 0.0
        emitterCell.yAcceleration = yAcceleration ?? 0.0
        emitterCell.zAcceleration = zAcceleration ?? 0.0
        emitterCell.emissionRange = emissionRange ?? 0.0
        emitterCell.emissionLatitude = emissionLatitude ?? 0.0
        emitterCell.emissionLongitude = emissionLongitude ?? 0.0
        emitterCell.scale = scale ?? 1.0
        emitterCell.color = color?.cgColor ?? UIColor.white.cgColor
        emitterCell.greenRange = greenRange ?? 0.0
        emitterCell.redRange = redRange ?? 0.0
        emitterCell.blueRange = blueRange ?? 0.0
        emitterCell.alphaRange = alphaRange ?? 0.0
        emitterCell.contents = contents
        emitterCell.spin = spin ?? 0.0
        emitterCell.spinRange = spinRange ?? CGFloat(Double.pi)
        emitterCell.redSpeed = redSpeed ?? 0.0
        emitterCell.blueSpeed = blueSpeed ?? 0.0
        emitterCell.greenSpeed = greenSpeed ?? 0.0
        emitterCell.alphaSpeed = alphaSpeed ?? 0.0
        emitterCell.emitterCells = emitterCells
        return emitterCell
    }
    
    
    //烟花
    class func fireworkLayer(superView: UIView) -> CAEmitterLayer {
        
        
        let content: UIImage = UIImage(named: "circle")!
        let sparkContent: UIImage = UIImage(named: "wujiaoxing")!

        
        //火花粒子
        let sparkCell = self.emitterCell(name: "sparkCell", birthRate: 100.0, lifetime: 1.5, lifetimeRange: nil, velocity: 50, velocityRange: 0, xAcceleration: 0, yAcceleration: 75, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: CGFloat.pi*2, scale: 0.1, color: nil, greenRange: 255.0, redRange: 255.0, blueRange: 255.0, alphaRange: 1.0, contents: sparkContent.cgImage, spin: 0, spinRange: 0, redSpeed: 0.4, blueSpeed: -0.1, greenSpeed: -0.1, alphaSpeed: -0.25, emitterCells: nil)
        //爆炸粒子
        let explodeCell = self.emitterCell(name: "explodeCell", birthRate: 1.0, lifetime: 0.5, lifetimeRange: nil, velocity: nil, velocityRange: nil, xAcceleration: nil, yAcceleration: nil, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: nil, scale: 2.0, color: nil, greenRange: nil, redRange: nil, blueRange: nil, alphaRange: nil, contents: nil, spin: nil, spinRange: nil, redSpeed: nil, blueSpeed: nil, greenSpeed: nil, alphaSpeed: nil, emitterCells: [sparkCell])
        //尾巴粒子
        let weibaCell = self.emitterCell(name: "weibaCell", birthRate: 100, lifetime: 0.1, lifetimeRange: nil, velocity: -100, velocityRange: nil, xAcceleration: nil, yAcceleration: 50, zAcceleration: nil, emissionLatitude: CGFloat.pi/2, emissionLongitude:0.0, emissionRange: CGFloat.pi/4, scale: 0.3, color: nil, greenRange: nil, redRange: nil, blueRange: nil, alphaRange: nil, contents: content.cgImage, spin: nil, spinRange: nil, redSpeed: nil, blueSpeed: nil, greenSpeed: nil, alphaSpeed: nil, emitterCells: nil)
        //发射粒子
        let emitterCell = self.emitterCell(name: "firework", birthRate: 3.0, lifetime: 1.02, lifetimeRange: nil, velocity: 250, velocityRange: 0, xAcceleration: nil, yAcceleration: 200, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: CGFloat.pi/6, scale: 0.15, color: nil, greenRange: 255.0, redRange: 255.0, blueRange: 255.0, alphaRange: 1.0, contents: content.cgImage, spin: 0, spinRange: 0, redSpeed: 0, blueSpeed: 0, greenSpeed: 0, alphaSpeed: 0, emitterCells: [explodeCell,weibaCell])
        
        let fireworkLayer = self.emitterLayer(emitterPosition: CGPoint(x: superView.bounds.size.width/2.0, y: superView.bounds.size.height-5), emitterSize: CGSize(width: 10, height: 5), emitterMode: CAEmitterLayerEmitterMode.surface, emitterShape: CAEmitterLayerEmitterShape.line, lifetime: 10000, shadowColor: nil)
        fireworkLayer.emitterCells = [emitterCell]
        superView.layer.addSublayer(fireworkLayer)
        
        return fireworkLayer
    }
    
    //下雪
    class func snowLayer(superView: UIView) -> CAEmitterLayer {
        
        
        let tubiao: UIImage = UIImage(named: "tubiao")!
        let snowflake: UIImage = UIImage(named: "snowflake")!
        
        //雪花1
        let tubiaoCell = self.emitterCell(name: "tubiao", birthRate: 10, lifetime: 5.0, lifetimeRange: 0.0, velocity: -10, velocityRange: 0, xAcceleration: nil, yAcceleration: 10, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: 0.0, scale: 0.05, color: nil, greenRange: nil, redRange: nil, blueRange: nil, alphaRange: nil, contents: tubiao.cgImage, spin: 0, spinRange: 0, redSpeed: 0, blueSpeed: 0, greenSpeed: 0, alphaSpeed: 0, emitterCells: nil)
        //雪花2
        let snowflakeCell = self.emitterCell(name: "snowflake", birthRate: 10, lifetime: 5.0, lifetimeRange: 0.0, velocity: -10, velocityRange: 0, xAcceleration: nil, yAcceleration: 10, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: 0.0, scale: 0.05, color: nil, greenRange: nil, redRange: nil, blueRange: nil, alphaRange: nil, contents: snowflake.cgImage, spin: 0, spinRange: 0, redSpeed: 0, blueSpeed: 0, greenSpeed: 0, alphaSpeed: 0, emitterCells: nil)
        
        let fireworkLayer = self.emitterLayer(emitterPosition: CGPoint(x: superView.bounds.size.width/2.0, y: 0), emitterSize: CGSize(width: superView.bounds.size.width, height: 5), emitterMode: CAEmitterLayerEmitterMode.surface, emitterShape: CAEmitterLayerEmitterShape.line, lifetime: 10000, shadowColor: nil)
        fireworkLayer.emitterCells = [tubiaoCell,snowflakeCell]
        superView.layer.addSublayer(fireworkLayer)
        return fireworkLayer
    }
    
    //下雨
    class func rainLayer(superView: UIView) -> CAEmitterLayer {
        
        
        let yudi: UIImage = UIImage(named: "yudi")!
        let shuidi_huaban: UIImage = UIImage(named: "shuidi_huaban")!
        
        //雨滴1
        let yudiCell = self.emitterCell(name: "yudi", birthRate: 40, lifetime: 2.0, lifetimeRange: 2.0, velocity: -260, velocityRange: 0, xAcceleration: nil, yAcceleration: 10, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: 0.0, scale: 0.2, color: nil, greenRange: nil, redRange: nil, blueRange: nil, alphaRange: nil, contents: yudi.cgImage, spin: 0, spinRange: 0, redSpeed: 0, blueSpeed: 0, greenSpeed: 0, alphaSpeed: 0, emitterCells: nil)
        
        //雨滴2
        let shuidiCell = self.emitterCell(name: "shuidi", birthRate: 40, lifetime: 2.0, lifetimeRange: 2.0, velocity: -300, velocityRange: 0, xAcceleration: nil, yAcceleration: 10, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: 0.0, scale: 0.2, color: nil, greenRange: nil, redRange: nil, blueRange: nil, alphaRange: nil, contents: shuidi_huaban.cgImage, spin: 0, spinRange: 0, redSpeed: 0, blueSpeed: 0, greenSpeed: 0, alphaSpeed: 0, emitterCells: nil)

        let fireworkLayer = self.emitterLayer(emitterPosition: CGPoint(x: superView.bounds.size.width/2.0, y: 0), emitterSize: CGSize(width: superView.bounds.size.width, height: 5), emitterMode: CAEmitterLayerEmitterMode.surface, emitterShape: CAEmitterLayerEmitterShape.line, lifetime: 10000, shadowColor: nil)
        fireworkLayer.emitterCells = [yudiCell,shuidiCell]
        superView.layer.addSublayer(fireworkLayer)
        return fireworkLayer
    }
    
    //点赞
    class func zanLayer(superView: UIView) -> CAEmitterLayer {
        
        
        let xinheart: UIImage = UIImage(named: "xinheart")!
        
        //雨滴1
        let heartCell = self.emitterCell(name: "xinheart", birthRate: 5, lifetime: 5, lifetimeRange: 2.0, velocity: 100, velocityRange: 0, xAcceleration: nil, yAcceleration: 50, zAcceleration: nil, emissionLatitude: 0.0, emissionLongitude:0.0, emissionRange: CGFloat.pi/10, scale: 1.0, color: nil, greenRange: nil, redRange: nil, blueRange: nil, alphaRange: 1.0, contents: xinheart.cgImage, spin: CGFloat.pi, spinRange: CGFloat.pi/2, redSpeed: 0, blueSpeed: 0, greenSpeed: 0, alphaSpeed: 0, emitterCells: nil)

        let fireworkLayer = self.emitterLayer(emitterPosition: CGPoint(x: superView.bounds.size.width/2.0, y: superView.bounds.size.height), emitterSize: CGSize(width: 10, height: 5), emitterMode: CAEmitterLayerEmitterMode.surface, emitterShape: CAEmitterLayerEmitterShape.line, lifetime: 2, shadowColor: nil)
        fireworkLayer.emitterCells = [heartCell]
        superView.layer.addSublayer(fireworkLayer)
        return fireworkLayer
    }
}


extension LLJLayer {
    
    //MARK: - 备注 -
    /* CAEmitterLayerEmitterMode (备注一)
     *
     * surface - 粒子从粒子发射器表面发出
     * points  - 粒子从粒子发射器上的点发射出来
     * outline - 粒子从粒子发射器的轮廓发射出来
     * volume  - 粒子从粒子发射器中的a位置发射
     */
    
    /* CAEmitterLayerEmitterShape (备注二)
     *
     * circle  - 粒子从一个以(发射位置)为中心的圆中发射出来
     * cuboid  - 粒子从一个相反角的长方体(3D矩形)发射。
     * line    - 粒子从(发射位置)沿直线发射。
     * point   - 粒子从一个点(发射位置)发射出来。
     * rectangle - 粒子从一个有相对角的矩形发射。
     * sphere  - 粒子从一个以(发射位置)为中心的球体中发射出来。
     */
}
