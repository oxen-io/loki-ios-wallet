import Foundation
import LokiWalletLib
import LWLoki

var gateways: [WalletGateway.Type] {
    return [LokiWalletGateway.self]
}
// fixme!
func getGateway(for type: WalletType) -> WalletGateway {
    var _gateway: WalletGateway.Type?
    
    gateways.forEach {
        if $0.type == type {
            _gateway = $0
        }
    }
    
    let gateway = _gateway ?? LokiWalletGateway.self // FIX-ME: Hardcoded default value
    return gateway.init()
}
