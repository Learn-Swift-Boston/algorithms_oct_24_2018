
indirect enum FileSystemObject {

    case folder(_ name: String, children: [FileSystemObject])
    case file(_ name: String, contents: String)

}

let root = FileSystemObject.folder("Macintosh HD", children: [
    .folder("Applications", children: [
        .folder("Utilities", children: [
            .file("Terminal.app", contents: "0x7d31a48e"),
            .file("Activity Monitor.app", contents: "0x5dea8df8"),
            .file("Digital Color Meter.app", contents: "0x4845a5a4"),
            // ...
            ])
        ]),
    .folder("Users", children: [
        .folder("igeek", children: [
            .folder("Desktop", children: [
                .file("Readme.txt", contents: "This is a file, yay!"),
                ]),
            .folder("Downloads", children: [
                .folder("tutorial", children: [
                    .file("tutorial 1.txt", contents: "stuff 1"),
                    .file("tutorial 2.txt", contents: "stuff 2"),
                    .file("tutorial 3.txt", contents: "stuff 3")
                    ]),
                ]),
            ])
        ])
    ])

extension String {

    static func indent(level: Int) -> String {
        return Array(repeating: "  ", count: level).joined()
    }

}

extension FileSystemObject {

    func listEverything(indentationLevel: Int = 0) -> String {
        switch self {
        case .file(let name, _): // base case
            return String.indent(level: indentationLevel) + name
        case .folder(let name, let children):
            return String.indent(level: indentationLevel) + name + "\n" +
                children
                .map { $0.listEverything(indentationLevel: indentationLevel + 1) }
                .joined(separator: "\n")
        }
    }

}

// 📁 💾 📝
let printout = """
Macintosh HD
  Applications
    Utilities
      Terminal.app
      Activity Monitor.app
      Digital Color Meter.app
  Users
    igeek
      Desktop
        Readme.txt
      Downloads
        tutorial
          tutorial 1.txt
          tutorial 2.txt
          tutorial 3.txt
"""

print(root.listEverything())
assert(printout == root.listEverything())
