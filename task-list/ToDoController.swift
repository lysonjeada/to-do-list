import UIKit
import SnapKit

class ToDoController: UIViewController {
    
    override func viewDidLoad() {
        setupView()
    }
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background")
        return backgroundImage
    }()
    
    func setupView() {
        view.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}
