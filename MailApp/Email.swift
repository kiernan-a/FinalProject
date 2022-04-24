//
//  Email.swift
//  MailApp
//
//  Created by Kiernan Almand on 4/7/22.
//

import Foundation

struct Email: Identifiable {
    let id = UUID() // Makes each mail object identifiable for iteration through a For Each loop
    let sender: String
    let title: String
    let content: String
    let time: String
    var notRead: Bool = true
    var isVIP: Bool = false
    var isFlagged: Bool = false
}

extension Email {
    static func allInboxes() -> [Email] {
        let inboxList: [[Email]] = [gmail(), unc()]
        var allMail: [Email] = []
        
        for inbox in inboxList{
            for mail in inbox{
                allMail.append(mail)
            }
        }
        
        return allMail
    }
}

extension Email {
    static func gmail() -> [Email] {
        var out = [Email]()
        var namesList = ["Ananya", "Arvind", "Ciya", "Dhruv", "Enes", "Ethan", "Jonathan", "David", "Lauren", "Mahitha", "Noah", "Sana", "Shaurik", "Will"]
        for person in namesList {
                out.append(Email(sender: person, title: "Hi Kiernan", content: "this is an example email :)", time: "3:34 PM", notRead: true))
      
        }
        return out
    }
}
 

extension Email {
    static func unc() -> [Email] {
        return [Email(sender: "Kevin G", title: "Kiernan", content: "Dear Carolina Community, Kiernan slays.", time: "3:24 PM", isVIP: true)]
    }
}

extension Email {
    static func getExample2() -> [Email] {
        return [Email(sender: "Kiernan", title: "Hi Missy;", content: "this is an example email :(", time: "11:10 PM"), Email(sender: "Missy", title: "hiiii", content: "hell0", time: "11:23 PM")]
    }
}

extension Email {
    static func VIP() -> [Email] {
        var VIPEmails: [Email] = []
        for i in allInboxes(){
            if i.isVIP {
                VIPEmails.append(i)
            }
        }
        return VIPEmails
    }
}

extension Email {
    static func Flagged() -> [Email] {
        var flaggedEmails: [Email] = []
        for i in allInboxes(){
            if i.isFlagged {
                flaggedEmails.append(i)
            }
        }
        return flaggedEmails
    }
}
/*
func toggleNotRead(){
    onTapGesture {
        email.notRead.toggle()
    }
}
*/
