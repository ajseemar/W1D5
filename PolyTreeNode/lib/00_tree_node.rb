class PolyTreeNode
    attr_reader :value, :children, :parent
    def initialize(value, children = [])
        @value = value
        @parent = nil
        @children = children
    end

    def parent=(parent_node)
        # return nil if parent_node.nil?
        if !self.parent.nil? 
            @parent.children.delete(self)
        end

        @parent = parent_node.nil? ? nil : parent_node 
        unless @parent == nil
            parent_node.children << self unless parent_node.children.include?(self)
        end
    end

    def add_child(child_node)
        child_node.parent = self
        #@children << child_node
    end

    def remove_child(child_node)
        raise if child_node.parent.nil?
        child_node.parent = nil
        #@children.delete(child_node)
    end

    def dfs(target_value)
        return self if target_value == self.value
        self.children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.length == 0
            current_node = queue.pop
            return current_node if current_node.value == target_value
            current_node.children.each do |child|
                queue.unshift(child)
            end
        end
        nil
    end
end
