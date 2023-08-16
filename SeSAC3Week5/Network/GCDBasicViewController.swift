//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        serialSync()
        //serialAsync()
        //globalSync()
        //globalAsync()
        //globalAsyncTwo()
    }
    
    func globalAsyncTwo() {
        print("Start")
        
        for i in 1...100 {
            
            DispatchQueue.global().async { //반복문 하나하나를 다른 알바생이
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
        
    }
    
    func globalAsync() {
        print("Start")
        
        DispatchQueue.global().async {
            print(Thread.isMainThread)
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 50...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
        
    }
    
    func globalSync() {
        print("Start")
        
        DispatchQueue.global().sync {
            print(Thread.isMainThread)
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 50...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func serialAsync() {
        print("Start")
        
        DispatchQueue.main.async {
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    
    func serialSync() {
        print("Start")
        
        for i in 1...10 {
            sleep(1)
            print(i, terminator: " ")
        }
        
       
        DispatchQueue.main.sync {
            for i in 101...200 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        print("End")
    }
}
