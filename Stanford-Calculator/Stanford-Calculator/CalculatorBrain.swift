//
//  CalculatorBrain.swift
//  Stanford-Calculator
//
//  Created by 김동욱 on 25/03/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import Foundation

// closure : 환경 상태를 캡쳐하는 인라인 함수
// 인라인 함수 : 함수호출없이 그 위치에서 바로 실행되는 함수

class CalculatorBrain
{
    //    accumulator : 계속 더해지는 값
    private var accumulator = 0.0

    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI), //M_PI,
        "e" : Operation.Constant(M_E), //M_E
        "√" : Operation.UnaryOperation(sqrt), // sqrt
        "cos" : Operation.UnaryOperation(cos), //cos
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]

    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double) //단항연산
        case BinaryOperation((Double, Double) -> Double) //이항연산
        case Equals
        
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedConstantValue):
                accumulator = associatedConstantValue
            case .UnaryOperation(let associatedFunction):
                accumulator = associatedFunction(accumulator)
            case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
                
            }
        }
    }
    
    private func executePendingBinaryOperation() {  //(대기중인 이항연산 실행)
        
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    //Struct와 class는 거의 같다
    //struct은 enum처럼 값으로 전달, class는 참조영역으로 전달
    //Swift는 아주 똑똑해서, 무언가를 전달했는데 값을 바꾸려고 건들지 않았다면 복사를 하지 않고 공유를 하고 있을거야.
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    var result: Double{
        get {
            return accumulator
        }
    }
}
