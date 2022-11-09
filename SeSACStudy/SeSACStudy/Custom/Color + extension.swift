import UIKit

enum Color {
    static let green = "brand colorgreen"
    static let whiteGreen = "brand colorwhitegreen"
    static let yellowGreen = "brand coloryellowgreen"
    
    static let gray1 = "grayscalegray1"
    static let gray2 = "grayscalegray2"
    static let gray3 = "grayscalegray3"
    static let gray4 = "grayscalegray4"
    static let gray5 = "grayscalegray5"
    static let gray6 = "grayscalegray6"

    static let systemerror = "systemerror"
    static let systemfocus = "systemfocus"
    static let systemsuccess = "systemsuccess"
}

extension UIColor {
    static let customGreen = UIColor(named: Color.green)
    static let customWhiteGreen = UIColor(named: Color.whiteGreen)
    static let customYellowGreen = UIColor(named: Color.yellowGreen)

    static let customGray1 = UIColor(named: Color.gray1)
    static let customGray2 = UIColor(named: Color.gray2)
    static let customGray3 = UIColor(named: Color.gray3)
    static let customGray4 = UIColor(named: Color.gray4)
    static let customGray5 = UIColor(named: Color.gray5)
    static let customGray6 = UIColor(named: Color.gray6)
    
    static let customError = UIColor(named: Color.systemerror)
    static let customFocus = UIColor(named: Color.systemfocus)
    static let customSuccess = UIColor(named: Color.systemsuccess)
}
