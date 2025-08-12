//
//  RNPasswordless.swift
//  RNPasswordless
//
//  Created by Gabriel Duraye on 12/08/2025.
//

import Foundation
import Passwordless

@objc public class RNPasswordless: NSObject {
  @objc private var client: PasswordlessClient?
  
  // Singleton instance
  @objc public static let shared = RNPasswordless()
  
  // Private initializer to enforce singleton
  @objc private override init() {
    super.init()
  }
  
  @objc public func configure(_ options: NSDictionary) {
    guard let apiKey = options["apiKey"] as? String,
          let rpId = options["rpId"] as? String else { return }
    RNPasswordless.shared.client = PasswordlessClient(config: PasswordlessConfig(apiKey: apiKey, rpId: rpId))
  }
  
  @objc public func register(_ token: String, nickname: String?, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    guard let mClient = RNPasswordless.shared.client else {
      rejecter("not_configured", "PasswordlessClient not configured", nil)
      return
    }
    Task {
      do {
        let verifyToken = try await mClient.register(token: token)
        resolver(["success": true, "result": verifyToken])
      } catch {
        resolver(["success": false, "error": "\(error)"])
      }
    }
  }
  
  @objc public func signIn(_ alias: String?, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    guard let client = RNPasswordless.shared.client else {
      rejecter("not_configured", "PasswordlessClient not configured", nil)
      return
    }
    Task {
      do {
        let token = try await mClient.signIn(alias: alias ?? "")
        resolver(["success": true, "result": token])
      } catch {
        resolver(["success": false, "error": "\(error)"])
      }
    }
  }
  
  @objc public func signInWithAutofill(_ resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    guard let client = RNPasswordless.shared.client else {
      rejecter("not_configured", "PasswordlessClient not configured", nil)
      return
    }
    Task {
      do {
        let token = try await mClient.signInWithAutofill()
        resolver(["success": true, "result": token])
      } catch {
        resolver(["success": false, "error": "\(error)"])
      }
    }
  }
}
