import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct SignUpView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    private var db = Firestore.firestore()

    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    @State var signUpProcessing = false
    @State var signUpErrorMessage = ""
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            Spacer()
            SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
            Button(action: {
                viewRouter.signUpUser(userEmail: email, userPassword: password, email: email)
            }) {
                Text("Sign Up")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
                .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true)
            if signUpProcessing {
                ProgressView()
            }
            if !signUpErrorMessage.isEmpty {
                Text("Failed creating account: \(signUpErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    viewRouter.currentPage = .signInPage
                }) {
                    Text("Log In")
                }
            }
                .opacity(0.9)
        }
            .padding()
    }
    
//    func signUpUser(userEmail: String, userPassword: String, email:String) {
//        
//        // MARK: - Part of fuction about Authentification
//        signUpProcessing = true
//        
//        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
//            guard error == nil else {
//                signUpErrorMessage = error!.localizedDescription
//                signUpProcessing = false
//                return
//            }
//            switch authResult {
//            case .none:
//                print("Could not create account.")
//                signUpProcessing = false
//            case .some(_):
//                print("User created")
//                signUpProcessing = false
//                viewRouter.currentPage = .homePage
//            }
//            // MARK: - Part of fuction about Firestore
//            let docRef = db.collection("Message").addDocument(data: ["email": email])
//        
//        docRef.setData(["email": email]) { error in
//                if let error = error {
//                    print("Error writing document: \(error)")
//                } else {
//                    print("Document successfully written!")
//                }
//            // MARK: - Part of fuction about Upload image to Firestore
//
//        
//    }
//
//            
//           
//        }
//        
//    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 150)
            .padding(.top, 70)
    }
}

struct SignUpCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
            SecureField("Confirm Password", text: $passwordConfirmation)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
                .padding(.bottom, 30)
        }
    }
}

