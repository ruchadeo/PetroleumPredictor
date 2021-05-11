//
//  ViewController.swift
//  PetroleumPredictor
//
//  Created by Rucha Deo on 1/30/21.
//

import UIKit
import SwiftUI

public class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    @IBOutlet var imageView: UIImageView!;
    var counter = 0;
    static var selectorCount = 0;
    
    var color1 = UIColor(red: 0, green: 0, blue: 0, alpha: 0);
    var color2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0);
    var color3 = UIColor(red: 0, green: 0, blue: 0, alpha: 0);
    
    static var average = UIColor(red: 0, green: 0, blue: 0, alpha: 0);
    
    
    @IBOutlet weak var oilSelector: UIPickerView!
    
    var oilSelectorData: [String] = [String]()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    
    var width: Double? {
        return Double(widthField.text!)
    }

    var height: Double? {
        return Double(heightField.text!)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        widthField.delegate = self
        heightField.delegate = self
        
        self.oilSelector.delegate = self
        self.oilSelector.dataSource = self
        
        oilSelectorData = ["Rainbow", "Dark/Brown", "Metallic", "Silver"]
    }
    
    @IBAction func didTapButton(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func didTapCalc(){
        if let width = self.width, let height = self.height {
            let volume = imageView.image?.calculateVolume(pos: ViewController.average, width: width, height: height)
            print(volume!)
            let val = Double(floor(1000*volume!)/1000)
            textView.text = " \(val) Cubic Meters"
        }
        
    }
    
    public override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }

        // Number of columns of data
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // The number of rows of data
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return oilSelectorData.count
        }
        
      // The data to return fopr the row and component (column) that's being passed in
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ViewController.selectorCount = row
            return oilSelectorData[row]
        }
    
    @IBAction public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: view) {
            
            var color = imageView.image?.getPixelColor(pos: point) ?? .clear
            
                if(counter == 0){
                    color1 = color;
                    print("color0: ")
                    print(color1)
                }
                else if(counter == 1){
                    color2 = color;
                    print("color1: ")
                    print(color2)
                }
                else if(counter == 2){
                    color3 = color;
                    print("color2: ")
                    print(color3)
                
            
                let avgColor = imageView.image?.getAvgColor(pos1: color1, pos2: color2, pos3: color3) ?? .clear
                
                print("Colors: ")
                print(color1)
                print(color2)
                print(color3)
                print(avgColor)
                    
                    ViewController.average = avgColor;
                    print("Average in view controller:")
                    print(ViewController.average)
                }
            }
        counter += 1;
        }
    }

extension String {
func toDouble() -> Double? {
    return NumberFormatter().number(from: self)?.doubleValue
 }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image = image;
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("r2")
        
            picker.dismiss(animated: true, completion: nil)
        
        }
}

extension ViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



public extension UIImage {
    
    func getAvgColor(pos1: UIColor, pos2: UIColor, pos3: UIColor) -> UIColor?{
        
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0
        
        pos1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        
        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0
        
        pos2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        var red3: CGFloat = 0
        var green3: CGFloat = 0
        var blue3: CGFloat = 0
        var alpha3: CGFloat = 0
        
        pos3.getRed(&red3, green: &green3, blue: &blue3, alpha: &alpha3)
        
        let redTotal = (red1 + red2 + red3)/3
        let greenTotal = (green1 + green2 + green3)/3
        let blueTotal = (blue1 + blue2 + blue3)/3
        let alphaTotal = (alpha1 + alpha2 + alpha3)/3
        
        let uiColor = UIColor(red: redTotal, green: greenTotal, blue: blueTotal, alpha: alphaTotal)
        
        return uiColor
        
        
    }
    
    func getPixelColor(pos: CGPoint) -> UIColor? {
        
        guard let pixelData = self.cgImage?.dataProvider?.data else { return nil }
               
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
        
    }
    
     func calculateVolume(pos: UIColor, width: Double, height: Double) -> Double{
        var colorPixels = 0.0;
        let totalPixels = (Double(self.size.height) * Double(self.size.width));
        
        let imageHeight = Int(self.size.height)
        let imageWidth = Int(self.size.width)
        
        
        for yCo in 0 ..< imageHeight {
            for xCo in 0 ..< imageWidth {

                var currentPColor = self.getPixelColor(pos: CGPoint(x: xCo, y: yCo))
                
            
                var cRed: CGFloat = 0
                var cGreen: CGFloat = 0
                var cBlue: CGFloat = 0
                var cAlpha: CGFloat = 0

                currentPColor!.getRed(&cRed, green: &cGreen, blue: &cBlue, alpha: &cAlpha)
                
                
                var aRed: CGFloat = 0
                var aGreen: CGFloat = 0
                var aBlue: CGFloat = 0
                var aAlpha: CGFloat = 0

                ViewController.average.getRed(&aRed, green: &aGreen, blue: &aBlue, alpha: &aAlpha)
                
                var baseColor = UIColor(red: cRed, green: cGreen, blue: abs(aBlue-cBlue), alpha: cAlpha)
                
                print(baseColor)
                
                if(ViewController.selectorCount == 0){
                    if(isRainbow(pos: baseColor)){
                        colorPixels += 1;
                    }
                }
                
                
                else if(ViewController.selectorCount == 1){
                    if(isCrude(pos: baseColor)){
                        colorPixels += 1;
                    }
                }
                
                else if(ViewController.selectorCount == 2){
                    if(isMetallic(pos: currentPColor!)){
                        colorPixels += 1;
                    }
                }
                    
                else if(ViewController.selectorCount == 3){
                    if(isGrey(pos: baseColor)){
                        colorPixels += 1;
                    }
                }
                
            }
        }
        
        let area = Double(colorPixels)/totalPixels  * (width*height)
               if(ViewController.selectorCount == 0){
                   let volumeOfArea = area * (0.00059)
                   return volumeOfArea;
               }
               
               else if(ViewController.selectorCount == 1){
                   let volumeOfArea = area * (0.0000091)
                   return volumeOfArea;
               }
               
               else if(ViewController.selectorCount == 2){
                   let volumeOfArea = area * (0.000035)
                   return volumeOfArea;
               }
               
               else if(ViewController.selectorCount == 3){
                   let volumeOfArea = area * (0.0001)
                   return volumeOfArea;
               }
               return 0.0;
    }
    
    //Method to check for dark/brown colored oil
    func isCrude (pos: UIColor) -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        pos.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return red <= 90/255 &&  // make sure R is low
               green <= 80/255 &&  // make sure G & B are low
               blue <= 80/255
    }
    
    //Method to check for silver/grey colored oil
    func isGrey (pos: UIColor) -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        pos.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return abs(red-green) < (30/255) &&
            abs(red-blue) < (30/255) &&
            abs(blue-green) < (30/255)
    }
    
    //Method to check for rainbow colored oil
    func isRainbow (pos: UIColor) -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        pos.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var averageRed: CGFloat = 0
        var averageGreen: CGFloat = 0
        var averageBlue: CGFloat = 0
        var averageAlpha: CGFloat = 0
        
        ViewController.average.getRed(&averageRed, green: &averageGreen, blue: &averageBlue, alpha: &averageAlpha)
        
        return !isCrude(pos: pos) && !(isGrey(pos: pos))
        && abs(red-averageRed) > (60/255) && abs(green-averageGreen) > (60/255)
        && abs(blue-averageBlue) > (68/255)
    }
    
    //Method to check for metallic colored oil
    func isMetallic (pos: UIColor) -> Bool {
        var averageRed: CGFloat = 0
        var averageGreen: CGFloat = 0
        var averageBlue: CGFloat = 0
        var averageAlpha: CGFloat = 0
        
        ViewController.average.getRed(&averageRed, green: &averageGreen, blue: &averageBlue, alpha: &averageAlpha)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        pos.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let redDifference = red - averageRed;
        let greenDifference = green - averageGreen;
        let blueDifference = blue - averageBlue;
        
        if( abs(redDifference - greenDifference) < 15/255 &&
                abs(redDifference - blueDifference) < 15/255 &&
                abs(blueDifference - greenDifference) < 15/255){
            if(red < 220/255 && blue < 220/255 && green < 220/255
            && abs(blue-averageBlue)<15/255){
                return true;
            }
        }
        return false;
    }
    }
