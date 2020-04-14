import Foundation

public struct SignInWithAppleEnvelope: Decodable {
  public let signInWithApple: SignInWithApple

  public struct SignInWithApple: Decodable {
    public let apiAccessToken: String
    public let user: SignInWithAppleEnvelope.User
  }

  public struct User: Decodable {
    public let uid: String
  }
}
