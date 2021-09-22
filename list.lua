local list = {}

list.new = function ()
    local fst = nil
    local lst = nil
    local size = 0

    local instance = {}

    instance.push_back = function (v)
        local new_lst = { next = nil, prev = lst, val = v}
        if lst ~= nil then
            lst.next = new_lst
        else
            fst = new_lst
            lst = new_lst
        end
        lst = new_lst

        size = size + 1
        return lst
    end

    instance.pop_back = function ()
        local to_pop = lst
        if to_pop.prev ~= nil then
            to_pop.prev.next = nil 
            lst = to_pop.prev
        else
            fst = nil
            lst = nil
        end
        size = size - 1
        return to_pop
    end

    instance.pop_front = function ()
        local to_pop = fst
        if to_pop.next ~= nil then
            to_pop.next.prev = nil 
            fst = to_pop.next
        else
            fst = nil
            lst = nil
        end
        size = size - 1
        return to_pop
    end

    instance.delete_by_link = function (node)
        if node == fst then
            fst = node.next
        end
        if node == lst then
            lst = node.prev
        end

        if node.prev ~= nil then
            node.prev.next = node.next
        end
        if node.next ~= nil then
            node.next.prev = node.prev
        end

        size = size - 1
        return node
    end

    instance.print = function ()
        local curnode = fst
        print('[')
        while curnode do
            print(curnode.val)
            curnode = curnode.next
        end
        print(']')
    end

    instance.size = function ()
        return size
    end

    return instance
end

return list

