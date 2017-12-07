input = File.read("input.txt")

class Node
    property name
    property weight
    property ownWeight
    property parent
    property children
    def initialize(
        @name : String,
        @weight : Int32,
        @ownWeight : Int32,
        @parent : String|Nil,
        @children : Array(String))
    end
    
end

alias Graph = Hash(String, Node)

g = Hash(String, Node).new

nodes = [] of Node

input.split("\n").map do |line|
    m = /(\w+) \((\d+)\)(?: ->)?(.*)/.match(line)
    raise "line does not match regex" if m.nil?

    name = m[1]
    weight = m[2].to_i
    children = m[3].split(",").map(&.strip).select { |c| c.size > 0 }

    node = Node.new(name, weight, weight, nil, children)
    nodes << node
end

2.times do
    nodes.map do |node|
        name = node.name
        children = node.children
        
        g[name] ||= node
        g[name].weight = node.weight
        g[name].children = children
        children.map do |childName|
            g[childName] ||= Node.new(childName, 0, 0, nil, [] of String)
            child = g[childName]
            g[childName].parent = name
        end
    end
end


parent = g.select { |key, value|
    value.children.size > 0 && value.parent == nil
}.values[0]

def weight(n : Node, g : Graph)
    weight = n.weight
    unless n.children.nil?
        weight += n.children.sum { |childName|
            weight(g[childName], g)
        }
    end
    n.weight = weight
    weight
end

# build real (own + recursive child weight) weights of all nodes
weight(parent, g)

def find(n : Node, g : Graph, diff = 0)
    children = n.children.map { |c| g[c] }
    childWeights = children.map(&.weight)
    evenChild = children.find { |n| childWeights.count(n.weight) > 1 }.as Node
    oddChild = children.find { |n| childWeights.count(n.weight) == 1 }
    
    if oddChild.nil?
        puts("#{n.name} -> #{n.children.join(" ")} : #{n.ownWeight} + (#{n.children.map{|c| g[c].weight}.join(" + ")})}")
        puts("#{n.name} (#{n.ownWeight}) Should be adjusted by #{diff} to be #{n.ownWeight + diff}")
    else
        puts("#{n.name} -> #{n.children.join(" ")} : #{n.ownWeight} + (#{n.children.map{|c| g[c].weight}.join(" + ")})}")
        
        diff = evenChild.weight - oddChild.weight
        find(oddChild, g, diff)
    end
end

find(parent, g)