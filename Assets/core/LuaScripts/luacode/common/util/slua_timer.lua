local M = { }

local timer_name_list = { }

M.EVENT_LIST = {
    Interact_Tip = "Interact_Tip",
    Exhibition_Tip = "Exhibition_Tip",
    Exhibition_Anim_Time = "Exhibition_Anim_Time",
    Spell_Cd_Mod_Color = "Spell_Cd_Mod_Color",
    Req_Team_Member_Pos_Timer = "Req_Team_Member_Pos_Timer" -- 作为请求队友位置的计时器 by xinghanzhong 2018/3/7
}

-- delay:延迟执行时间(秒) func:执行方法
function M.addDelayEvent(delay, func)
    LuaTimer.Add(delay * 1000, function(id)
        func()
    end )
end

-- name:名称 delay:延迟执行时间(秒) cycle:循环间隔(秒)(<=0认为不循环) func:执行方法
function M.addTimerEvent(name, delay, cycle, func)

    -- 规范,要求必须是enum里面定义
    assert(M.EVENT_LIST[name] ~= nil)
    -- 不应该出现同名的timer
    assert(timer_name_list[name] == nil)



    LuaTimer.Add(delay * 1000, cycle * 1000, function(id)
        func()

        if (timer_name_list[name] == nil) then
            timer_name_list[name] = id
        end

        if (cycle <= 0) then
            timer_name_list[name] = nil
            return false
        else
            return true
        end

    end )
end

function M.removeTimerEvent(name)

    -- assert(timer_name_list[name] ~= nil)

    if (timer_name_list[name] == nil) then
        return
    end

    local id = timer_name_list[name]

    assert(type(id) == "number")

    LuaTimer.Delete(id)

    timer_name_list[name] = nil

end

return M