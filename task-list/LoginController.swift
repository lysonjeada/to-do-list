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
        username.backgroundColor = .systemPurple
        username.borderStyle = .line
        username.textColor = .white
        return username
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.attributedText = NSAttributedString.init(string: "Password")
        password.backgroundColor = .systemPurple
        password.borderStyle = .line
        password.textColor = .white
        return password
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.tintColor = .systemPurple
        button.setTitle("Enter", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
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
        backgroundImage.addSubview(username)
        backgroundImage.addSubview(password)
        backgroundImage.addSubview(button)
        view.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        username.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundImage)
            make.centerY.equalTo(backgroundImage)
            make.width.equalTo(200)
        }
        
        password.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundImage)
            make.centerY.equalTo(backgroundImage).offset(40)
            make.width.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundImage)
            make.centerY.equalTo(backgroundImage).offset(90)
            make.width.equalTo(90)
        }
    }
}

