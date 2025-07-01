function Notify(msg, type, time, title)
    type = type or 'info'
    time = time or 5000
    title = title or 'Admin Menu'
    if IsDuplicityVersion() then
        TriggerClientEvent('ganji-notify:Notify', source, msg, type, time, title)
    else
        exports['ganji-notify']:Notify(msg, type, time, title)
    end
end

function DebugPrint(...)
    if not Config.Debug then return end
    if IsDuplicityVersion() then
        print("[DEBUG] ", ...)
    else
        print("[DEBUG] ", ...)
    end
end

function DumpTable(obj)
    if type(obj) == 'table' then
        local s = '{ '
        for k, v in pairs(obj) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. DumpTable(v) .. ','
        end
        return s .. '} '
    else
        return tostring(obj)
    end
end
