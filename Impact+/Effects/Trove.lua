local v0 = newproxy();
local v1 = newproxy();
local l_RunService_0 = game:GetService("RunService");
local function v6(v3, v4) --[[ Line: 12 ]] --[[ Name: GetObjectCleanupFunction ]]
	local v5 = typeof(v3);
	if v5 == "function" then
		return v0;
	elseif v5 == "thread" then
		return v1;
	elseif v4 then
		return v4;
	elseif v5 == "Instance" then
		return "Destroy";
	elseif v5 == "RBXScriptConnection" then
		return "Disconnect";
	else
		if v5 == "table" then
			if typeof(v3.Destroy) == "function" then
				return "Destroy";
			elseif typeof(v3.Disconnect) == "function" then
				return "Disconnect";
			end;
		end;
		error("Failed to get cleanup function for object " .. v5 .. ": " .. tostring(v3), 3);
		return;
	end;
end;
local function _(v7) --[[ Line: 37 ]] --[[ Name: AssertPromiseLike ]]
	if type(v7) ~= "table" or type(v7.getStatus) ~= "function" or type(v7.finally) ~= "function" or type(v7.cancel) ~= "function" then
		error("Did not receive a Promise as an argument", 3);
	end;
end;
local v9 = {};
v9.__index = v9;
v9.new = function() --[[ Line: 57 ]] --[[ Name: new ]]
	local v10 = setmetatable({}, v9);
	v10._objects = {};
	return v10;
end;
v9.Extend = function(v11) --[[ Line: 83 ]] --[[ Name: Extend ]]
	return v11:Construct(v9);
end;
v9.Clone = function(v12, v13) --[[ Line: 92 ]] --[[ Name: Clone ]]
	return v12:Add(v13:Clone());
end;
v9.Construct = function(v14, v15, ...) --[[ Line: 130 ]] --[[ Name: Construct ]]
	local v16 = nil;
	local v17 = type(v15);
	if v17 == "table" then
		v16 = v15.new(...);
	elseif v17 == "function" then
		v16 = v15(...);
	end;
	return v14:Add(v16);
end;
v9.Connect = function(v18, v19, v20) --[[ Line: 157 ]] --[[ Name: Connect ]]
	return v18:Add(v19:Connect(v20));
end;
v9.BindToRenderStep = function(v21, v22, v23, v24) --[[ Line: 175 ]] --[[ Name: BindToRenderStep ]]
	l_RunService_0:BindToRenderStep(v22, v23, v24);
	v21:Add(function() --[[ Line: 177 ]]
		l_RunService_0:UnbindFromRenderStep(v22);
	end);
end;
v9.AddPromise = function(v25, v26) --[[ Line: 206 ]] --[[ Name: AddPromise ]]
	if type(v26) ~= "table" or type(v26.getStatus) ~= "function" or type(v26.finally) ~= "function" or type(v26.cancel) ~= "function" then
		error("Did not receive a Promise as an argument", 3);
	end;
	if v26:getStatus() == "Started" then
		v26:finally(function() --[[ Line: 209 ]]
			return v25:_findAndRemoveFromObjects(v26, false);
		end);
		v25:Add(v26, "cancel");
	end;
	return v26;
end;
v9.Add = function(v27, v28, v29) --[[ Line: 266 ]] --[[ Name: Add ]]
	local v30 = v6(v28, v29);
	if v27.DestroyPartsAddedAfter then
		v27:_cleanupObject(v28, v30);
		return v28;
	else
		table.insert(v27._objects, {
			v28, 
			v30
		});
		return v28;
	end;
end;
v9.Remove = function(v31, v32, v33) --[[ Line: 287 ]] --[[ Name: Remove ]]
	return v31:_findAndRemoveFromObjects(v32, not v33);
end;
v9.Clean = function(v34) --[[ Line: 297 ]] --[[ Name: Clean ]]
	for _, v36 in ipairs(v34._objects) do
		v34:_cleanupObject(v36[1], v36[2]);
	end;
	table.clear(v34._objects);
end;
v9._findAndRemoveFromObjects = function(v37, v38, v39) --[[ Line: 305 ]] --[[ Name: _findAndRemoveFromObjects ]]
	local l__objects_0 = v37._objects;
	for v41, v42 in ipairs(l__objects_0) do
		if v42[1] == v38 then
			local v43 = #l__objects_0;
			l__objects_0[v41] = l__objects_0[v43];
			l__objects_0[v43] = nil;
			if v39 then
				v37:_cleanupObject(v42[1], v42[2]);
			end;
			return true;
		end;
	end;
	return false;
end;
v9._cleanupObject = function(_, v45, v46) --[[ Line: 322 ]] --[[ Name: _cleanupObject ]]
	if v46 == v0 then
		xpcall(v45, function(v47) --[[ Line: 325 ]]
			warn(v47, "\n", debug.traceback());
		end);
		return;
	elseif v46 == v1 then
		coroutine.close(v45);
		return;
	elseif not v45[v46] then
		if l_RunService_0:IsStudio() then
			warn(debug.traceback((typeof(v45))));
		end;
		return;
	else
		v45[v46](v45);
		return;
	end;
end;
v9.AttachToInstance = function(v48, v49) --[[ Line: 351 ]] --[[ Name: AttachToInstance ]]
	assert(v49:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy");
	return v48:Connect(v49.AncestryChanged, function() --[[ Line: 353 ]]
		if not v49.Parent then
			v48:Destroy();
		end;
	end);
end;
v9.Destroy = function(v50) --[[ Line: 367 ]] --[[ Name: Destroy ]]
	v50:Clean();
end;
return v9;
