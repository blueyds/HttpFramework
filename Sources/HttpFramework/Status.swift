import Foundation

public struct HTTPStatus: Hashable {
    public static let ok = HTTPStatus(rawValue: 200)
    public static let badRequest = HTTPStatus(rawValue: 400)
    public static let unauthorized = HTTPStatus(rawValue: 401)
    public let rawValue: Int
}
