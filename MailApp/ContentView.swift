//
//  ContentView.swift
//  MailApp
//
//  Created by Kiernan Almand on 4/2/22.
//

import SwiftUI

struct Mailbox {
    let name: String
    var emails: Int = Email.allInboxes().count
    var systemName = "tray.2"
    var emailList: [Email] = Email.allInboxes()
    
    
}

struct ContentView: View {
    @State var newMessage: Bool = false
    @State private var inboxes: [Mailbox] = []
    var body: some View {
        
        NavigationView {
            VStack{
                Group{
                    List{
                        // foreach over inboxes
                        mailbox(name: "All Inboxes", emails: Email.allInboxes().count, systemName: "tray.2", emailList: Email.allInboxes()) 
                        mailbox(name: "Gmail", emails: Email.gmail().count, emailList: Email.gmail())
                        mailbox(name: "UNC Email", emails: Email.unc().count, emailList: Email.unc())
                        mailbox(name: "VIP", emails: Email.VIP().count, systemName: "star", emailList: Email.VIP()) 
                        mailbox(name: "Flag", emails: Email.Flagged().count, systemName: "flag", emailList: Email.Flagged())
                    }
                }
            }
            .navigationTitle("Mailboxes")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Button {
                            newMessage.toggle()
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $newMessage){
                            newEmail(newMessage: $newMessage)
                        }
                    }
                }
            }
        }
    }
}

struct mailbox: View {
    var name: String
    var emails: Int = Email.getExample2().count
    var systemName: String = "tray"
    @State var emailList: [Email]
    var body: some View{
        NavigationLink(destination: InboxView(emailList: emailList)) {
            HStack{
                Image(systemName: systemName)
                    .foregroundColor(.blue)
                Text(name)
                    .fontWeight(.semibold)
                Spacer()
                if emails > 0 {
                    Text(String(emails))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct InboxView: View {
    @State var search = ""
    var emailList: [Email]
    
    var body: some View {
        searchBar(search: $search)
            List{
                ForEach(emailList) { email in
                    NavigationLink(destination: EmailView(email: email)){
                
                        HStack{
                        VStack{
                            readOrNot(email: email)
                            Spacer()
                            }
                        VStack{
                            HStack{
                                Text(email.sender)
                                    .fontWeight(.bold)
                                Image("circle.fill")
                                    .foregroundColor(.blue)
                                Spacer()
                                Text(email.time)
                                        .foregroundColor(.gray)
                            }
                            HStack{
                                Text(email.title)
                                Spacer()
                            }
                            HStack{
                                Text(email.content)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
            .listStyle(InsetListStyle())
        .navigationTitle("Inbox")
    }
}

struct readOrNot: View{
    var email: Email
    var body: some View{
        if email.notRead{
            Circle()
                .foregroundColor(.blue)
                .frame(width: 12, height: 12)
                .padding(.top, 4)
        }
    }
}

struct EmailView: View {
    var email: Email
    var body: some View{
        VStack{
            Text(email.content)
        }
        .navigationTitle(email.title)
    }
}

struct newEmail: View {
    var title: String = "New Message"
    @State private var to: String = ""
    @Binding var newMessage: Bool
    
    @State private var subject: String = ""
    @State private var isSubject: Bool = false
    @State private var content: String = ""
    
    @State var selectedAccount: String = "Gmail"
    let accountList: [String] = ["Gmail", "UNC"]
    
    func toggleSubject(){
        if subject.count > 0{
            isSubject.toggle()
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
            List{
                HStack{
                    Text("To:")
                        .foregroundColor(.gray)
            
                    TextField("", text: $to)
                        .foregroundColor(.gray)
                    }
                
              /*  HStack{
                    Button(selectedAccount){
                        
                        }
                    }
               */
               /*     NavigationLink("From: \(selectedAccount)", destination: FromPickerView(selectedAccount: $selectedAccount, accountList: accountList))
                    .foregroundColor(.gray)
                */
                //}
                HStack{
                    Text("Subject:")
                        .foregroundColor(.gray)
                    TextField("", text: $subject)
                        .foregroundColor(.gray)
                    }
                TextField("Text", text: $content)
                    .padding()
                }
            .listStyle(.plain)
            Spacer()
            }
            .navigationTitle(title)
            .navigationBarItems(leading:
                Button{
                newMessage.toggle()
            }label: {
                Text("Cancel")
                    .foregroundColor(.blue)
            })
        }
    }
}

struct FromPickerView: View{
    @Binding var selectedAccount: String
    let accountList: [String]
    var body: some View{
        Picker("From: ", selection: $selectedAccount) {
            ForEach(0..<accountList.count) {
                Text(self.accountList[$0])
            }
        }
    }
}


struct searchBar: View{
    @Binding var search: String
    var body: some View{
        VStack{
            HStack{
                Image(systemName:"magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(8)
                TextField("Search", text: $search)
                    .foregroundColor(.gray)
            }
            .frame(width: 370, height: 40)
            .background(.bar)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

