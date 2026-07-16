local v0 = Random.new();
local v1 = {};
for v2, v3 in pairs(table) do
	v1[v2] = v3;
end;
v1.contains = function(v4, v5) --[[ Line: 30 ]]
	return v1.indexOf(v4, v5) ~= nil;
end;
v1.indexOf = function(v6, v7) --[[ Line: 35 ]]
	local v8 = table.find(v6, v7);
	if v8 then
		return v8;
	else
		return v1.keyOf(v6, v7);
	end;
end;
v1.keyOf = function(v9, v10) --[[ Line: 44 ]]
	for v11, v12 in pairs(v9) do
		if v12 == v10 then
			return v11;
		end;
	end;
	return nil;
end;
v1.skip = function(v13, v14) --[[ Line: 54 ]]
	return table.move(v13, v14 + 1, #v13, 1, table.create(#v13 - v14));
end;
v1.take = function(v15, v16) --[[ Line: 59 ]]
	return table.move(v15, 1, v16, 1, table.create(v16));
end;
v1.range = function(v17, v18, v19) --[[ Line: 64 ]]
	return table.move(v17, v18, v19, 1, table.create(v19 - v18 + 1));
end;
v1.skipAndTake = function(v20, v21, v22) --[[ Line: 69 ]]
	return table.move(v20, v21 + 1, v21 + v22, 1, table.create(v22));
end;
v1.random = function(v23) --[[ Line: 74 ]]
	return v23[v0:NextInteger(1, #v23)];
end;
v1.join = function(v24, v25) --[[ Line: 79 ]]
	local v26 = table.create(#v24 + #v25);
	return table.move(v25, 1, #v25, #v24 + 1, v26);
end;
v1.removeObject = function(v27, v28) --[[ Line: 86 ]]
	local v29 = v1.indexOf(v27, v28);
	if v29 then
		table.remove(v27, v29);
	end;
end;
v1.expand = function(v30, v31) --[[ Line: 95 ]]
	if v31 < 0 then
		error("Cannot expand a table by a negative amount of objects.");
	end;
	local v32 = table.create(#v30 + v31);
	for v33 = 1, #v30 do
		v32[v33] = v30[v33];
	end;
	return v32;
end;
return v1;
