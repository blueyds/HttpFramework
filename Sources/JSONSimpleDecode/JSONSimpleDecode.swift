import Foundation

public protocol JSONSimpleDecode{
    func decode<T: Decodable>(from data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy, keyDecodingStrategy : JSONDecoder.KeyDecodingStrategy) -> T
}

extension JSONSimpleDecode{
    public func decode<T: Decodable>(from data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy : JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        do{    
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context){
            fatalError("Failed to decode due to missing key '\(key.stringValue)' not found 0 \(context.debugDescription)---\(context.codingPath)")
        } catch DecodingError.typeMismatch(_, let context){
            fatalError("Failed to decode due to type mismatch - \(context.debugDescription)")
        }catch DecodingError.valueNotFound(let type, let context){
            fatalError("Failed to decode due to missing \(type) value - \(context.debugDescription)")
        }catch DecodingError.dataCorrupted(_){
            fatalError("Failed to decode because it appears to be invalid JSON")
        }catch {
            fatalError("Failed to decode: \(error.localizedDescription)")
        }
        
    }
}


