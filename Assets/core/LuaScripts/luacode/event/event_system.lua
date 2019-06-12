
local Event_system = {}
Event_system.m_event_caches = {}

function Event_system:init()
	require("event.event_binder")
	require("event.event_definer")
end

function Event_system:add_event_listener(event_type, func)
	if Event_system.m_event_caches[event_type] == nil then
		Event_system.m_event_caches[event_type] = {}
	end
	table.insert(Event_system.m_event_caches[event_type], func)
end

function Event_system:del_event_listener(event_type, func)
	local event_list = Event_system.m_event_caches[event_type]
	if event_list == nil then
		return
	end
	
	for key, value in ipairs(event_list) do
		if value == func then
			table.remove(event_list, key )
		end
	end
end

function Event_system:dispatch_event(event_type , ...)
	local event_list = Event_system.m_event_caches[event_type];
	
	if event_list == nil then
		return ;
	end
	
	for key, value in ipairs(event_list) do
		if value ~= nil then
			value(...);
		end
	end
end

function Event_system:remove_all()
	Event_system.m_event_caches = {};
end

return Event_system