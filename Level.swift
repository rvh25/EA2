//
//  Level.swift
//  EnzymeApp
//
//  Created by admin on 2/23/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

import Foundation

let NumColumns = 10
let NumRows = 10

class Level {
    private var components = Array2D<Component>(columns: NumColumns, rows: NumRows)

    func componentAtColumn(column: Int, row: Int) -> Component? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return components[column, row]
    }

    func shuffle() -> Set<Component> {
        //return createInitialComponents()
        var set: Set <Component>
        repeat {
            set = createInitialComponents()
            detectPossibleSwaps()
            //print("possible swaps: \(possibleSwaps)")
        }
        while possibleSwaps.count == 0
        return set
    }

    private func createInitialComponents() -> Set<Component> {
        var set = Set<Component>()
    
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
            
                var componentType: ComponentType
                repeat {
                componentType = ComponentType.random()
                }
                while (column >= 1 &&
                        components[column - 1, row]?.componentType == componentType)
                    || (row >= 1 &&
                        components[column, row - 1]?.componentType == componentType)

                let component = Component(column: column, row: row, componentType: componentType)
                components[column, row] = component
            
                set.insert(component)
            }
        }
        return set
    }
    
    func performSwap(swap: Swap) {
        let columnA = swap.componentA.column
        let rowA = swap.componentA.row
        let columnB = swap.componentB.column
        let rowB = swap.componentB.row
        
        components[columnA, rowA] = swap.componentB
        swap.componentB.column = columnA
        swap.componentB.row = rowA

        components[columnB, rowB] = swap.componentA
        swap.componentA.column = columnB
        swap.componentA.row = rowB
    }
    
    private var possibleSwaps = Set<Swap>()
    
    private func hasRxn(component1: Component, component2: Component) -> Bool {
        let type = ComponentType.Enzyme
        if (component2.componentType != ComponentType.Product && component1.componentType == type && component2.componentType != type) || (component1.componentType != ComponentType.Product && component1.componentType != type && component2.componentType == type) {
            return true
        }
        return false
    }
    
    func detectPossibleSwaps() {
        var set = Set<Swap>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = components[column, row] {
                    if column < NumColumns - 1 {
                        if let other = components[column + 1, row] {
                            if hasRxn(component, component2: other) {
                                set.insert(Swap(componentA: component, componentB: other))
                            }
                        }
                    }
                    
                    if row < NumRows - 1 {
                        if let other = components[column, row + 1] {
                            if hasRxn(component, component2: other) {
                                set.insert(Swap(componentA: component, componentB: other))
                            }
                        }
                    }
                }
            }
        }
        possibleSwaps = set
        print("possible swaps: \(possibleSwaps)")
    }
    
    func checkswaps() -> Bool {
        if possibleSwaps.isEmpty    {
            return true
        }
        return false
    }
    
    func isPossibleSwap(swap: Swap) -> Bool {
        return possibleSwaps.contains(swap)
    }

    func components(component1:Component, component2: Component) -> [[Component]]{
        var columns = [[Component]]()
            var array = [Component]()
                if component1.componentType == ComponentType.Enzyme {
                    let component = Component(column: component2.column, row: component2.row, componentType: component1.componentType)
                    components[component.column, component.row] = component
                    array.append(component)
                }
        
                if !array.isEmpty {
                    columns.append(array)
                }
        return columns
    }
    
    func removepieces(component1: Component, component2: Component) {
        components[component1.column, component1.row] = nil
        components[component2.column, component2.row] = nil
        
    }
    
    private var substrates = Set<Component>()

    func substrateComponents() {
        var set = Set<Component>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = components[column, row] {
                    if component.componentType == ComponentType.Substrate {
                        set.insert(component)
                    }
                }
            }
        }
        substrates = set
        print("substrates: \(substrates)")
    }
    
    private var others = Set<Component>()
    
    func otherComponents() {
        var set = Set<Component>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = components[column, row] {
                    if component.componentType != ComponentType.Enzyme && component.componentType != ComponentType.Product {
                        set.insert(component)
                    }
                }
            }
        }
        others = set
        print("other: \(others)")
    }
    
    private var enzymes = Set<Component>()
    
    func locateenzymes() {
        var set = Set<Component>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = components[column, row] {
                    if component.componentType == ComponentType.Enzyme  {
                        set.insert(component)
                    }
                }
            }
        }
        enzymes = set
        print("enzymes: \(enzymes)")
    }
    
    func locateotherrxns() {
        var set = Set<Swap>()
        for component in others {
            if component.row == 0 && component.column == 0 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
            
            if component.row == NumRows - 1 && component.column == NumColumns - 1 {
                let enzyme1 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
            
            
            if component.row == 0 && component.column == NumColumns - 1 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
            
            if component.row == NumRows - 1 && component.column == 0 {
                let enzyme1 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
                
            else if component.row == 0  && component.column != NumColumns - 1 && component.column != 0 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            else if component.row == NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                let enzyme1 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            else if component.column == 0 && component.row != 0 && component.row != NumRows - 1 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column , row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            else if component.column == NumColumns - 1 && component.row != 0 && component.row != NumRows - 1 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            //else if component.row != 0 && component.row != NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
            else {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
                
                let enzyme4 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme4, componentB: component))
            }
        }
        possibleSwaps = set
        print("possibleswaps: \(possibleSwaps)")
    }
    
    
    func locaterxns() {
        var set = Set<Swap>()
        for component in substrates {
            if component.row == 0 && component.column == 0 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
            
            if component.row == NumRows - 1 && component.column == NumColumns - 1 {
                let enzyme1 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
            
            
            if component.row == 0 && component.column == NumColumns - 1 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
            
            if component.row == NumRows - 1 && component.column == 0 {
                let enzyme1 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
            }
                
            else if component.row == 0  && component.column != NumColumns - 1 && component.column != 0 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            else if component.row == NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
                let enzyme1 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            else if component.column == 0 && component.row != 0 && component.row != NumRows - 1 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column , row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            else if component.column == NumColumns - 1 && component.row != 0 && component.row != NumRows - 1 {
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
            }
                
            //else if component.row != 0 && component.row != NumRows - 1 && component.column != 0 && component.column != NumColumns - 1 {
            else {
                
                let enzyme1 = Component(column: component.column, row: component.row + 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme1, componentB: component))
                
                let enzyme2 = Component(column: component.column + 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme2, componentB: component))
                
                let enzyme3 = Component(column: component.column, row: component.row - 1, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme3, componentB: component))
                
                let enzyme4 = Component(column: component.column - 1, row: component.row, componentType: ComponentType.Enzyme)
                set.insert(Swap(componentA: enzyme4, componentB: component))
            }
        }
        possibleSwaps = set
        print("possibleswaps: \(possibleSwaps)")
    }
    
}