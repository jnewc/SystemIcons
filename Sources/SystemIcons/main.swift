import Foundation
import Mustache
import Regex

let template = try! Template(path: "./SystemIcons.mustache")

let reservedWords = [ "return", "repeat" ]

let varNameFilter = Filter { (box: MustacheBox) in
    guard let value = box.value as? String else { return nil }

    guard let formatted = "\\.[a-z0-9]".r?.replaceAll(in: value, using: { match in
        var string = match.matched
        _ = string.removeFirst()
        return string.uppercased()
    }) else {
        return nil
    }
    
    if reservedWords.contains(formatted) {
        return "`\(formatted)`"
    } else {
        return formatted
    }
}

let leadingNumberFilter = Filter { (box: MustacheBox) in
    guard let value = box.value as? String else { return nil }
    if value.first?.isNumber ?? false {
        return "_\(value)"
    } else {
        return value
    }
}

template.register(varNameFilter, forKey: "varName")
template.register(leadingNumberFilter, forKey: "fixLeadingNumber")

// Load data
let data = FileManager.default.contents(atPath: "./symbols.json")!
let values = try! JSONDecoder().decode([String].self, from: data)

let output = try! template.render(values)

FileManager.default.createFile(atPath: "./SystemIcon.swift", contents: output.data(using: .utf8), attributes: nil)
