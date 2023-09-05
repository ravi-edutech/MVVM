//
// HTTPClient.swift
// MVVM
// Created by Ravi kumar on 28/06/23.
//

import Foundation
import CryptoKit
import CommonCrypto

class HTTPClient: NSObject, HTTPClientProtocol {
    
    private lazy var certificateData :Data = {
        let url = Bundle.main.url(forResource: "dummyjson.com", withExtension: "cer")
        let data = try! Data(contentsOf: url!)
        return data
    }()
    
    private let publicKeyHash = "OUpveBKO8mSJ7HgAb7i5XJszxSA9ZPYsrMnEQjQtFpQ="
    private static let rsa2048Asn1Header:[UInt8] = [
        0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
    ];
    
    func request<T: Codable>(url:String,completion: @escaping (Result<T?, NetworkError>) -> Void) {
        let urlString = Constants.URLConstants.baseURL + url
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badURL))
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForResource = 120
        sessionConfig.timeoutIntervalForRequest = 120
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            do {
                let users = try JSONDecoder().decode(T.self, from: data)
                completion(.success(users))
            } catch {
                return completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    private func sha256(data : Data) -> String {
        var keyWithHeader = Data(HTTPClient.rsa2048Asn1Header)
        keyWithHeader.append(data)
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        keyWithHeader.withUnsafeBytes { buffer in
              _ = CC_SHA256(buffer.baseAddress!, CC_LONG(buffer.count), &hash)
          }
        return Data(hash).base64EncodedString()
    }
    
    private func getServerCertificate(serverTrust:SecTrust) -> SecCertificate {
        var certificate:SecCertificate?
        if #available(iOS 15, *){
            let certificateArray = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate]
            certificate = certificateArray?.first
        }else{
            certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)
        }
        return certificate!
    }
    
    private func compareCertificatePublicKey(serverTrust:SecTrust) -> Bool {
        let certificate = getServerCertificate(serverTrust: serverTrust)
        let serverPublicKey = SecCertificateCopyKey(certificate)
        let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey!, nil)! as Data
        let serverPublicKeyHash = sha256(data: serverPublicKeyData)
        return publicKeyHash == serverPublicKeyHash
    }
    
    private func compareCertificate(serverTrust:SecTrust) -> Bool {
        let certificate = getServerCertificate(serverTrust: serverTrust)
        let data = SecCertificateCopyData(certificate) as Data
        return certificateData == data
    }
}
    
extension HTTPClient :  URLSessionDelegate {
    // SSL Certificate Pinning to prevent Man In The Middle Attack
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let trust = challenge.protectionSpace.serverTrust, compareCertificate(serverTrust: trust) {
//        if let trust = challenge.protectionSpace.serverTrust, compareCertificatePublicKey(serverTrust: trust) {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else{
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
