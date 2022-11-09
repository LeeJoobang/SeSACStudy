import UIKit

//extension UILabel {
//    func setLineSpacing(spacing: CGFloat){
//        guard let text = text else { return }
//        let attributeString = NSMutableAttributedString(string: text)
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = spacing
//        attributeString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributeString.length))
//        attributedText = attributeString
//    }
//}


extension UILabel {
    func addInterlineSpacing(spacingValue: CGFloat = 2) {
        guard let textString = text else { return }
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        attributedText = attributedString
    }
}
