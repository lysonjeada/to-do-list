import UIKit
import SnapKit

class ToDoController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var toDoList: Array<String> = ["Treinar", "Reunião", "Passear com o cachorro"]
    var selectedTasks: Array<String> = []
    var names = [String]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.fromRGBString("#F39FE4")
        let list = toDoList[indexPath.row]
        cell.textLabel?.text = list
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            let tableLine = indexPath.row
            selectedTasks.append(toDoList[tableLine])
            for selected in selectedTasks {
                selectedTasks.append(selected)
            }
        } else {
            cell.accessoryType = .none
            let item = toDoList[indexPath.row]
            if let position = selectedTasks.index(of: item) {
                selectedTasks.remove(at: position)
            }
        }
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background")
        return backgroundImage
    }()
    
    private lazy var toDoTextField: UITextField = {
        let toDoTextField = UITextField()
        toDoTextField.backgroundColor = UIColor.fromRGBString("#F39FE4")
        toDoTextField.borderStyle = .roundedRect
        toDoTextField.textColor = UIColor.black
        return toDoTextField
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = 20
        table.backgroundColor = UIColor.fromRGBString("#F39FE4")
        return table
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        backButton.layer.cornerRadius = 15
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        backButton.dropShadow()
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var finishedButton: UIButton = {
        let finishedButton = UIButton()
        finishedButton.setTitle("Finished", for: .normal)
        finishedButton.setTitleColor(.black, for: .normal)
        finishedButton.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        finishedButton.layer.cornerRadius = 15
        finishedButton.layer.borderWidth = 1
        finishedButton.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        finishedButton.dropShadow()
        finishedButton.addTarget(self, action: #selector(goToFinishedTasks), for: .touchUpInside)
        return finishedButton
    }()
    
    private lazy var finishButton: UIButton = {
        let finishButton = UIButton()
        finishButton.setTitle("Finish", for: .normal)
        finishButton.setTitleColor(.black, for: .normal)
        finishButton.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        finishButton.layer.cornerRadius = 15
        finishButton.layer.borderWidth = 1
        finishButton.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        finishButton.dropShadow()
        finishButton.addTarget(self, action: #selector(goToFinishedTasks), for: .touchUpInside)
        return finishButton
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        addButton.layer.cornerRadius = 15
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        addButton.dropShadow()
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        return addButton
    }()
    
    @objc func addTask() {
        guard let task = toDoTextField.text else {
            return
        }
        toDoList.append(task)
        print(toDoList)
        table.reloadData()
    }
    
    @objc func goToFinishedTasks(_ gesture: UILongPressGestureRecognizer) {
        let finishedTasks = FinishedController(finishedTasks: ["Correr com o cachorro"])
        navigationController?.pushViewController(finishedTasks, animated: true)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        table.dataSource = self
        table.delegate = self
        table.frame = view.bounds
        
        view.addSubview(backgroundImage)
        view.addSubview(finishButton)
        view.addSubview(backButton)
        view.addSubview(toDoTextField)
        view.addSubview(table)
        view.addSubview(addButton)
        view.addSubview(finishedButton)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        toDoTextField.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.centerX.equalTo(table)
            make.top.equalToSuperview().offset(135)
            make.bottom.equalToSuperview().inset(487)
        }
        
        table.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.bottom.equalToSuperview().inset(110)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(50)
        }
        
        backButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(85)
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(20)
        }
        
        finishedButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(85)
            make.top.equalToSuperview().offset(25)
            make.right.equalToSuperview().inset(20)
        }
        
        finishButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.top.equalTo(table.snp.bottom).offset(16)
            make.right.equalToSuperview().inset(75)
            
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.left.equalToSuperview().offset(70)
            make.top.equalTo(table.snp.bottom).offset(16)
        }
    }
}

extension UIColor {
    private static func color(_ colorString: String, _ model: Model) -> UIColor {
        if(model == .rgb) { return from(rgb: colorString) }
        return from(argb: UInt(colorString, radix: 16)!)
    }
    
    static func fromRGBString(_ rgb: String) -> UIColor {
        let color = from(rgb: rgb)
        if #available(iOS 13.0, *) {
            return UIColor.init {
                if $0.userInterfaceStyle == .dark {
                    return color.darked()
                } else {
                    return color
                }
            }
        } else {
            return color
        }
    }
    
    public static func from(rgb: String?) -> UIColor {
        guard var mutableRgb = rgb else { return clear }
        mutableRgb.removeAll { $0 == "#" }
        return from(rgbValue: UInt(mutableRgb, radix: 16)!)
    }
    
    private static func from(rgbValue: UInt) -> UIColor {
        return from(argb: 0xFF000000 + rgbValue)
    }
    
    private static func from(argb argbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((argbValue & 0x00FF0000) >> 16) / 255.0,
            green: CGFloat((argbValue & 0x0000FF00) >> 8) / 255.0,
            blue: CGFloat(argbValue & 0x000000FF) / 255.0,
            alpha: CGFloat((argbValue & 0xFF000000) >> 24) / 255.0
        )
    }

    func withAlpha(_ alpha: CGFloat) -> UIColor {
        var H: CGFloat = 0, S: CGFloat = 0, B: CGFloat = 0

        if getHue(&H, saturation: &S, brightness: &B, alpha: nil) {
            return UIColor(hue: H, saturation: S, brightness: B, alpha: alpha)
        }
        return self
    }
    
    func darked(_ brightness: CGFloat = 0.7) -> UIColor {
        var H: CGFloat = 0, S: CGFloat = 0, B: CGFloat = 0, A: CGFloat = 0

        if self.getHue(&H, saturation: &S, brightness: &B, alpha: &A) {
          if B < 1.0 {
            return UIColor(hue: H, saturation: S, brightness: brightness, alpha: A)
          } else {
            return UIColor(hue: H, saturation: 0.45, brightness: brightness, alpha: A)
          }
        }
        return self
    }
    
    func highlighted() -> UIColor {
        var H: CGFloat = 0, A: CGFloat = 0

        if getHue(&H, saturation: nil, brightness: nil, alpha: &A) {
            return UIColor(hue: H, saturation: 0.35, brightness: 0.9, alpha: A)
        }
        return self
    }
    
    

    var hexString: String {
        let colorRef = cgColor.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0

        return String(format: "#%02lX%02lX%02lX",
                lroundf(Float(r * 255)),
                lroundf(Float(g * 255)),
                lroundf(Float(b * 255))
        )
    }
    
    enum Model: Int {
        case rgb = 0
        case argb = 1
    }
}

public extension UIView {
    
    func dropShadow(radius: CGFloat = 1) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = radius
        
        
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}

