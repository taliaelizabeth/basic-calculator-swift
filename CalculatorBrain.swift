//
//  CalculatorBrain.swift
//  Calc
//
//  Created by Talia Quartetti on 7/6/16.
//  Copyright © 2016 Talia Quartetti. All rights reserved.
//

import Foundation

class calculatorBrain {
    
    private var accumulator = 0.0
    
    private var internalProgram = [AnyObject]()
    
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand)
    }
    
    //leave this empty for now?
    var variablesDict = [String : Double]()
    
    
    func setOperand(variableName: String?) {
        internalProgram.append(variablesDict[variableName!]!)
        accumulator = variablesDict[variableName!]!
            }
        }
    
    private var operations = [String:Operation]()
    
    enum Operation {
        case Constant(Double)
        case Binary((Double, Double)-> Double)
        case Unary((Double)->Double)
        case Equals
        case Operand(Double)
        case Variable(String)
        
        var description: String {
            switch self {
            case .Operand(let operand):
                return "\(operand)"
            case .Variable(let symbol):
                return symbol
            case .Constant(let symbol):
                return String(symbol)
            case .Unary(let symbol):
                return String(symbol)
            case .Binary(let symbol):
                return String(symbol)
        }
        }
    }
    
    var operations : Dictionary<String,Operation> = [
        "×" = Operation.Binary({$0 * $1}),
        "÷" = Operation.Binary({ $0 / $1 }),
        "+" = Operation.Binary({$0 + $1}),
        "-" = Operation.Binary({ $0 - $1 }),
        "√" = Operation.Unary(sqrt),
        "sin" = Operation.Unary(sin),
        "cos" = Operation.Unary(cos),
        "π" = Operation.Constant(M_PI),
        "=" = Operation.Equals
        ]
    
    // this needs to include ability to use the stored value corresponding to a variable while performing operations
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            internalProgram.append(symbol)
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .Binary(let function) :
                executePendingBinaryOperation()
                pending = pendingBinaryInfo(binaryFunciton: function, firstOperand: accumulator)
            case .Unary(let function) :
                accumulator = function(accumulator)
            case .Equals :
                executePendingBinaryOperation()
            }
        }
    }
    
    // should be fine?
    func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunciton(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    //for binary operations
    var pending : pendingBinaryInfo?

    struct pendingBinaryInfo {
        var binaryFunciton : (Double, Double) -> Double
        var firstOperand : Double
    }

    // Sets type of PropertyList to AnyObject
    typealias PropertyList = AnyObject
    
    //Currently the memory situation- stores last result for when restore is pressed
    var program: PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand)
                    } else if let operation = op as? String {
                        performOperation(operation)
                    }
                }
            }
        }
        }


    func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    //This is sent to bottom label
    var result: Double {
        get {
            return accumulator
        }
    }
}






