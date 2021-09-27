local naive_lru = { }

--[[
Naive lru implementation. Used for testing.
Iterates over its content to determine least recently used.
O(n) insertion, O(1) check
--]]

naive_lru.new = function(max_elems)
    local lru_instance = {}
    local storage = {}
    local cur_time = 0
    local size = 0

    lru_instance.put = function(key) 
        if storage[key] ~= nil then
            storage[key] = cur_time
        elseif size < max_elems then
            storage[key] = cur_time
            size = size + 1
        else
            local min_elem = -1
            for elem, time in pairs(storage) do
                if (min_elem == -1) or (storage[min_elem] > time) then
                    min_elem = elem
                end
            end
            storage[min_elem] = nil
            storage[key] = cur_time
        end

        cur_time = cur_time + 1
    end

    lru_instance.present = function(key)
        return storage[key] ~= nil
    end

    return lru_instance
end

return naive_lru
