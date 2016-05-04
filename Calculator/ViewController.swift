import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet private weak var display: UILabel!
  @IBOutlet var calculatorButtons: [UIButton]!
  
  private var userIsInTheMiddleOfTyping = false

  override func viewDidLoad() {
    super.viewDidLoad()
    for calculatorButton in calculatorButtons {
      calculatorButton.layer.borderWidth = 0.25
      calculatorButton.layer.borderColor = UIColor.blackColor().CGColor
    }
  }

  @IBAction private func touchDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTyping {
      let textCurrentlyInDisplay = display.text!
      display.text = textCurrentlyInDisplay + digit
    } else {
      display.text = digit
    }
    userIsInTheMiddleOfTyping = true
  }
  
  private var displayValue: Double {
    get {
      return Double(display.text!)!
    }
    set {
      display.text = String(newValue)
    }
  }
  
  var savedProgram: CalculatorBrain.PropertyList?
  
  @IBAction private func save() {
    savedProgram = brain.program
  }
  
  @IBAction private func restore() {
    if savedProgram != nil {
      brain.program = savedProgram!
      displayValue = brain.result
    }
  }
  
  private var brain = CalculatorBrain()
  
  @IBAction private func performOperation(sender: UIButton) {
    if userIsInTheMiddleOfTyping {
      brain.setOperand(displayValue)
      userIsInTheMiddleOfTyping = false
    }
    
    if let mathematicalSymbol = sender.currentTitle {
      brain.performOperation(mathematicalSymbol)
      
    }
    displayValue = brain.result
  }
  
  @IBAction func insertFloatingPoint(sender: UIButton) {
    if !display.text!.containsString(".") {
      touchDigit(sender)
    }
  }
  
}

