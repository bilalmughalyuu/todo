import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    
    init() {
        
    }
    
    private var db = Firestore.firestore()
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users")
            .document(userId)
            .getDocument{ [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.user = UserModel(
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0
                    )
                }
            }
    }
       
    
    func clearUserData() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
}
