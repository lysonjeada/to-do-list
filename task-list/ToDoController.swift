import UIKit
import SnapKit

class ToDoController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.fromRGBString("#F39FE4")
        cell.textLabel?.text = "Tarefa \(indexPath.row + 1)"
        cell.accessoryType = .checkmark
        return cell
    }
    
    
    override func viewDidLoad() {
        setupView()
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
        button.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = UIColor.fromRGBString("#D3BAEC")
        addButton.layer.cornerRadius = 15
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.fromRGBString("#D3BAEC").cgColor
        return addButton
    }()
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        table.dataSource = self
        table.delegate = self
        table.frame = view.bounds
        
        view.addSubview(backgroundImage)
        view.addSubview(button)
        view.addSubview(table)
        view.addSubview(addButton)
        
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
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(70)
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(70)
            make.centerX.equalTo(table)
            make.top.equalToSuperview().offset(580)
            make.left.equalToSuperview().offset(120)
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

