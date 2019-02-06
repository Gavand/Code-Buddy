//
//  PostViewController.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 6/20/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class PostViewController: UIViewController {
    @IBOutlet weak var titletext: UITextView!
    @IBOutlet weak var bodytext: UITextView!
    @IBOutlet weak var postbutton: UIButton!
    
    var ref: DatabaseReference!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ref = Database.database().reference()
        
//        let tapGesture
        
//        let mainStoryboard = UIStoryboard(name: "Post", bundle: nil)
//        _ = mainStoryboard.instantiateViewController(withIdentifier: "userVC") as! PostViewController
        
//        presentViewController(userVC, animated: true, completion: nil)
        

        

//        view.backgroundColor = UIColor.yellow
        
    }
    
    @IBAction func postbutton_TouchUpInside(_ sender: Any) {
        ProgressHUD.show("Waiting...", interaction: false)
        self.sendDataToDatabase()
        
        
    }
    
    func sendDataToDatabase(){
        let ref = Database.database().reference()
        let postsRef = ref.child("posts")
        let newPostId = postsRef.childByAutoId().key
        let newPostRef = postsRef.child(newPostId!)
        newPostRef.setValue(["title": titletext.text!, "body": bodytext.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
        })
    }
}

    
////
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


