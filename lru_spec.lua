local lu = require"luaunit"
local lru_fabric = require"lru"
local naive_lru_fabric = require"naive_lru"

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

function Test_big_random_input()
    math.randomseed(os.time())

    local test_size = 10000
    local lru_size = 100
    local key_domain_size = lru_size * 2

    local lru = lru_fabric.new(lru_size)
    local naive_lru = naive_lru_fabric.new(lru_size)

    for _ = 1, test_size, 1 do
        local key = math.random(1, key_domain_size)

        lru.put(key)
        naive_lru.put(key)

        for j = 1, key_domain_size, 1 do
            lu.assertEquals(lru.present(j), naive_lru.present(j))
        end
    end
end

os.exit( lu.LuaUnit.run() )
