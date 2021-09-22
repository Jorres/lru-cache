local list = require"list"

local lru = { }

lru.new = function(max_elems)
    assert(max_elems >= 1, "max_elems must be >= 1")

    local lru_instance = {}

    local cache = {} 
    local list_of_keys = list.new()

    lru_instance.put = function(key) 
        if cache[key] == nil then
            if list_of_keys.size() == max_elems then
                local node_to_delete = list_of_keys.pop_front()
                cache[node_to_delete.val] = nil
            end
        else
            list_of_keys.delete_by_link(cache[key])
        end

        local last_put = list_of_keys.push_back(key)
        cache[key] = last_put

        assert(list_of_keys.size() <= max_elems)
    end

    lru_instance.present = function(key)
        return cache[key] ~= nil
    end

    return lru_instance
end

return lru
