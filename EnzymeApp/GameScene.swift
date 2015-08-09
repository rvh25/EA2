//
//  GameScene.swift
//  EnzymeApp
//
//  Created by admin on 2/22/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
}
    
    override init(size: CGSize) {
        super.init(size: size)

        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth*CGFloat(NumColumns)/2,
            y: -TileHeight*CGFloat(NumRows)/2)
        
        componentsLayer.position = layerPosition
        gameLayer.addChild(componentsLayer)
        
        swipeFromColumn = nil
        swipeFromRow = nil
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        self.check()
        
        //self.check3()

        //self.check2()
        
        //self.check4()
        
        //self.check5()
    
    }
    

    
    func check() {
        self.direction()
        level.detectPossibleSwaps()
        
        if level.checkswaps() {
            
            if othertype() {
                level.otherComponents()
//            if subs() {
//                level.substrateComponents()
                //level.locaterxns()
                level.locateotherrxns()
                //self.check()
                //self.direction4()
                self.direction2()

            }
            
            else {
                return
            }
        }
            
        else {
            self.check()
        }
    }
    
    func check2() {
        self.direction()
        level.detectPossibleSwaps()
        
        if level.checkswaps() {
            if othertype() {
                level.otherComponents()
                level.locateotherrxns()
                self.direction2()
            }
                
            else {
                return
            }
        }
            
        else {
            self.check2()
        }
    }
    
    func check3() {
        self.direction()
        level.detectPossibleSwaps()
        
        if level.checkswaps() {
            if othertype() {
                level.locateenzymes()
                level.otherComponents()
                level.locateotherrxns()
                self.direction3()
            }
                
            else {
                return
            }
        }
            
        else {
            self.check3()
        }
    }
    
    func check4() {
        self.direction4()
        level.detectPossibleSwaps()
        
        if level.checkswaps() {
            if othertype() {
                level.otherComponents()
                level.locateotherrxns()
                level.locateenzymes()                
                self.direction4()
            }
                
            else {
                return
            }
        }
            
        else {
            self.check4()
        }
    }
    
    func check5() {
        self.direction5()
        level.detectPossibleSwaps()
        self.check5()

        /*if level.checkswaps() {
            if othertype() {
                level.otherComponents()
                level.locateotherrxns()
                level.locateenzymes()

                self.direction5()
                
            }
                
            else {
                return
            }
        }
            
        else {
            self.check5()
        }*/
    }
    

    func subs() -> Bool {
        let type = ComponentType.Substrate
        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row){
                    if component.componentType == type {
                        print("component: \(component.componentType, component.column, component.row )")
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func othertype() -> Bool {
        let type = ComponentType.Enzyme
        let type2 = ComponentType.Product

        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row){
                    if component.componentType != type && component.componentType != type2 {
                        print("component: \(component.componentType, component.column, component.row )")
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
    func direction() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                swipeFromColumn = column
                swipeFromRow = row
                
                var horzDelta = 0, vertDelta = 0
                if row == 0 && column == 0 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = 1
                    }
                    else if dataConverter == 2 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                
                else if row == NumRows - 1 && column == NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                
                else if row == 0 && column == NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                
                else if row == NumRows - 1 && column == 0 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = 1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                    
                else if row == 0 && column != 0 && column != NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        horzDelta = 1
                    }
                    else if dataConverter == 3 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                    
                else if row == NumRows - 1 && column != 0 && column != NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        horzDelta = 1
                    }
                    else if dataConverter == 3 {
                        vertDelta = -1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                    
                else if column == 0 && row != 0 && row != NumRows - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = 1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    else if dataConverter == 3 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                    
                else if column == NumColumns - 1 && row != 0 && row != NumRows - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    else if dataConverter == 3 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
                
                //else if row != 0 && row != NumRows - 1 && column != 0 && column != NumColumns - 1 {
                else {
                    let dataConverter = Int(arc4random_uniform(4)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        horzDelta = 1
                    }
                    else if dataConverter == 3 {
                        vertDelta = -1
                    }
                    else if dataConverter == 4 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal(horzDelta, vertical: vertDelta)
                }
            }
        }
    }
    
    
    func other(component: Component, horzDelta: Int, vertDelta: Int) {
        let component1 = Component(column: swipeFromColumn! + horzDelta, row: swipeFromRow! + vertDelta, componentType: ComponentType.Enzyme)
        trySwapHorizontal2(component1, component2: component)
    }
    
    func other2(component: Component, horzDelta: Int, vertDelta: Int) {
        let component2 = Component(column: swipeFromColumn! + horzDelta, row: swipeFromRow! + vertDelta, componentType: ComponentType.Enzyme)
        trySwapHorizontal2(component, component2: component2)
    }
    

    func direction2() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row) {
                    if component.componentType == ComponentType.Substrate {
                        print("component: \(component.componentType, component.column, component.row)")
                        
                        
                        swipeFromColumn = component.column
                        swipeFromRow = component.row
                        
                        var horzDelta = 0, vertDelta = 0
                        if component.row == 0 && component.column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")

                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            

                        }
                        
                        else if component.row == NumRows - 1 && component.column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                        
                        else if component.row == 0 && component.column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                        
                        else if component.row == NumRows - 1 && component.column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                            
                        else if component.row == 0 && component.column != 0 && component.column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                            
                        else if component.row == NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                            
                        else if component.column == 0 && component.row != 0 && component.row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                            
                        else if component.column == NumColumns - 1 && component.row != 0 && component.row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                            
                        //else if component.row != 0 && component.row != NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                        else {
                            let dataConverter = Int(arc4random_uniform(4)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            else if dataConverter == 4 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            
                            other(component, horzDelta: horzDelta, vertDelta: vertDelta)


                        }
                    }
                }
            }
        }
    }
    
    func direction3() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row) {
                    if component.componentType != ComponentType.Enzyme && component.componentType != ComponentType.Product {
                        print("component: \(component.componentType, component.column, component.row)")
                        
                        
                        swipeFromColumn = component.column
                        swipeFromRow = component.row
                        
                        var horzDelta = 0, vertDelta = 0
                        if component.row == 0 && component.column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                        
                        else if component.row == NumRows - 1 && component.column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                        
                        else if component.row == 0 && component.column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                        
                        else if component.row == NumRows - 1 && component.column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.row == 0 && component.column != 0 && component.column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.row == NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.column == 0 && component.row != 0 && component.row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.column == NumColumns - 1 && component.row != 0 && component.row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        //else if component.row != 0 && component.row != NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                        else {
                            let dataConverter = Int(arc4random_uniform(4)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            else if dataConverter == 4 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                    }
                }
            }
        }
    }

    func direction4() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row) {
                    //if component.componentType != ComponentType.Enzyme && component.componentType != ComponentType.Product {
                        if component.componentType == ComponentType.Enzyme  {

                        print("component: \(component.componentType, component.column, component.row)")
                        
                        
                        swipeFromColumn = component.column
                        swipeFromRow = component.row

                
                var horzDelta = 0, vertDelta = 0
                if row == 0 && column == 0 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = 1
                    }
                    else if dataConverter == 2 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                else if row == NumRows - 1 && column == NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                else if row == 0 && column == NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                else if row == NumRows - 1 && column == 0 {
                    let dataConverter = Int(arc4random_uniform(2)+1)
                    if dataConverter == 1 {
                        horzDelta = 1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                else if row == 0 && column != 0 && column != NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        horzDelta = 1
                    }
                    else if dataConverter == 3 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                else if row == NumRows - 1 && column != 0 && column != NumColumns - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        horzDelta = 1
                    }
                    else if dataConverter == 3 {
                        vertDelta = -1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                else if column == 0 && row != 0 && row != NumRows - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = 1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    else if dataConverter == 3 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                else if column == NumColumns - 1 && row != 0 && row != NumRows - 1 {
                    let dataConverter = Int(arc4random_uniform(3)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        vertDelta = -1
                    }
                    else if dataConverter == 3 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
                    
                    //else if row != 0 && row != NumRows - 1 && column != 0 && column != NumColumns - 1 {
                else {
                    let dataConverter = Int(arc4random_uniform(4)+1)
                    if dataConverter == 1 {
                        horzDelta = -1
                    }
                    else if dataConverter == 2 {
                        horzDelta = 1
                    }
                    else if dataConverter == 3 {
                        vertDelta = -1
                    }
                    else if dataConverter == 4 {
                        vertDelta = 1
                    }
                    print("location: \(swipeFromColumn, swipeFromRow)")
                    print("dataConverter: \(dataConverter)")
                    print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                    trySwapHorizontal3(horzDelta, vertical: vertDelta)
                }
            }
        }
            }
        }
    }

    func direction5() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row) {
                    if component.componentType == ComponentType.Enzyme  {
                        print("component: \(component.componentType, component.column, component.row)")
                        
                        
                        swipeFromColumn = component.column
                        swipeFromRow = component.row
                        
                        var horzDelta = 0, vertDelta = 0
                        if component.row == 0 && component.column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.row == NumRows - 1 && component.column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.row == 0 && component.column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.row == NumRows - 1 && component.column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.row == 0 && component.column != 0 && component.column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.row == NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.column == 0 && component.row != 0 && component.row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                        else if component.column == NumColumns - 1 && component.row != 0 && component.row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                            
                            //else if component.row != 0 && component.row != NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                        else {
                            let dataConverter = Int(arc4random_uniform(4)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            else if dataConverter == 4 {
                                vertDelta = 1
                            }
                            print("location: \(swipeFromColumn, swipeFromRow)")
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            
                            
                            other2(component, horzDelta: horzDelta, vertDelta: vertDelta)
                            
                            
                        }
                    }
                }
            }
        }
    }

      
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swipeFromColumn = nil
        swipeFromRow = nil
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchesEnded(touches!, withEvent: event)
    }

    var swipeHandler: ((Swap) -> ())?
    
    var swipeFromColumn: Int?
    var swipeFromRow: Int?
    
    var level: Level!
    
    let TileWidth: CGFloat = 25
    let TileHeight: CGFloat = 25
    
    let gameLayer = SKNode()
    let componentsLayer = SKNode()
    
    func addSpritesForComponents(components: Set<Component>) {
        for component in components {
            let sprite = SKSpriteNode(imageNamed: component.componentType.spriteName)
            sprite.position = pointForColumn(component.column, row:component.row)
            componentsLayer.addChild(sprite)
            component.sprite = sprite
        }
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
                return (true, Int(point.x/TileWidth), Int(point.y/TileHeight))
        } else {
            return (false, 0, 0)
        }
    }
    
    func trySwapHorizontal(horzDelta: Int, vertical vertDelta: Int) {
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta
        
        if toColumn < 0 || toColumn >= NumColumns { return }
        if toRow < 0 || toRow >= NumRows {return}
        
        let type = ComponentType.Enzyme
        //let type2 = ComponentType.Substrate
        if let toComponent = level.componentAtColumn(toColumn, row: toRow) {
            if let fromComponent = level.componentAtColumn(swipeFromColumn!, row: swipeFromRow!) {
                
                //if fromComponent.componentType == type && toComponent.componentType == type2 {
                    if fromComponent.componentType == type && toComponent.componentType != type {
                    
                    print("fromComponent: \(fromComponent.componentType, fromComponent.column, fromComponent.row )")
                    print("toComponent: \(toComponent.componentType, toComponent.column, toComponent.row)")
                    
                    if let handler = swipeHandler {
                        let swap = Swap(componentA: fromComponent, componentB: toComponent)
                        handler(swap)
                        
                        print("afterswapfromComponent: \(fromComponent.componentType, fromComponent.column, fromComponent.row )")
                        print("afterswaptoComponent: \(toComponent.componentType, toComponent.column, toComponent.row)")

                        level.removepieces(fromComponent, component2: toComponent)
                        self.removecomponents(fromComponent, component2: toComponent)
                        self.combinedcomponent2(fromComponent, component2: toComponent)

                    }
                }
            }
        }
    }
    

    func trySwapHorizontal2(component1: Component, component2: Component) {

        if component2.componentType != ComponentType.Enzyme && component2.componentType != ComponentType.Product {
                    print("component1: \(component1.componentType, component1.column, component1.row )")
                    print("component2: \(component2.componentType, component2.column, component2.row)")
                    
                    if let handler = swipeHandler {
                        let swap = Swap(componentA: component1, componentB: component2)
                        handler(swap)

                    print("afterswapcomponent1: \(component1.componentType, component1.column, component1.row )")
                    print("afterswapcomponent2: \(component2.componentType, component2.column, component2.row)")
                        
                        level.removepieces(component1, component2: component2)
                        self.removecomponents(component1, component2: component2)
                        self.combinedcomponent2(component1, component2: component2)
                    }
                }
    }
    

    func removeAllComponentSprites() {
        componentsLayer.removeAllChildren()
    }
    
    
    func removecomponents(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            if let sprite1 = component1.sprite {
                if sprite1.actionForKey("removing") == nil {
                    let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                    scaleAction.timingMode = .EaseOut
                    sprite1.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                        withKey:"removing")
                }
            }
            
            if let sprite2 = component2.sprite {
                if sprite2.actionForKey("removing") == nil {
                    let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                    scaleAction.timingMode = .EaseOut
                    sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                        withKey:"removing")
                }
            }
        }
    }
    
    
    func revert(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            
            if component2.componentType == ComponentType.Substrate {
                
                let componentType = ComponentType.Enzyme
                let component = Component(column: component2.column, row: component2.row, componentType: componentType)
                let sprite1 = SKSpriteNode(imageNamed: component.componentType.spriteName)
                sprite1.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(sprite1)
                component.sprite = sprite1
                
                let newPosition1 = pointForColumn(component2.column, row: component2.row)
                let moveAction1 = SKAction.moveTo(newPosition1, duration: 0.3)
                moveAction1.timingMode = .EaseOut
                sprite1.alpha = 0
                sprite1.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction1])]))
                
                print("enzyme: \(component.column, component.row)")
                
                let newcomponentType = ComponentType.Product
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                let sprite2 = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite2.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite2)
                newcomponent.sprite = sprite2
                
                let newPosition2 = pointForColumn(component1.column, row: component1.row)
                let moveAction2 = SKAction.moveTo(newPosition2, duration: 0.3)
                moveAction2.timingMode = .EaseOut
                sprite2.alpha = 0
                sprite2.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction2])]))
                
                print("product: \(newcomponent.column, newcomponent.row)")

            }
            
            if component2.componentType == ComponentType.Competitive_Inhibitor{
                
                let componentType = ComponentType.Enzyme
                let component = Component(column: component2.column, row: component2.row, componentType: componentType)
                let sprite1 = SKSpriteNode(imageNamed: component.componentType.spriteName)
                sprite1.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(sprite1)
                component.sprite = sprite1
                
                let newPosition1 = pointForColumn(component2.column, row: component2.row)
                let moveAction1 = SKAction.moveTo(newPosition1, duration: 0.3)
                moveAction1.timingMode = .EaseOut
                sprite1.alpha = 0
                sprite1.runAction(SKAction.sequence([SKAction.waitForDuration(6), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction1])]))
                
                let newcomponentType = ComponentType.Competitive_Inhibitor
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                let sprite2 = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite2.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite2)
                newcomponent.sprite = sprite2
                
                let newPosition2 = pointForColumn(component1.column, row: component1.row)
                let moveAction2 = SKAction.moveTo(newPosition2, duration: 0.3)
                moveAction2.timingMode = .EaseOut
                sprite2.alpha = 0
                sprite2.runAction(SKAction.sequence([SKAction.waitForDuration(6), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction2])]))
            }
            
            if component2.componentType == ComponentType.Deactivator {
                
                let componentType = ComponentType.Enzyme
                let component = Component(column: component2.column, row: component2.row, componentType: componentType)
                let sprite1 = SKSpriteNode(imageNamed: component.componentType.spriteName)
                sprite1.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(sprite1)
                component.sprite = sprite1
                
                let newPosition1 = pointForColumn(component2.column, row: component2.row)
                let moveAction1 = SKAction.moveTo(newPosition1, duration: 0.3)
                moveAction1.timingMode = .EaseOut
                sprite1.alpha = 0
                sprite1.runAction(SKAction.sequence([SKAction.waitForDuration(4.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction1])]))
                
                let newcomponentType = ComponentType.Deactivator
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                let sprite2 = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite2.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite2)
                newcomponent.sprite = sprite2
                
                let newPosition2 = pointForColumn(component1.column, row: component1.row)
                let moveAction2 = SKAction.moveTo(newPosition2, duration: 0.3)
                moveAction2.timingMode = .EaseOut
                sprite2.alpha = 0
                sprite2.runAction(SKAction.sequence([SKAction.waitForDuration(4.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction2])]))
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                
                let componentType = ComponentType.Enzyme
                let component = Component(column: component2.column, row: component2.row, componentType: componentType)
                let sprite1 = SKSpriteNode(imageNamed: component.componentType.spriteName)
                sprite1.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(sprite1)
                component.sprite = sprite1
                
                let newPosition1 = pointForColumn(component2.column, row: component2.row)
                let moveAction1 = SKAction.moveTo(newPosition1, duration: 0.3)
                moveAction1.timingMode = .EaseOut
                sprite1.alpha = 0
                sprite1.runAction(SKAction.sequence([SKAction.waitForDuration(5.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction1])]))
                
                let newcomponentType = ComponentType.Noncompetitive_Inhibitor
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                let sprite2 = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite2.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite2)
                newcomponent.sprite = sprite2
                
                let newPosition2 = pointForColumn(component1.column, row: component1.row)
                let moveAction2 = SKAction.moveTo(newPosition2, duration: 0.3)
                moveAction2.timingMode = .EaseOut
                sprite2.alpha = 0
                sprite2.runAction(SKAction.sequence([SKAction.waitForDuration(5.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction2])]))
            }
            
            if component2.componentType == ComponentType.Activator {
                
                let componentType = ComponentType.Enzyme
                let component = Component(column: component2.column, row: component2.row, componentType: componentType)
                let sprite1 = SKSpriteNode(imageNamed: component.componentType.spriteName)
                sprite1.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(sprite1)
                component.sprite = sprite1
                
                let newPosition1 = pointForColumn(component2.column, row: component2.row)
                let moveAction1 = SKAction.moveTo(newPosition1, duration: 0.3)
                moveAction1.timingMode = .EaseOut
                sprite1.alpha = 0
                sprite1.runAction(SKAction.sequence([SKAction.waitForDuration(5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction1])]))
                
                let newcomponentType = ComponentType.Activator
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                let sprite2 = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite2.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite2)
                newcomponent.sprite = sprite2
                
                let newPosition2 = pointForColumn(component1.column, row: component1.row)
                let moveAction2 = SKAction.moveTo(newPosition2, duration: 0.3)
                moveAction2.timingMode = .EaseOut
                sprite2.alpha = 0
                sprite2.runAction(SKAction.sequence([SKAction.waitForDuration(5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction2])]))
            }

        }
        
    }
    
    
    func combinedcomponent(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            let time = 0.5
            let delay = 0.5
            
            print("component1: \(component1.componentType, component1.column, component1.row)")
            print("component2: \(component2.componentType, component2.column, component2.row)")
            
            if component2.componentType == ComponentType.Substrate {
                let newcomponentType = ComponentType.ESComplex
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                
                let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite)
                newcomponent.sprite = sprite
                
                let newPosition = pointForColumn(component1.column, row: component1.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(0.05), moveAction]))
               

                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(2), scaleAction, SKAction.removeFromParent()]),
                        withKey:"removing")
                
                print("escomplex: \(newcomponent.column, newcomponent.row)")
                let columns = level.components(component1, component2: component2)

                revert3(component1, component2: component2, columns: columns)
                
                //self.revert(component1, component2: component2)
            }

        
            if component2.componentType == ComponentType.Competitive_Inhibitor {
                let newcomponentType = ComponentType.Enzyme_with_Competitive_Inhibitor
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                
                let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite)
                newcomponent.sprite = sprite
                
                let newPosition = pointForColumn(component1.column, row: component1.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(time), moveAction]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(delay, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                    withKey:"removing")
                self.revert(component1, component2: component2)
            }
            
            if component2.componentType == ComponentType.Deactivator {
                let newcomponentType = ComponentType.Enzyme_with_deactivator
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                
                let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite)
                newcomponent.sprite = sprite
                
                let newPosition = pointForColumn(component1.column, row: component1.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(time), moveAction]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(delay, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                    withKey:"removing")
                self.revert(component1, component2: component2)
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                let newcomponentType = ComponentType.Enzyme_with_Noncompetitive_Inhibitor
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                
                let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite)
                newcomponent.sprite = sprite
                
                let newPosition = pointForColumn(component1.column, row: component1.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(time), moveAction]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(delay, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                    withKey:"removing")
                
                if newcomponent.column != NumColumns - 1 {
                if let othercomponent = level.componentAtColumn(newcomponent.column + 1, row: newcomponent.row) {
                    if othercomponent.componentType == ComponentType.Substrate {
                        if let sprite = newcomponent.sprite {
                            //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                            //}
                        }
                        
                        if let sprite2 = othercomponent.sprite {
                            //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                            //}
                        }
                        let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                        let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                        let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                        sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                        componentsLayer.addChild(sprite)
                        newcomponent2.sprite = sprite
                        
                        let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                        moveAction.timingMode = .EaseOut
                        sprite.alpha = 0
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                        
                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                            withKey:"removing")
                        
                        
                        let componentAType = ComponentType.Enzyme
                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                        componentsLayer.addChild(spriteA)
                        componentA.sprite = spriteA
                        
                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                        moveActionA.timingMode = .EaseOut
                        spriteA.alpha = 0
                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                        
                        let componentBType = ComponentType.Noncompetitive_Inhibitor
                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                        componentsLayer.addChild(spriteB)
                        componentB.sprite = spriteB
                        
                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                        moveActionB.timingMode = .EaseOut
                        spriteB.alpha = 0
                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                        
                        let componentCType = ComponentType.Substrate
                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                        componentsLayer.addChild(spriteC)
                        componentC.sprite = spriteC
                        
                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                        moveActionC.timingMode = .EaseOut
                        spriteC.alpha = 0
                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))

                    }
                    
                    else {
                        self.revert(component1, component2: component2)
                    }
                }
                }
                
                if newcomponent.column != 0 {
                    
                    if let othercomponent = level.componentAtColumn(newcomponent.column - 1, row: newcomponent.row) {
                    if othercomponent.componentType == ComponentType.Substrate {
                        if let sprite = newcomponent.sprite {
                            //if sprite.actionForKey("removing") == nil {
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            scaleAction.timingMode = .EaseOut
                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            //}
                        }
                        
                        if let sprite2 = othercomponent.sprite {
                            //if sprite2.actionForKey("removing") == nil {
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            scaleAction.timingMode = .EaseOut
                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            //}
                        }
                        let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                        let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                        let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                        sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                        componentsLayer.addChild(sprite)
                        newcomponent2.sprite = sprite
                        
                        let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                        moveAction.timingMode = .EaseOut
                        sprite.alpha = 0
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                        
                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                            withKey:"removing")
                        
                        
                        let componentAType = ComponentType.Enzyme
                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                        componentsLayer.addChild(spriteA)
                        componentA.sprite = spriteA
                        
                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                        moveActionA.timingMode = .EaseOut
                        spriteA.alpha = 0
                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                        
                        let componentBType = ComponentType.Noncompetitive_Inhibitor
                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                        componentsLayer.addChild(spriteB)
                        componentB.sprite = spriteB
                        
                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                        moveActionB.timingMode = .EaseOut
                        spriteB.alpha = 0
                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                        
                        let componentCType = ComponentType.Substrate
                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                        componentsLayer.addChild(spriteC)
                        componentC.sprite = spriteC
                        
                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                        moveActionC.timingMode = .EaseOut
                        spriteC.alpha = 0
                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                    }
                        
                    else {
                        self.revert(component1, component2: component2)
                    }
                    }
                }
                
                if newcomponent.row != NumRows - 1 {
                if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row + 1) {
                    if othercomponent.componentType == ComponentType.Substrate {
                        if let sprite = newcomponent.sprite {
                            //if sprite.actionForKey("removing") == nil {
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            scaleAction.timingMode = .EaseOut
                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            //}
                        }
                        
                        if let sprite2 = othercomponent.sprite {
                            //if sprite2.actionForKey("removing") == nil {
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            scaleAction.timingMode = .EaseOut
                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            //}
                        }
                        let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                        let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                        let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                        sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                        componentsLayer.addChild(sprite)
                        newcomponent2.sprite = sprite
                        
                        let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                        moveAction.timingMode = .EaseOut
                        sprite.alpha = 0
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                        
                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                            withKey:"removing")
                        
                        
                        let componentAType = ComponentType.Enzyme
                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                        componentsLayer.addChild(spriteA)
                        componentA.sprite = spriteA
                        
                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                        moveActionA.timingMode = .EaseOut
                        spriteA.alpha = 0
                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                        
                        let componentBType = ComponentType.Noncompetitive_Inhibitor
                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                        componentsLayer.addChild(spriteB)
                        componentB.sprite = spriteB
                        
                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                        moveActionB.timingMode = .EaseOut
                        spriteB.alpha = 0
                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                        
                        let componentCType = ComponentType.Substrate
                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                        componentsLayer.addChild(spriteC)
                        componentC.sprite = spriteC
                        
                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                        moveActionC.timingMode = .EaseOut
                        spriteC.alpha = 0
                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                    }
                        
                    else {
                        self.revert(component1, component2: component2)
                    }
                }
                }
                
                if newcomponent.row != 0 {
                if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row - 1) {
                    if othercomponent.componentType == ComponentType.Substrate {
                        if let sprite = newcomponent.sprite {
                            //if sprite.actionForKey("removing") == nil {
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            scaleAction.timingMode = .EaseOut
                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            //}
                        }
                        
                        if let sprite2 = othercomponent.sprite {
                            //if sprite2.actionForKey("removing") == nil {
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            scaleAction.timingMode = .EaseOut
                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            //}
                        }
                        let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                        let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                        let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                        sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                        componentsLayer.addChild(sprite)
                        newcomponent2.sprite = sprite
                        
                        let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                        moveAction.timingMode = .EaseOut
                        sprite.alpha = 0
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                        
                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                            withKey:"removing")
                        
                        
                        let componentAType = ComponentType.Enzyme
                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                        componentsLayer.addChild(spriteA)
                        componentA.sprite = spriteA
                        
                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                        moveActionA.timingMode = .EaseOut
                        spriteA.alpha = 0
                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                        
                        let componentBType = ComponentType.Noncompetitive_Inhibitor
                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                        componentsLayer.addChild(spriteB)
                        componentB.sprite = spriteB
                        
                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                        moveActionB.timingMode = .EaseOut
                        spriteB.alpha = 0
                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                        
                        let componentCType = ComponentType.Substrate
                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                        componentsLayer.addChild(spriteC)
                        componentC.sprite = spriteC
                        
                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                        moveActionC.timingMode = .EaseOut
                        spriteC.alpha = 0
                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                    }
                        
                    else {
                        self.revert(component1, component2: component2)
                    }
                }
                }
    
            }
            
            if component2.componentType == ComponentType.Activator {
                let newcomponentType = ComponentType.Enzyme_with_one_activator
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                
                let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite)
                newcomponent.sprite = sprite
                
                let newPosition = pointForColumn(component1.column, row: component1.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(time), moveAction]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(delay, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                    withKey:"removing")
                if newcomponent.column != NumColumns - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column + 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                            
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                if newcomponent.column != 0 {
                    
                    if let othercomponent = level.componentAtColumn(newcomponent.column - 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                if newcomponent.row != NumRows - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row + 1) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                if newcomponent.row != 0 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row - 1) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                
                
                
                
                if newcomponent.column != NumColumns - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column + 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            if newcomponent2.column != NumColumns - 1 {
                                if let othercomponent2 = level.componentAtColumn(newcomponent2.column + 1, row: newcomponent2.row) {
                                    if othercomponent2.componentType == ComponentType.Substrate {
                                        if let sprite = newcomponent2.sprite {
                                            //if sprite.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        if let sprite2 = othercomponent2.sprite {
                                            //if sprite2.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                        let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                        let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                        sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(sprite)
                                        newcomponent3.sprite = sprite
                                        
                                        let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                        moveAction.timingMode = .EaseOut
                                        sprite.alpha = 0
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                        
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                        
                                        let componentDType = ComponentType.Substrate
                                        let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                        let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                        spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        componentsLayer.addChild(spriteD)
                                        componentD.sprite = spriteD
                                        
                                        let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                        moveActionD.timingMode = .EaseOut
                                        spriteD.alpha = 0
                                        spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                    }
                                        
                                    else {
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                    }
                                }
                                    
                                else {
                                    self.revert(component1, component2: component2)
                                }
                            }
                        }
                    }
                }

                
                if newcomponent.column != 0 {
                    
                    if let othercomponent = level.componentAtColumn(newcomponent.column - 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            if newcomponent2.column != 0 {
                                if let othercomponent2 = level.componentAtColumn(newcomponent2.column - 1, row: newcomponent2.row) {
                                    if othercomponent2.componentType == ComponentType.Substrate {
                                        if let sprite = newcomponent2.sprite {
                                            //if sprite.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        if let sprite2 = othercomponent2.sprite {
                                            //if sprite2.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                        let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                        let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                        sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(sprite)
                                        newcomponent3.sprite = sprite
                                        
                                        let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                        moveAction.timingMode = .EaseOut
                                        sprite.alpha = 0
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                        
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                        
                                        let componentDType = ComponentType.Substrate
                                        let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                        let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                        spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        componentsLayer.addChild(spriteD)
                                        componentD.sprite = spriteD
                                        
                                        let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                        moveActionD.timingMode = .EaseOut
                                        spriteD.alpha = 0
                                        spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                    }
                                        
                                    else {
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                    }
                                }
                                    
                                else {
                                    self.revert(component1, component2: component2)
                                }
                            }
                        }
                    }
                }

                
                if newcomponent.row != NumRows - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row + 1) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            if newcomponent2.row != NumRows - 1 {
                                if let othercomponent2 = level.componentAtColumn(newcomponent2.column, row: newcomponent2.row + 1) {
                                    if othercomponent2.componentType == ComponentType.Substrate {
                                        if let sprite = newcomponent2.sprite {
                                            //if sprite.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        if let sprite2 = othercomponent2.sprite {
                                            //if sprite2.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                        let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                        let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                        sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(sprite)
                                        newcomponent3.sprite = sprite
                                        
                                        let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                        moveAction.timingMode = .EaseOut
                                        sprite.alpha = 0
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                        
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                        
                                        let componentDType = ComponentType.Substrate
                                        let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                        let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                        spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        componentsLayer.addChild(spriteD)
                                        componentD.sprite = spriteD
                                        
                                        let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                        moveActionD.timingMode = .EaseOut
                                        spriteD.alpha = 0
                                        spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                    }
                                        
                                    else {
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                    }
                                }
                                    
                                else {
                                    self.revert(component1, component2: component2)
                                }
                            }
                        }
                    }
                }
            
            
                if newcomponent.row != 0 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row - 1) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            if newcomponent2.row != 0 {
                            if let othercomponent2 = level.componentAtColumn(newcomponent2.column, row: newcomponent2.row - 1) {
                                if othercomponent2.componentType == ComponentType.Substrate {
                                    if let sprite = newcomponent2.sprite {
                                        //if sprite.actionForKey("removing") == nil {
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        scaleAction.timingMode = .EaseOut
                                        sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        //}
                                    }
                                    
                                    if let sprite2 = othercomponent2.sprite {
                                        //if sprite2.actionForKey("removing") == nil {
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        scaleAction.timingMode = .EaseOut
                                        sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        //}
                                    }
                                    
                                    let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                    let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                    let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                    sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                    componentsLayer.addChild(sprite)
                                    newcomponent3.sprite = sprite
                                    
                                    let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                    let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                    moveAction.timingMode = .EaseOut
                                    sprite.alpha = 0
                                    sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                    
                                    let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                    sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                        withKey:"removing")
                                    
                                    
                                    let componentAType = ComponentType.Enzyme
                                    let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                    let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                    spriteA.position = pointForColumn(component2.column, row: component2.row)
                                    componentsLayer.addChild(spriteA)
                                    componentA.sprite = spriteA
                                    
                                    let newPositionA = pointForColumn(component2.column, row: component2.row)
                                    let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                    moveActionA.timingMode = .EaseOut
                                    spriteA.alpha = 0
                                    spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                    
                                    let componentBType = ComponentType.Activator
                                    let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                    let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                    spriteB.position = pointForColumn(component1.column, row: component1.row)
                                    componentsLayer.addChild(spriteB)
                                    componentB.sprite = spriteB
                                    
                                    let newPositionB = pointForColumn(component1.column, row: component1.row)
                                    let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                    moveActionB.timingMode = .EaseOut
                                    spriteB.alpha = 0
                                    spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                    
                                    let componentCType = ComponentType.Activator
                                    let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                    let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                    spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                    componentsLayer.addChild(spriteC)
                                    componentC.sprite = spriteC
                                    
                                    let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                    let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                    moveActionC.timingMode = .EaseOut
                                    spriteC.alpha = 0
                                    spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                
                                    let componentDType = ComponentType.Substrate
                                    let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                    let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                    spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                    componentsLayer.addChild(spriteD)
                                    componentD.sprite = spriteD
                                    
                                    let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                    let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                    moveActionD.timingMode = .EaseOut
                                    spriteD.alpha = 0
                                    spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                }
                                    
                                else {
                                    
                                    let componentAType = ComponentType.Enzyme
                                    let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                    let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                    spriteA.position = pointForColumn(component2.column, row: component2.row)
                                    componentsLayer.addChild(spriteA)
                                    componentA.sprite = spriteA
                            
                                    let newPositionA = pointForColumn(component2.column, row: component2.row)
                                    let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                    moveActionA.timingMode = .EaseOut
                                    spriteA.alpha = 0
                                    spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                                    let componentBType = ComponentType.Activator
                                    let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                    let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                    spriteB.position = pointForColumn(component1.column, row: component1.row)
                                    componentsLayer.addChild(spriteB)
                                    componentB.sprite = spriteB
                            
                                    let newPositionB = pointForColumn(component1.column, row: component1.row)
                                    let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                    moveActionB.timingMode = .EaseOut
                                    spriteB.alpha = 0
                                    spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                                    let componentCType = ComponentType.Activator
                                    let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                    let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                    spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                    componentsLayer.addChild(spriteC)
                                    componentC.sprite = spriteC
                            
                                    let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                    let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                    moveActionC.timingMode = .EaseOut
                                    spriteC.alpha = 0
                                    spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                }
                            }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func components(component1: Component, component2: Component, componentType: ComponentType, newcomponentType: ComponentType) {
        let component = Component(column: component2.column, row: component2.row, componentType: componentType)
        let sprite1 = SKSpriteNode(imageNamed: component.componentType.spriteName)
        sprite1.position = pointForColumn(component2.column, row: component2.row)
        componentsLayer.addChild(sprite1)
        component.sprite = sprite1
        
        let newPosition1 = pointForColumn(component2.column, row: component2.row)
        let moveAction1 = SKAction.moveTo(newPosition1, duration: 0.3)
        moveAction1.timingMode = .EaseOut
        sprite1.alpha = 0
        sprite1.runAction(SKAction.sequence([SKAction.waitForDuration(6), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction1])]))
        
        print("enzyme: \(component.column, component.row)")
        
        let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
        let sprite2 = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite2.position = pointForColumn(component1.column, row: component1.row)
        componentsLayer.addChild(sprite2)
        newcomponent.sprite = sprite2
        
        let newPosition2 = pointForColumn(component1.column, row: component1.row)
        let moveAction2 = SKAction.moveTo(newPosition2, duration: 0.3)
        moveAction2.timingMode = .EaseOut
        sprite2.alpha = 0
        sprite2.runAction(SKAction.sequence([SKAction.waitForDuration(6), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction2])]))
        
        print("newcomponent: \(newcomponent.column, newcomponent.row)")

    }
    
    
    func revert2(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            if component2.componentType == ComponentType.Substrate {
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Product)
            }
            
            if component2.componentType == ComponentType.Competitive_Inhibitor{
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Competitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Deactivator {
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Deactivator)
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Noncompetitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Activator {
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Activator)
            }
        }
    }
    
    
    func combinedpiece(component1: Component, component2: Component, newcomponentType: ComponentType) {

      
        let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
        
        let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite.position = pointForColumn(component1.column, row: component1.row)
        componentsLayer.addChild(sprite)
        newcomponent.sprite = sprite
        
        let newPosition = pointForColumn(component1.column, row: component1.row)
        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
        moveAction.timingMode = .EaseOut
        sprite.alpha = 0
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(2), SKAction.fadeInWithDuration(0.25), moveAction]))
        //sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(0.05), moveAction]))

        
        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
        //sprite.runAction(SKAction.sequence([SKAction.waitForDuration(delay, withRange: 5), scaleAction, SKAction.removeFromParent()]),
            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(4), scaleAction, SKAction.removeFromParent()]),

            withKey:"removing")
        let columns = level.components(component1, component2: component2)
        revert3(component1, component2: component2, columns: columns)
        
        //self.revert2(component1, component2: component2)
    }
    
    func combinedpiece2(component: Component, newcomponentType: ComponentType) {

        let newcomponent = Component(column: component.column, row: component.row, componentType: newcomponentType)
        
        let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite.position = pointForColumn(component.column, row: component.row)
        componentsLayer.addChild(sprite)
        newcomponent.sprite = sprite
        
        let newPosition = pointForColumn(component.column, row: component.row)
        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
        moveAction.timingMode = .EaseOut
        sprite.alpha = 0
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(4), SKAction.fadeInWithDuration(0.25), moveAction]))
        
        
        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(5), scaleAction, SKAction.removeFromParent()]),
            
            withKey:"removing")
        //let columns = level.components2(component1, component2: component2)
        //revert3(component1, component2: component2, columns: columns)
        
        //self.revert2(component1, component2: component2)
        
    }
    
    func combinedpiece3(component1: Component, component2: Component, newcomponentType: ComponentType) {
        
        let newcomponent = Component(column: component2.column, row: component2.row, componentType: newcomponentType)
        
        let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite.position = pointForColumn(component2.column, row: component2.row)
        componentsLayer.addChild(sprite)
        newcomponent.sprite = sprite
        
        let newPosition = pointForColumn(component2.column, row: component2.row)
        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
        moveAction.timingMode = .EaseOut
        sprite.alpha = 0
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(2), SKAction.fadeInWithDuration(0.25), moveAction]))
        
        
        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(4), scaleAction, SKAction.removeFromParent()]),
            
            withKey:"removing")
        //let columns = level.components2(component1, component2: component2)
        //revert3(component1, component2: component2, columns: columns)
        
        self.revert2(component1, component2: component2)
        //extrarxn2(component1, component2: component2)
        
    }
    
    func remove(newcomponent:Component, othercomponent: Component) {
        if let sprite = newcomponent.sprite {
            //if sprite.actionForKey("removing") == nil {
            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
            scaleAction.timingMode = .EaseOut
            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
            //}
        }
        
        if let sprite2 = othercomponent.sprite {
            //if sprite2.actionForKey("removing") == nil {
            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
            scaleAction.timingMode = .EaseOut
            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
            //}
        }
    }
    
    func extrarxn(component1: Component, component2: Component, newcomponent: Component) {
        if newcomponent.column != NumColumns - 1 {
            if let othercomponent = level.componentAtColumn(newcomponent.column + 1, row: newcomponent.row) {
                if othercomponent.componentType == ComponentType.Substrate {
                    if let sprite = newcomponent.sprite {
        //if sprite.actionForKey("removing") == nil {
                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                        scaleAction.timingMode = .EaseOut
                        sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                            withKey:"removing")
        //}
                    }
        
                    if let sprite2 = othercomponent.sprite {
            //if sprite2.actionForKey("removing") == nil {
                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                        scaleAction.timingMode = .EaseOut
                        sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                            withKey:"removing")
            //}
                    }
                    
                    let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                    let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                    sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                    componentsLayer.addChild(sprite)
                    newcomponent2.sprite = sprite
            
                    let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                    let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                    moveAction.timingMode = .EaseOut
                    sprite.alpha = 0
                    sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
            
                    let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                    sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                        withKey:"removing")
            
            
                    let componentAType = ComponentType.Enzyme
                    let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                    let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                    spriteA.position = pointForColumn(component2.column, row: component2.row)
                    componentsLayer.addChild(spriteA)
                    componentA.sprite = spriteA
            
                    let newPositionA = pointForColumn(component2.column, row: component2.row)
                    let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                    moveActionA.timingMode = .EaseOut
                    spriteA.alpha = 0
                    spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
            
                    let componentBType = ComponentType.Noncompetitive_Inhibitor
                    let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                    let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                    spriteB.position = pointForColumn(component1.column, row: component1.row)
                    componentsLayer.addChild(spriteB)
                    componentB.sprite = spriteB
            
                    let newPositionB = pointForColumn(component1.column, row: component1.row)
                    let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                    moveActionB.timingMode = .EaseOut
                    spriteB.alpha = 0
                    spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
            
                    let componentCType = ComponentType.Substrate
                    let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                    let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                    spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                    componentsLayer.addChild(spriteC)
                    componentC.sprite = spriteC
            
                    let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                    let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                    moveActionC.timingMode = .EaseOut
                    spriteC.alpha = 0
                    spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
        
                }
        
                else {
                    self.revert(component1, component2: component2)
                }
            }
        }

    }
    
    
    func nci(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component) {
        remove(newcomponent, othercomponent: othercomponent)
        
        combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate)
        
        componentsprite(component2, componentType: ComponentType.Enzyme)
        
        componentsprite(component1, componentType: ComponentType.Noncompetitive_Inhibitor)
        
        componentsprite(othercomponent, componentType: ComponentType.Substrate)

    }
    
    func extrarxn2(component1: Component, component2: Component) {
        let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor)
        
        let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite.position = pointForColumn(component2.column, row: component2.row)
        componentsLayer.addChild(sprite)
        newcomponent.sprite = sprite
        
        let newPosition = pointForColumn(component2.column, row: component2.row)
        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
        moveAction.timingMode = .EaseOut
        sprite.alpha = 0
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.fadeInWithDuration(0.25), moveAction]))
        
        
        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(3), scaleAction, SKAction.removeFromParent()]),
            
            withKey:"removing")
        
        
        //let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor)
        var horzDelta = 0, vertDelta = 0

        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
        
        
        
    }
    


    
    func activator(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component) {
        remove(newcomponent, othercomponent: othercomponent)
        
        combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
        
        componentsprite(component2, componentType: ComponentType.Enzyme)
        
        componentsprite(component1, componentType: ComponentType.Activator)
        
        componentsprite(othercomponent, componentType: ComponentType.Substrate)
        
    }
    
    func extrarxn3(component1: Component, component2: Component, newcomponent: Component) {
        //let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_one_activator)
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                    
                    //activator(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Substrate {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                    
                    extrarxn4(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
    }
    
    func aa(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component, othercomponent2: Component) {
        remove(newcomponent, othercomponent: othercomponent)
        
        combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_2_activators_and_substrate)
        
        componentsprite(component2, componentType: ComponentType.Enzyme)
        
        componentsprite(component1, componentType: ComponentType.Activator)
        
        componentsprite(othercomponent, componentType: ComponentType.Substrate)
        
        componentsprite(othercomponent2, componentType: ComponentType.Activator)
        
    }
    
    
    func aa2(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component, othercomponent2: Component)  {
        remove(newcomponent, othercomponent: othercomponent)
        
        combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_2_activators_and_substrate)
        
        componentsprite(component2, componentType: ComponentType.Enzyme)
        
        componentsprite(component1, componentType: ComponentType.Activator)
        
        componentsprite(othercomponent, componentType: ComponentType.Activator)
        
        componentsprite(othercomponent2, componentType: ComponentType.Substrate)
        
    }
    
    func extrarxn4(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component) {
        //let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_one_activator)
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Activator {
                    aa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Substrate)
                }
            }
        }
 
    }
    
    func extrarxn5(component1: Component, component2: Component, newcomponent: Component) {
        //let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_one_activator)
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent.componentType == ComponentType.Activator {
                    remove(newcomponent, othercomponent: othercomponent)
                    
                    combinedpiece2(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators)
                    let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                    
                    extrarxn6(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
                }
                    
                else {
                    self.revert2(component1, component2: component2)
                }
            }
        }
    }

    func extrarxn6(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component) {
        //let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_one_activator)
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
                if othercomponent2.componentType == ComponentType.Substrate {
                    aa2(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
                }
                    
                else {
                    componentsprite(component2, componentType: ComponentType.Enzyme)
                    componentsprite(component1, componentType: ComponentType.Activator)
                    componentsprite(othercomponent, componentType: ComponentType.Activator)
                }
            }
        }
        
    }
    
    func combinedcomponent2(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            
            if component2.componentType == ComponentType.Substrate {
                combinedpiece(component1, component2: component2, newcomponentType: ComponentType.ESComplex)
            }
            
            if component2.componentType == ComponentType.Competitive_Inhibitor {
                combinedpiece(component1, component2: component2, newcomponentType: ComponentType.Enzyme_with_Competitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Deactivator {
                combinedpiece(component1, component2: component2, newcomponentType: ComponentType.Enzyme_with_deactivator)
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                
                //combinedpiece2(component2, newcomponentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate)
                
                //combinedpiece3(component1, component2: component2, newcomponentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor)
                
                extrarxn2(component1, component2: component2)
            }
            
            if component2.componentType == ComponentType.Activator {
                combinedpiece2(component2, newcomponentType: ComponentType.Enzyme_with_one_activator)

                let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_one_activator)
                extrarxn3(component1, component2: component2, newcomponent: newcomponent)

                extrarxn5(component1, component2: component2, newcomponent: newcomponent)
            }
        }
    }

    func combinedcomponent3(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            let time = 0.5
            let delay = 0.5
            
            
            if component2.componentType == ComponentType.Substrate {
                combinedpiece(component1, component2: component2, newcomponentType: ComponentType.ESComplex)
                
            }
            
            
            if component2.componentType == ComponentType.Competitive_Inhibitor {
                combinedpiece(component1, component2: component2, newcomponentType: ComponentType.Enzyme_with_Competitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Deactivator {
                combinedpiece(component1, component2: component2, newcomponentType: ComponentType.Enzyme_with_deactivator)
                
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                combinedpiece2(component1, newcomponentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor)
                
                
                //                let newcomponentType = ComponentType.Enzyme_with_Noncompetitive_Inhibitor
                //                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                
                /* let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite)
                newcomponent.sprite = sprite
                
                let newPosition = pointForColumn(component1.column, row: component1.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(time), moveAction]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(delay, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")*/
                
                extrarxn2(component1, component2: component2)
                /*if newcomponent.column != NumColumns - 1 {
                if let othercomponent = level.componentAtColumn(newcomponent.column + 1, row: newcomponent.row) {
                if othercomponent.componentType == ComponentType.Substrate {
                if let sprite = newcomponent.sprite {
                //if sprite.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                
                if let sprite2 = othercomponent.sprite {
                //if sprite2.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                componentsLayer.addChild(sprite)
                newcomponent2.sprite = sprite
                
                let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                
                
                let componentAType = ComponentType.Enzyme
                let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                spriteA.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(spriteA)
                componentA.sprite = spriteA
                
                let newPositionA = pointForColumn(component2.column, row: component2.row)
                let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                moveActionA.timingMode = .EaseOut
                spriteA.alpha = 0
                spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                
                let componentBType = ComponentType.Noncompetitive_Inhibitor
                let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                spriteB.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(spriteB)
                componentB.sprite = spriteB
                
                let newPositionB = pointForColumn(component1.column, row: component1.row)
                let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                moveActionB.timingMode = .EaseOut
                spriteB.alpha = 0
                spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                
                let componentCType = ComponentType.Substrate
                let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                componentsLayer.addChild(spriteC)
                componentC.sprite = spriteC
                
                let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                moveActionC.timingMode = .EaseOut
                spriteC.alpha = 0
                spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                
                }
                
                else {
                self.revert(component1, component2: component2)
                }
                }
                }
                
                if newcomponent.column != 0 {
                
                if let othercomponent = level.componentAtColumn(newcomponent.column - 1, row: newcomponent.row) {
                if othercomponent.componentType == ComponentType.Substrate {
                if let sprite = newcomponent.sprite {
                //if sprite.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                
                if let sprite2 = othercomponent.sprite {
                //if sprite2.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                componentsLayer.addChild(sprite)
                newcomponent2.sprite = sprite
                
                let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                
                
                let componentAType = ComponentType.Enzyme
                let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                spriteA.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(spriteA)
                componentA.sprite = spriteA
                
                let newPositionA = pointForColumn(component2.column, row: component2.row)
                let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                moveActionA.timingMode = .EaseOut
                spriteA.alpha = 0
                spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                
                let componentBType = ComponentType.Noncompetitive_Inhibitor
                let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                spriteB.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(spriteB)
                componentB.sprite = spriteB
                
                let newPositionB = pointForColumn(component1.column, row: component1.row)
                let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                moveActionB.timingMode = .EaseOut
                spriteB.alpha = 0
                spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                
                let componentCType = ComponentType.Substrate
                let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                componentsLayer.addChild(spriteC)
                componentC.sprite = spriteC
                
                let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                moveActionC.timingMode = .EaseOut
                spriteC.alpha = 0
                spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                }
                
                else {
                self.revert(component1, component2: component2)
                }
                }
                }
                
                if newcomponent.row != NumRows - 1 {
                if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row + 1) {
                if othercomponent.componentType == ComponentType.Substrate {
                if let sprite = newcomponent.sprite {
                //if sprite.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                
                if let sprite2 = othercomponent.sprite {
                //if sprite2.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                componentsLayer.addChild(sprite)
                newcomponent2.sprite = sprite
                
                let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                
                
                let componentAType = ComponentType.Enzyme
                let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                spriteA.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(spriteA)
                componentA.sprite = spriteA
                
                let newPositionA = pointForColumn(component2.column, row: component2.row)
                let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                moveActionA.timingMode = .EaseOut
                spriteA.alpha = 0
                spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                
                let componentBType = ComponentType.Noncompetitive_Inhibitor
                let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                spriteB.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(spriteB)
                componentB.sprite = spriteB
                
                let newPositionB = pointForColumn(component1.column, row: component1.row)
                let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                moveActionB.timingMode = .EaseOut
                spriteB.alpha = 0
                spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                
                let componentCType = ComponentType.Substrate
                let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                componentsLayer.addChild(spriteC)
                componentC.sprite = spriteC
                
                let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                moveActionC.timingMode = .EaseOut
                spriteC.alpha = 0
                spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                }
                
                else {
                self.revert(component1, component2: component2)
                }
                }
                }
                
                if newcomponent.row != 0 {
                if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row - 1) {
                if othercomponent.componentType == ComponentType.Substrate {
                if let sprite = newcomponent.sprite {
                //if sprite.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                
                if let sprite2 = othercomponent.sprite {
                //if sprite2.actionForKey("removing") == nil {
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                scaleAction.timingMode = .EaseOut
                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                //}
                }
                let newcomponentType2 = ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate
                let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                componentsLayer.addChild(sprite)
                newcomponent2.sprite = sprite
                
                let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
                
                
                let componentAType = ComponentType.Enzyme
                let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                spriteA.position = pointForColumn(component2.column, row: component2.row)
                componentsLayer.addChild(spriteA)
                componentA.sprite = spriteA
                
                let newPositionA = pointForColumn(component2.column, row: component2.row)
                let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                moveActionA.timingMode = .EaseOut
                spriteA.alpha = 0
                spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                
                let componentBType = ComponentType.Noncompetitive_Inhibitor
                let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                spriteB.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(spriteB)
                componentB.sprite = spriteB
                
                let newPositionB = pointForColumn(component1.column, row: component1.row)
                let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                moveActionB.timingMode = .EaseOut
                spriteB.alpha = 0
                spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                
                let componentCType = ComponentType.Substrate
                let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                componentsLayer.addChild(spriteC)
                componentC.sprite = spriteC
                
                let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                moveActionC.timingMode = .EaseOut
                spriteC.alpha = 0
                spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                }
                
                else {
                self.revert(component1, component2: component2)
                }
                }
                }*/
                
            }
            
            if component2.componentType == ComponentType.Activator {
                let newcomponentType = ComponentType.Enzyme_with_one_activator
                let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
                
                let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
                sprite.position = pointForColumn(component1.column, row: component1.row)
                componentsLayer.addChild(sprite)
                newcomponent.sprite = sprite
                
                let newPosition = pointForColumn(component1.column, row: component1.row)
                let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                moveAction.timingMode = .EaseOut
                sprite.alpha = 0
                sprite.runAction(SKAction.sequence([SKAction.fadeInWithDuration(time), moveAction]))
                
                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                sprite.runAction(SKAction.sequence([SKAction.waitForDuration(delay, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                    withKey:"removing")
                
                if newcomponent.column != NumColumns - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column + 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                            
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                if newcomponent.column != 0 {
                    
                    if let othercomponent = level.componentAtColumn(newcomponent.column - 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                if newcomponent.row != NumRows - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row + 1) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                if newcomponent.row != 0 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row - 1) {
                        if othercomponent.componentType == ComponentType.Substrate {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_one_activator_and_substrate
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            let componentAType = ComponentType.Enzyme
                            let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                            let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                            spriteA.position = pointForColumn(component2.column, row: component2.row)
                            componentsLayer.addChild(spriteA)
                            componentA.sprite = spriteA
                            
                            let newPositionA = pointForColumn(component2.column, row: component2.row)
                            let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                            moveActionA.timingMode = .EaseOut
                            spriteA.alpha = 0
                            spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                            
                            let componentBType = ComponentType.Activator
                            let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                            let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                            spriteB.position = pointForColumn(component1.column, row: component1.row)
                            componentsLayer.addChild(spriteB)
                            componentB.sprite = spriteB
                            
                            let newPositionB = pointForColumn(component1.column, row: component1.row)
                            let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                            moveActionB.timingMode = .EaseOut
                            spriteB.alpha = 0
                            spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                            
                            let componentCType = ComponentType.Substrate
                            let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                            let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                            spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                            componentsLayer.addChild(spriteC)
                            componentC.sprite = spriteC
                            
                            let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                            let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                            moveActionC.timingMode = .EaseOut
                            spriteC.alpha = 0
                            spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                        }
                            
                        else {
                            self.revert(component1, component2: component2)
                        }
                    }
                }
                
                
                
                
                
                if newcomponent.column != NumColumns - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column + 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            if newcomponent2.column != NumColumns - 1 {
                                if let othercomponent2 = level.componentAtColumn(newcomponent2.column + 1, row: newcomponent2.row) {
                                    if othercomponent2.componentType == ComponentType.Substrate {
                                        if let sprite = newcomponent2.sprite {
                                            //if sprite.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        if let sprite2 = othercomponent2.sprite {
                                            //if sprite2.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                        let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                        let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                        sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(sprite)
                                        newcomponent3.sprite = sprite
                                        
                                        let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                        moveAction.timingMode = .EaseOut
                                        sprite.alpha = 0
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                        
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                        
                                        let componentDType = ComponentType.Substrate
                                        let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                        let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                        spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        componentsLayer.addChild(spriteD)
                                        componentD.sprite = spriteD
                                        
                                        let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                        moveActionD.timingMode = .EaseOut
                                        spriteD.alpha = 0
                                        spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                    }
                                        
                                    else {
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                    }
                                }
                                    
                                else {
                                    self.revert(component1, component2: component2)
                                }
                            }
                        }
                    }
                }
                
                
                if newcomponent.column != 0 {
                    
                    if let othercomponent = level.componentAtColumn(newcomponent.column - 1, row: newcomponent.row) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            if newcomponent2.column != 0 {
                                if let othercomponent2 = level.componentAtColumn(newcomponent2.column - 1, row: newcomponent2.row) {
                                    if othercomponent2.componentType == ComponentType.Substrate {
                                        if let sprite = newcomponent2.sprite {
                                            //if sprite.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        if let sprite2 = othercomponent2.sprite {
                                            //if sprite2.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                        let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                        let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                        sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(sprite)
                                        newcomponent3.sprite = sprite
                                        
                                        let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                        moveAction.timingMode = .EaseOut
                                        sprite.alpha = 0
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                        
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                        
                                        let componentDType = ComponentType.Substrate
                                        let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                        let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                        spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        componentsLayer.addChild(spriteD)
                                        componentD.sprite = spriteD
                                        
                                        let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                        moveActionD.timingMode = .EaseOut
                                        spriteD.alpha = 0
                                        spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                    }
                                        
                                    else {
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                    }
                                }
                                    
                                else {
                                    self.revert(component1, component2: component2)
                                }
                            }
                        }
                    }
                }
                
                
                if newcomponent.row != NumRows - 1 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row + 1) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            
                            if newcomponent2.row != NumRows - 1 {
                                if let othercomponent2 = level.componentAtColumn(newcomponent2.column, row: newcomponent2.row + 1) {
                                    if othercomponent2.componentType == ComponentType.Substrate {
                                        if let sprite = newcomponent2.sprite {
                                            //if sprite.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        if let sprite2 = othercomponent2.sprite {
                                            //if sprite2.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                        let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                        let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                        sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(sprite)
                                        newcomponent3.sprite = sprite
                                        
                                        let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                        moveAction.timingMode = .EaseOut
                                        sprite.alpha = 0
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                        
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                        
                                        let componentDType = ComponentType.Substrate
                                        let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                        let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                        spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        componentsLayer.addChild(spriteD)
                                        componentD.sprite = spriteD
                                        
                                        let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                        moveActionD.timingMode = .EaseOut
                                        spriteD.alpha = 0
                                        spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                    }
                                        
                                    else {
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                    }
                                }
                                    
                                else {
                                    self.revert(component1, component2: component2)
                                }
                            }
                        }
                    }
                }
                
                
                if newcomponent.row != 0 {
                    if let othercomponent = level.componentAtColumn(newcomponent.column, row: newcomponent.row - 1) {
                        if othercomponent.componentType == ComponentType.Activator {
                            if let sprite = newcomponent.sprite {
                                //if sprite.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            
                            if let sprite2 = othercomponent.sprite {
                                //if sprite2.actionForKey("removing") == nil {
                                let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                scaleAction.timingMode = .EaseOut
                                sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                    withKey:"removing")
                                //}
                            }
                            let newcomponentType2 = ComponentType.Enzyme_with_two_activators
                            let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: newcomponentType2)
                            let sprite = SKSpriteNode(imageNamed: newcomponent2.componentType.spriteName)
                            sprite.position = pointForColumn(newcomponent.column, row: newcomponent.row)
                            componentsLayer.addChild(sprite)
                            newcomponent2.sprite = sprite
                            
                            let newPosition = pointForColumn(newcomponent.column, row: newcomponent.row)
                            let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                            moveAction.timingMode = .EaseOut
                            sprite.alpha = 0
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                            
                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                            sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                withKey:"removing")
                            
                            if newcomponent2.row != 0 {
                                if let othercomponent2 = level.componentAtColumn(newcomponent2.column, row: newcomponent2.row - 1) {
                                    if othercomponent2.componentType == ComponentType.Substrate {
                                        if let sprite = newcomponent2.sprite {
                                            //if sprite.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        if let sprite2 = othercomponent2.sprite {
                                            //if sprite2.actionForKey("removing") == nil {
                                            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                            scaleAction.timingMode = .EaseOut
                                            sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                                withKey:"removing")
                                            //}
                                        }
                                        
                                        let newcomponentType3 = ComponentType.Enzyme_with_2_activators_and_substrate
                                        let newcomponent3 = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: newcomponentType3)
                                        let sprite = SKSpriteNode(imageNamed: newcomponent3.componentType.spriteName)
                                        sprite.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(sprite)
                                        newcomponent3.sprite = sprite
                                        
                                        let newPosition = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
                                        moveAction.timingMode = .EaseOut
                                        sprite.alpha = 0
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
                                        
                                        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                                        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(0.25, withRange: 5), scaleAction, SKAction.removeFromParent()]),
                                            withKey:"removing")
                                        
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: newcomponent2.column, row: newcomponent2.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(newcomponent2.column, row: newcomponent2.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                        
                                        let componentDType = ComponentType.Substrate
                                        let componentD = Component(column: othercomponent2.column, row: othercomponent2.row, componentType: componentDType)
                                        let spriteD = SKSpriteNode(imageNamed: componentD.componentType.spriteName)
                                        spriteD.position = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        componentsLayer.addChild(spriteD)
                                        componentD.sprite = spriteD
                                        
                                        let newPositionD = pointForColumn(othercomponent2.column, row: othercomponent2.row)
                                        let moveActionD = SKAction.moveTo(newPositionD, duration: 0.3)
                                        moveActionD.timingMode = .EaseOut
                                        spriteD.alpha = 0
                                        spriteD.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionD])]))
                                    }
                                        
                                    else {
                                        
                                        let componentAType = ComponentType.Enzyme
                                        let componentA = Component(column: component2.column, row: component2.row, componentType: componentAType)
                                        let spriteA = SKSpriteNode(imageNamed: componentA.componentType.spriteName)
                                        spriteA.position = pointForColumn(component2.column, row: component2.row)
                                        componentsLayer.addChild(spriteA)
                                        componentA.sprite = spriteA
                                        
                                        let newPositionA = pointForColumn(component2.column, row: component2.row)
                                        let moveActionA = SKAction.moveTo(newPositionA, duration: 0.3)
                                        moveActionA.timingMode = .EaseOut
                                        spriteA.alpha = 0
                                        spriteA.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionA])]))
                                        
                                        let componentBType = ComponentType.Activator
                                        let componentB = Component(column: component1.column, row: component1.row, componentType: componentBType)
                                        let spriteB = SKSpriteNode(imageNamed: componentB.componentType.spriteName)
                                        spriteB.position = pointForColumn(component1.column, row: component1.row)
                                        componentsLayer.addChild(spriteB)
                                        componentB.sprite = spriteB
                                        
                                        let newPositionB = pointForColumn(component1.column, row: component1.row)
                                        let moveActionB = SKAction.moveTo(newPositionB, duration: 0.3)
                                        moveActionB.timingMode = .EaseOut
                                        spriteB.alpha = 0
                                        spriteB.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionB])]))
                                        
                                        let componentCType = ComponentType.Activator
                                        let componentC = Component(column: othercomponent.column, row: othercomponent.row, componentType: componentCType)
                                        let spriteC = SKSpriteNode(imageNamed: componentC.componentType.spriteName)
                                        spriteC.position = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        componentsLayer.addChild(spriteC)
                                        componentC.sprite = spriteC
                                        
                                        let newPositionC = pointForColumn(othercomponent.column, row: othercomponent.row)
                                        let moveActionC = SKAction.moveTo(newPositionC, duration: 0.3)
                                        moveActionC.timingMode = .EaseOut
                                        spriteC.alpha = 0
                                        spriteC.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.group([SKAction.fadeInWithDuration(0.25), moveActionC])]))
                                    }
                                }
                                    
                                else {
                                    self.revert(component1, component2: component2)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    
    func animateSwap(swap: Swap, completion: () -> ()) {
      //  let spriteA = swap.componentA.sprite!
        if let spriteA = swap.componentA.sprite {

        let spriteB = swap.componentB.sprite!
        
        spriteA.zPosition = 90
        spriteB.zPosition = 100
        
        let Duration: NSTimeInterval = 1.5
        
        let moveA = SKAction.moveTo(spriteB.position, duration: Duration)
        moveA.timingMode = .EaseOut
        spriteA.runAction(moveA, completion: completion)
        
        let moveB = SKAction.moveTo(spriteA.position, duration: Duration)
        moveB.timingMode = .EaseOut
        spriteB.runAction(moveB)
    }
    }

    
    func revert3(component1: Component, component2: Component, columns:[[Component]]) {
        for array in columns {
            for (idx, component) in array.enumerate() {
        if component1.componentType == ComponentType.Enzyme {
            if component2.componentType == ComponentType.Substrate {
                components2(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Product)
            }
            
            if component2.componentType == ComponentType.Competitive_Inhibitor{
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Competitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Deactivator {
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Deactivator)
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Noncompetitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Activator {
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Activator)
            }
                }
            
            }
        }
    }


    
    func components2(component1: Component, component2: Component, componentType: ComponentType, newcomponentType: ComponentType) {
        let component = Component(column: component2.column, row: component2.row, componentType: componentType)
        let sprite1 = SKSpriteNode(imageNamed: component1.componentType.spriteName)
        sprite1.position = pointForColumn(component2.column, row: component2.row)
        componentsLayer.addChild(sprite1)
        component1.sprite = sprite1
        
        let newPosition1 = pointForColumn(component2.column, row: component2.row)
        let moveAction1 = SKAction.moveTo(newPosition1, duration: 0.3)
        moveAction1.timingMode = .EaseOut
        sprite1.alpha = 0
        sprite1.runAction(SKAction.sequence([SKAction.waitForDuration(6), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction1])]))
        
        print("enzyme: \(component.column, component.row)")
        
        let newcomponent = Component(column: component1.column, row: component1.row, componentType: newcomponentType)
        let sprite2 = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite2.position = pointForColumn(component1.column, row: component1.row)
        componentsLayer.addChild(sprite2)
        newcomponent.sprite = sprite2
        
        let newPosition2 = pointForColumn(component1.column, row: component1.row)
        let moveAction2 = SKAction.moveTo(newPosition2, duration: 0.3)
        moveAction2.timingMode = .EaseOut
        sprite2.alpha = 0
        sprite2.runAction(SKAction.sequence([SKAction.waitForDuration(6), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction2])]))
        
        print("newcomponent: \(newcomponent.column, newcomponent.row)")
        
    }
    
    func trySwapHorizontal3(horzDelta: Int, vertical vertDelta: Int) {
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta
        
        if toColumn < 0 || toColumn >= NumColumns { return }
        if toRow < 0 || toRow >= NumRows {return}
        
        let type = ComponentType.Enzyme
        if let toComponent = level.componentAtColumn(toColumn, row: toRow) {
            if let fromComponent = level.componentAtColumn(swipeFromColumn!, row: swipeFromRow!) {
                
                if fromComponent.componentType == type && toComponent.componentType != type {
                    print("fromComponent: \(fromComponent.componentType, fromComponent.column, fromComponent.row )")
                    print("toComponent: \(toComponent.componentType, toComponent.column, toComponent.row)")
                    
                    if let handler = swipeHandler {
                        let swap = Swap(componentA: fromComponent, componentB: toComponent)
                        handler(swap)
                        
                        print("afterswapfromComponent: \(fromComponent.componentType, fromComponent.column, fromComponent.row )")
                        print("afterswaptoComponent: \(toComponent.componentType, toComponent.column, toComponent.row)")

                        level.removepieces(fromComponent, component2: toComponent)
                        self.removecomponents(fromComponent, component2: toComponent)
                        self.combinedcomponent(fromComponent, component2: toComponent)
                    }
                }
            }
        }
    }

    func componentsprite(component: Component, componentType: ComponentType) {
        let newcomponent = Component(column: component.column, row: component.row, componentType: componentType)
        let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite.position = pointForColumn(component.column, row: component.row)
        componentsLayer.addChild(sprite)
        component.sprite = sprite
        
        let newPosition = pointForColumn(component.column, row: component.row)
        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
        moveAction.timingMode = .EaseOut
        sprite.alpha = 0
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(7), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
    }
}




