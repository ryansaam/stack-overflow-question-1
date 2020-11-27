//
//  ColorWheelView.swift
//  lava
//
//  Created by Ryan Sam on 11/27/20.
//

import SwiftUI

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
}

struct ColorWheelView: View {
    var image = UIImage(named: "color-wheel")
    @State var frame: CGSize = .zero
    @State var isDragging = false
    @State private var location: CGPoint = CGPoint(x: 200, y: 200) // 1
    @State private var doOnce = true
    @GestureState private var startLocation: CGPoint? = nil
    @State private var dragDiameter: CGFloat = 0.0
    @State private var pickerColor = CGColor(red: 0.0, green: 255 / 255, blue: 0.0, alpha: 1)
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                let currentLocation = value.location
                let center = CGPoint(x: self.dragDiameter / 2, y: self.dragDiameter / 2)
                let distance = center.distance(to:currentLocation)
                if distance > self.dragDiameter / 2 {
                    let k = (self.dragDiameter / 2) / distance
                    let newLocationX = (currentLocation.x - center.x) * k+center.x
                    let newLocationY = (currentLocation.y - center.y) * k+center.y
                    self.location = CGPoint(x: newLocationX, y: newLocationY)
                } else {
                    let imageLocationX = (value.location.x / frame.width) * 419
                    let imageLocationY = (value.location.y / frame.height) * 419
                    
                    let color = image?.getPixelColor(pos: CGPoint(x: imageLocationX, y: imageLocationY))
                    if let colorComponents = color?.components {
                        pickerColor = CGColor(red: colorComponents.red, green: colorComponents.green, blue: colorComponents.blue, alpha: 1)
                        print("R: \(255 * colorComponents.red)")   // 0.5
                        print("G: \(255 * colorComponents.green)") // 1.0
                        print("B: \(255 * colorComponents.blue)")  // 0.25
                        print("A: \(colorComponents.alpha)") // 0.5
                    }
                    self.location = value.location
                }
                
                self.isDragging = true
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
            
            
            .onEnded { _ in
                self.isDragging = false
            }
    }
    
    var body: some View {
        return
            Group {
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(Circle().scale(0.99))
            .overlay(GeometryReader { (geometry) in
                self.makeView(geometry)
            })
    }
    
    //

    
    func makeView(_ geometry: GeometryProxy) -> some View {
        // print(geometry.size.width, geometry.size.height)

        DispatchQueue.main.async {
            self.frame = geometry.size
            if (doOnce) {
                self.location = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                self.dragDiameter = CGFloat(geometry.size.width)
                doOnce = false
            }
        }

        return
            ZStack {
                Rectangle()
                    .fill(Color(UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0))))
                    .frame(width: 40, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                GuitarPickView(color: $pickerColor)
                .offset(x: 0.0, y: -20.0)
                
            }
            .position(location) // 2
            .gesture(drag)
    }
}

//struct ColorWheelView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorWheelView()
//    }
//}
