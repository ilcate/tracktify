import Foundation
import SwiftUI

struct NormalTextStyle: ViewModifier {
    let fontName: String
    let fontSize: CGFloat
    let fontColor: Color

    init(fontName: String, fontSize: CGFloat, fontColor: Color) {
        self.fontName = fontName
        self.fontSize = fontSize
        self.fontColor = fontColor
    }

    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(fontColor)
    }
}


extension Text {
    func normalTextStyle(fontName: String, fontSize: CGFloat, fontColor: Color) -> some View {
        self.modifier(NormalTextStyle(fontName: fontName, fontSize: fontSize, fontColor: fontColor))
    }
}
