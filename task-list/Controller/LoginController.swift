import UIKit
import SnapKit

class LoginController: UIViewController {
    
    var loginView: LoginView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background")
        return backgroundImage
    }()
    
    private lazy var username: UITextField = {
        let username = UITextField()
        username.attributedText = NSAttributedString.init(string: "Username")
        username.backgroundColor = UIColor.fromRGBString("#F39FE4")
        username.borderStyle = .line
        username.textColor = UIColor.black
        return username
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.attributedText = NSAttributedString.init(string: "Password")
        password.backgroundColor = UIColor.fromRGBString("#F39FE4")
        password.borderStyle = .line
        password.textColor = UIColor.black
        return password
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.tintColor = .systemPurple
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        button.dropShadow()
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    @objc func login() {
        print("clicou")
        let toDoPage = ToDoController()
        navigationController?.pushViewController(toDoPage, animated: true)
    }
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubview(backgroundImage)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(button)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        username.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
        }
        
        password.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
            make.width.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(90)
            make.width.equalTo(90)
        }
    }
}

