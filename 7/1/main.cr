input = File.read("input.txt")

g = Hash(String, NamedTuple(children: Array(String), parent: String | Nil)).new

alias Node = NamedTuple(name: String, children: Array(String))
nodes = [] of Node

input.split("\n").map do |line|
    m = /(\w+) \(\d+\)(?: ->)?(.*)/.match(line)
    raise "line does not match regex" if m.nil?

    name = m[1]
    children = m[2].split(",").map(&.strip)
    nodes << { name: name, children: children}
end

2.times do
    nodes.map do |node|
        name = node[:name]
        children = node[:children]
        
        g[name] ||= { children: children, parent: nil}
        children.map do |childName|
            g[childName] ||= { children: [] of String, parent: nil}
            child = g[childName]
            g[childName] = { children: child[:children], parent: name}
        end
    end
end
    
g.map do |key, value|
    if value[:children].size > 0 && value[:parent] == nil
        puts("The root node is #{key}")
    end
end