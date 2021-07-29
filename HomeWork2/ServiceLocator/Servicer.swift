//
//  Servicer.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 29.07.2021.
//

protocol ServicerProtocol {
    func resolve<T>() -> T
    func register<T>(with scope: ServiceScope, factoryClosure: @escaping () -> T)
}

final class Servicer: ServicerProtocol {
    static let shared                   : Servicer                  = Servicer()
    
    private lazy var applicationServices: Dictionary<String, Any>   = [:]
    private lazy var instanceServices   : Dictionary<String, () -> Any>   = [:]

    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    func register<T>(with scope: ServiceScope, factoryClosure: @escaping () -> T) {
        let key = typeName(some: T.self)
        
        applicationServices.removeValue(forKey: key)
        instanceServices.removeValue(forKey: key)
        
        switch scope {
        case .instance:
            instanceServices[key] = factoryClosure
        case .application:
            applicationServices[key] = factoryClosure()
        }
    }

    func resolve<T>() -> T {
        let key = typeName(some: T.self)
        
        if let service = applicationServices[key] as? T {
            return service
        } else if let closure = instanceServices[key] {
            return closure() as! T
        }
        
        fatalError("No registered services found with name: \(key)")
    }
}

enum ServiceScope {
    case application
    case instance
}

@propertyWrapper public struct Resolved<Service> {
    private var service: Service
    public init() {
        self.service = Servicer.shared.resolve()
    }

    public var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }
    
    public var projectedValue: Resolved<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}
