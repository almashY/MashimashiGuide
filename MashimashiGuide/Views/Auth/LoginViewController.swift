
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var slider: CustomSlider!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func sliderValue(_ sender: UISlider) {
        label.text = String(Int(sender.value * 100))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)
        slider.transform = slider.transform.scaledBy(x: -1, y: 1);
        label.textAlignment = NSTextAlignment.center

    }
    
    @objc func sliderDidChangeValue(_ sender: CustomSlider) { // @IBActionでも可
        print(sender.value) // 0.0
    }
    
    
}
