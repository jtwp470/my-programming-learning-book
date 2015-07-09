//
//  ViewController.swift
//  MyMemoApp
//
//  Created by jtwp470 on 7/16/15.
//  Copyright (c) 2015 jtwp470. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var defaultTextViewHeight: CGFloat = 0.0  // キーボードの高さを保存するプロパティ
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // ビューのロードが終わったら呼び出される
        loadFile()
        
        // システム標準の通知センターを取得
        var notificationCenter = NSNotificationCenter.defaultCenter()
        
        // キーボードが表示されたらkeyboardDidShow()を実行
        notificationCenter.addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        // キーボードが隠れたらkeyboardDidHideメソッドを実行
        notificationCenter.addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        var textFrame = myTextView.frame // テキストビューの初期サイズを取得
        defaultTextViewHeight = textFrame.size.height  // 高さの初期値を保存
    }

    @IBOutlet weak var myTextView: UITextView!
    
    // ファイルに保存するメソッド
    func saveFile() {
        // Documentsのディレクトリパス
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        // 保存先のパスを設定
        let filePath = paths[0].stringByAppendingPathComponent("memo.txt")
        // テキストビューの内容を取り出す
        let string = myTextView.text
        // ファイルに保存する
        string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    func loadFile() {
        // Documentsのディレクトリパス
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        // ロードするパスを設定
        let filePath = paths[0].stringByAppendingPathComponent("memo.txt")
        
        var fileManager = NSFileManager.defaultManager()
        
        // ファイルが存在していればロード
        if fileManager.fileExistsAtPath(filePath) {
            let text = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)
            myTextView.text = text
        }
    }
    
    func keyboardDidShow (notification: NSNotification) {
        // 通知情報を取り出す
        var info = notification.userInfo! as Dictionary
        // キーボードのサイズを取得する
        var bValue = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
        var kbFrame = bValue.CGRectValue()
        
        // テキストビューの高さをキーボードのサイズ分縮小する
        myTextView.frame.size.height = defaultTextViewHeight - kbFrame.size.height
    }
    
    func keyboardDidHide (notification: NSNotification) {
        // テキストビューの高さを元に戻す
        myTextView.frame.size.height = defaultTextViewHeight
    }
    @IBAction func done(sender: AnyObject) {
        view.endEditing(true) // キーボードを隠す
        saveFile()  // テキストを保存
    }
}

