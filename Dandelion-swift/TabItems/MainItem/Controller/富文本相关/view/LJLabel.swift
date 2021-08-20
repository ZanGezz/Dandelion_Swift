//
//  LJLabel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/13.
//

import UIKit

class LJLabel: UILabel {
    
    struct ScaledMetrics {
        
        let actualScaleFactor: Double
        let baselineOffset: Double
        let measuredNumberOfLines: Int64
        let scaledAttributedText: NSAttributedString
        let scaledBaselineOffset: Double
        let scaledLineHeight: Double
        let scaledSize: CGSize
        let targetSize: CGSize

        /// Keys
        static let actualScaleFactorName = "y9GdjFmRlxWYjNFbhVHdjF2X".reversedBase64Decode()
        static let baselineOffsetName = "0V2cmZ2Tl5WasV2chJ2X".reversedBase64Decode()
        static let measuredNumberOfLinesName = "==wcl5WaMZ2TyVmYtVnTkVmc1NXYl12X".reversedBase64Decode()
        static let scaledAttributedTextName = "0hXZURWZ0VnYpJHd0FEZlxWYjN3X".reversedBase64Decode()
        static let scaledBaselineOffsetName = "0V2cmZ2Tl5WasV2chJEZlxWYjN3X".reversedBase64Decode()
        static let scaledLineHeightName = "=QHanlWZIVmbpxEZlxWYjN3X".reversedBase64Decode()
        static let scaledSizeName = "=UmepNFZlxWYjN3X".reversedBase64Decode()
        static let targetSizeName = "=UmepNFdldmchR3X".reversedBase64Decode()
    }
    
    private static let scaledMetricsName = "=M3YpJHdl1EZlxWYjN3X".reversedBase64Decode()
    private var scaledMetrics: ScaledMetrics? {
        guard
            let name = LJLabel.scaledMetricsName,
            let ivar = class_getInstanceVariable(LJLabel.self, name),
            let object = object_getIvar(self, ivar) as? NSObject else {
            return nil
        }
        guard
            let actualScaleFactorName = ScaledMetrics.actualScaleFactorName,
            let baselineOffsetName = ScaledMetrics.baselineOffsetName,
            let measuredNumberOfLinesName = ScaledMetrics.measuredNumberOfLinesName,
            let scaledAttributedTextName = ScaledMetrics.scaledAttributedTextName,
            let scaledBaselineOffsetName = ScaledMetrics.scaledBaselineOffsetName,
            let scaledLineHeightName = ScaledMetrics.scaledLineHeightName,
            let scaledSizeName = ScaledMetrics.scaledSizeName,
            let targetSizeName = ScaledMetrics.targetSizeName else {
            return nil
        }
        guard
            let actualScaleFactor = object.value(forKey: actualScaleFactorName) as? Double,
            let baselineOffset = object.value(forKey: baselineOffsetName) as? Double,
            let measuredNumberOfLines = object.value(forKey: measuredNumberOfLinesName) as? Int64,
            let scaledAttributedText = object.value(forKey: scaledAttributedTextName) as? NSAttributedString,
            let scaledBaselineOffset = object.value(forKey: scaledBaselineOffsetName) as? Double,
            let scaledLineHeight = object.value(forKey: scaledLineHeightName) as? Double,
            let scaledSize = object.value(forKey: scaledSizeName) as? CGSize,
            let targetSize = object.value(forKey: targetSizeName) as? CGSize else {
            return nil
        }

        return .init(
            actualScaleFactor: actualScaleFactor,
            baselineOffset: baselineOffset,
            measuredNumberOfLines: measuredNumberOfLines,
            scaledAttributedText: scaledAttributedText,
            scaledBaselineOffset: scaledBaselineOffset,
            scaledLineHeight: scaledLineHeight,
            scaledSize: scaledSize,
            targetSize: targetSize
        )
    }
    
    private static let synthesizedAttributedTextName = "=QHelRFZlRXdilmc0RXQkVmepNXZoRnb5N3X".reversedBase64Decode()
    private var synthesizedAttributedText: NSAttributedString? {
        guard
            let name = LJLabel.synthesizedAttributedTextName,
            let ivar = class_getInstanceVariable(UILabel.self, name),
            let synthesizedAttributedText = object_getIvar(self, ivar) else {
            return nil
        }
        return synthesizedAttributedText as? NSAttributedString
    }
    
    private var scaledAttributedText: NSAttributedString? {
        return scaledMetrics?.scaledAttributedText
    }

    private var textRange: LJTextRange?
    private var _attribute: LJTextString?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.lineBreakMode = .byCharWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LJLabel {
    
    var attribute: LJTextString? {
        set {
            self.attributedText = newValue?.text
            _attribute = newValue
        }
        get {
            return _attribute
        }
    }
}

extension LJLabel {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard
            let text = self.attribute?.text,
            let touch = touches.first,
            let range = matching(touch.location(in: self)) else {
                super.touchesBegan(touches, with: event)
            textRange = nil
                return
        }
        
        // 设置高亮样式
        let attri = NSMutableAttributedString(attributedString: text)
        attri.addAttribute(.backgroundColor, value: #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1), range: range.result.range)
        self.attributedText = attri
        
        textRange = range
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let textRange = self.textRange else {
            return
        }
        // 设置高亮样式
        let attri = NSMutableAttributedString(attributedString: self.attribute!.text)
        attri.addAttribute(.backgroundColor, value: UIColor.clear, range: textRange.result.range)
        self.attributedText = attri
        
        //回调
        textRange.callBack()
    }
}

extension LJLabel {
    
    func matching(_ point: CGPoint) -> LJTextRange? {
        
        let text = adaptation(self.scaledAttributedText ?? self.synthesizedAttributedText ?? attributedText, with: numberOfLines)
        // 构建同步Label的TextKit
        let delegate = LJTextLayoutDelegate(scaledMetrics, with: baselineAdjustment)
        let textStorage = NSTextStorage()
        let textContainer = NSTextContainer(size: bounds.size)
        let layoutManager = NSLayoutManager()
        layoutManager.delegate = delegate // 重新计算行高确保TextKit与UILabel显示同步
        textContainer.lineBreakMode = lineBreakMode
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = numberOfLines
        layoutManager.usesFontLeading = false   // UILabel没有使用FontLeading排版
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textStorage.setAttributedString(text!) // 放在最后添加富文本 TextKit的坑

        // 确保布局
        layoutManager.ensureLayout(for: textContainer)
        // 获取文本所占高度
        let height = layoutManager.usedRect(for: textContainer).height

        LLJLog(height)

        // 获取点击坐标 并排除各种偏移
        var point = point
        point.y -= (bounds.height - height) / 2

        // 获取字形下标
        var fraction: CGFloat = 0
        let glyphIndex = layoutManager.glyphIndex(for: point, in: textContainer, fractionOfDistanceThroughGlyph: &fraction)
        // 获取字符下标
        let index = layoutManager.characterIndexForGlyph(at: glyphIndex)
        LLJLog(index)

        // 通过字形距离判断是否在字形范围内
        guard fraction > 0, fraction < 1 else {
            return nil
        }

        // 获取点击的字符串范围和回调事件
        var textRange: LJTextRange?
        for item in self.attribute!.textRanges {
            if item.result.range.contains(index) && item.action != nil {
                textRange = item
                break
            }
        }
        return textRange
    }
    
    private func adaptation(_ string: NSAttributedString?, with numberOfLines: Int) -> NSAttributedString? {
        /**
        由于富文本中的lineBreakMode对于UILabel和TextKit的行为是不一致的, UILabel默认的.byTruncatingTail在TextKit中则无法正确显示.
        所以将富文本中的lineBreakMode全部替换为TextKit默认的.byWordWrapping, 以解决多行显示和不一致的问题.
        注意: 经测试 最大行数为1行时 换行模式表现与byCharWrapping一致.
        */
        guard let string = string else {
            return nil
        }

        let mutable = NSMutableAttributedString(attributedString: string)
        mutable.enumerateAttribute(
            .paragraphStyle,
            in: .init(location: 0, length: mutable.length),
            options: .longestEffectiveRangeNotRequired
        ) { (value, range, stop) in
            guard let old = value as? NSParagraphStyle else { return }
            guard let new = old.mutableCopy() as? NSMutableParagraphStyle else { return }
            new.lineBreakMode = numberOfLines == 1 ? .byCharWrapping : .byWordWrapping
            if #available(iOS 11.0, *) {
                new.setValue(1, forKey: "lineBreakStrategy")
            }
            mutable.addAttribute(.paragraphStyle, value: new, range: range)
        }
        return mutable
    }
}
