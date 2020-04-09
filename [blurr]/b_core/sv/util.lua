mainDir = "C:/Program Files/BData"
usersDir = "C:/Program Files/BData/users"
groupsDir = "C:/Program Files/BData/groups"
bansDir = "C:/Program Files/BData/bans"

function stringJoin(strings, start)
    local joint = ""

    for i = start, #strings do
        joint = joint.." "..strings[i]
    end

    return joint
end

function stringSplit(inputstr, sep) 
    if sep == nil then 
        sep = "%s" 
    end 
    local t={} ; i=1 for str in string.gmatch(inputstr, "([^"..sep.."]+)") do t[i] = str i = i + 1 end 

    return t 
end
function stringStartsWith(str, start)
   return str:sub(1, #start) == start
end
function stringEndsWith(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function file_exists(filename, filepath)
    local path = filepath .. "/" .. filename
    local f=io.open(path,"r")
    if f~=nil then
        io.close(f)
        return true
    else 
        return false
    end
end

function GetID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(tonumber(source))) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        elseif string.sub(tostring(v), 1, string.len("discord:")) == "discord:" and (type == "discord" or type == 4) then
            local d = stringSplit(v, ":")
            return tonumber(d[2])
        end
    end
    return nil
end

function saveUser(identifier, data)
    local filename = identifier..".json"
    saveData(data, filename, usersDir)
end

function saveData(t, filename, filepath)
    local path = filepath .. "/" .. filename
    local file = io.open(path, "w")

    if file then
        local contents = json.encode(t)
        file:write(contents)
        io.close(file)
        return true
    else
        return false
    end
end

function loadUser(identifier)
    local filename = identifier..".json"

    if file_exists(filename, usersDir) then
        return loadData(filename, usersDir)
    else
        return nil
    end
end

function loadData(filename, filepath)
    local path = filepath .. "/" .. filename
    local contents = ""
    local myTable = {}
    local file = io.open(path, "r")

    if file then
        -- read all contents of file into a string
        local contents = file:read("*a")
        myTable = json.decode(contents);
        io.close(file)
        return myTable
    end
    return nil
end