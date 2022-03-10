//
//  CredentialServerice.swift
//  iGs
//
//  Created by Hattapong on 20/1/2564 BE.
//

import Foundation


class CredentialServerice: NSObject {
    
    let server:String
    
    init(server:String) {
        self.server = server
    }
    
    func getCredentials()-> Credentials? {
        
        let query: [String:Any] = [kSecClass as String: kSecClassInternetPassword,
                    kSecAttrServer as String: server,
                    kSecMatchLimit as String: kSecMatchLimitOne,
                    kSecReturnAttributes as String: true,
                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else { return nil }
        
        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existingItem[kSecAttrAccount as String] as? String
        else {
            print(KeychainError.unexpectedPasswordData.localizedDescription)
            return nil
        }
        
        return Credentials(username: account, password: password)
    }
    
    func saveCredentials(username:String, password:String) {
        let credentials = Credentials(username: username, password: password)
        let account = credentials.username
        let password = credentials.password.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print(KeychainError.unhandledError(status: status).localizedDescription)
        }
    }
    
    func clearCredentials(){
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                                kSecAttrServer as String: server]
        let status = SecItemDelete(query as CFDictionary)
       
        guard status == errSecSuccess || status == errSecItemNotFound else {  print(KeychainError.unhandledError(status: status).localizedDescription)
            return
        }
    }
}
