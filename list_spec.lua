local lu = require"luaunit"
local list_factory = require"list"

function Test_empty_list_size_zero()
    local lst = list_factory.new()
    lu.assertEquals(lst.size(), 0)
end

function Test_push_pop_same()
    for i = 1, 10, 1 do
        local test_value = i
        local lst = list_factory.new()
        lst.push_back(test_value)
        local popped = lst.pop_back()
        lu.assertEquals(popped.val, test_value)
        lu.assertEquals(lst.size(), 0)
    end
end

function Test_push_pop_multiple()
    local lst = list_factory.new()

    for j = 1, 10, 1 do
        lst.push_back(j)
        lu.assertEquals(lst.size(), j)
    end

    for j = 10, 1, -1 do
        local popped = lst.pop_back()
        lu.assertEquals(popped.val, j)
        lu.assertEquals(lst.size(), j - 1)
    end
end

function Test_push_pop_front_multiple()
    local lst = list_factory.new()

    for j = 1, 10, 1 do
        lst.push_back(j)
        lu.assertEquals(lst.size(), j)
    end

    for j = 10, 1, -1 do
        local popped = lst.pop_front()
        lu.assertEquals(popped.val, 10 - j + 1)
        lu.assertEquals(lst.size(), j - 1)
    end
end

os.exit( lu.LuaUnit.run() )
