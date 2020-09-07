import UIKit

class SpinnerFooterView: UICollectionReusableView {
    let spinner = UIActivityIndicatorView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinner.center = self.center
        
        self.addSubview(spinner)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
