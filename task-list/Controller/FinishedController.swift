import UIKit
import SnapKit

class FinishedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var finishedTasks: Array<String>
    
    init(finishedTasks: Array<String>) {
        self.finishedTasks = finishedTasks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        finishedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.fromRGBString("#F39FE4")
        for finished in finishedTasks {
            cell.textLabel?.text = finished
        }
        cell.accessoryType = .checkmark
        
        return cell
    }
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background")
        return backgroundImage
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = 20
        table.backgroundColor = UIColor.fromRGBString("#F39FE4")
        return table
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        button.dropShadow()
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        table.dataSource = self
        table.delegate = self
        table.frame = view.bounds
        
        view.addSubview(backgroundImage)
        view.addSubview(table)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(70)
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(20)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        table.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(105)
            make.bottom.equalToSuperview().inset(110)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(50)
        }
    }
    
    
    
}
