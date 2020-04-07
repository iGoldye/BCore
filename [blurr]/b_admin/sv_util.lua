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