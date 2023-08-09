
import UIKit

class CustomLabel: UILabel {
    
    init(titleColor: UIColor,
         font: UIFont?,
         numberOfLines: Int = 1,
         textAlignment: NSTextAlignment = .center,
         title: String = "") {
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = font
        self.numberOfLines = numberOfLines
        self.text = title
        self.textColor = titleColor
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


