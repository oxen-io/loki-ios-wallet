import Foundation

let workQueue = DispatchQueue(label: "app.lokiwallet.work-queue", qos: .default, attributes: DispatchQueue.Attributes.concurrent)
let updateQueue = DispatchQueue(label: "app.lokiwallet.update-queue", qos: .background, attributes: DispatchQueue.Attributes.concurrent)
