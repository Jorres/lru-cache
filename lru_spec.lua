local lu = require"luaunit"
local lru_fabric = require"lru"

function Test_negative_size_lru()
    lu.assertError(function()
        lru_fabric.new(-1)
    end)
end

function Test_zero_size_lru()
    lu.assertError(function()
        lru_fabric.new(0)
    end)
end

function Test_size_one_lru()
    local lru = lru_fabric.new(1)

    lru.put(1)
    lru.put(2)

    lu.assertFalse(lru.present(1))
    lu.assertTrue(lru.present(2))
end

function Test_size_n_lru()
    local n = 100
    local lru = lru_fabric.new(n)

    for i = 1, n, 1 do
        lru.put(i)
    end

    for i = 1, n, 1 do
        lu.assertTrue(lru.present(i))
    end
end

local function standart_preemption_scenario(a, b, c)
    local lru = lru_fabric.new(2)

    lru.put(a)
    lru.put(b)
    lru.put(a)
    lru.put(c)

    lu.assertTrue(lru.present(a))
    lu.assertFalse(lru.present(b))
    lu.assertTrue(lru.present(c))
end

function Test_lru_updates_recency()
    standart_preemption_scenario(1, 2, 3)
end

function Test_lru_updates_recency_string()
    standart_preemption_scenario("a", "b", "c")
end

function Test_lru_multiple_types_at_once() 
    standart_preemption_scenario(1, "abc", false)
end

os.exit( lu.LuaUnit.run() )
