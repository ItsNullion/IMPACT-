local l_Table_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/KOKUSENNN/refs/heads/main/PartCacheTable.lua"))()
local v1 = {};
v1.__index = v1;
v1.__type = "PartCache";
local v2 = CFrame.new(0, 1000000000, 0);
local function _(v3, v4) --[[ Line: 60 ]] --[[ Name: assertwarn ]]
	if v3 == false then
		warn(v4);
	end;
end;
local function _(v6, v7) --[[ Line: 67 ]] --[[ Name: MakeFromTemplate ]]
	local v8 = v6:Clone();
	v8.CFrame = v2;
	v8.Anchored = true;
	v8.Parent = v7;
	return v8;
end;
v1.new = function(v10, v11, v12) --[[ Line: 77 ]] --[[ Name: new ]]
	local v13 = v11 or 5;
	local v14 = v12 or workspace;
	assert(v11 > 0, "PrecreatedParts can not be negative!");
	if v11 ~= 0 == false then
		warn("PrecreatedParts is 0! This may have adverse effects when initially using the cache.");
	end;
	if v10.Archivable == false then
		warn("The template's Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.");
	end;
	local l_Archivable_0 = v10.Archivable;
	v10.Archivable = true;
	local v16 = v10:Clone();
	v10.Archivable = l_Archivable_0;
	v10 = v16;
	local v17 = {
		Open = {}, 
		InUse = {}, 
		CurrentCacheParent = v14, 
		Template = v10, 
		ExpansionSize = 10
	};
	setmetatable(v17, v1);
	for _ = 1, v13 do
		local l_insert_0 = l_Table_0.insert;
		local l_Open_0 = v17.Open;
		local l_v10_0 = v10;
		local l_CurrentCacheParent_0 = v17.CurrentCacheParent;
		local v23 = l_v10_0:Clone();
		v23.CFrame = v2;
		v23.Anchored = true;
		v23.Parent = l_CurrentCacheParent_0;
		l_insert_0(l_Open_0, v23);
	end;
	v17.Template.Parent = nil;
	return v17;
end;
v1.GetPart = function(v24) --[[ Line: 115 ]] --[[ Name: GetPart ]]
	assert(getmetatable(v24) == v1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPart", "PartCache.new"));
	if #v24.Open == 0 then
		warn("No parts available in the cache! Creating [" .. v24.ExpansionSize .. "] new part instance(s) - this amount can be edited by changing the ExpansionSize property of the PartCache instance... (This cache now contains a grand total of " .. tostring(#v24.Open + #v24.InUse + v24.ExpansionSize) .. " parts.)");
		for _ = 1, v24.ExpansionSize do
			local l_insert_1 = l_Table_0.insert;
			local l_Open_1 = v24.Open;
			local l_Template_0 = v24.Template;
			local l_CurrentCacheParent_1 = v24.CurrentCacheParent;
			local v30 = l_Template_0:Clone();
			v30.CFrame = v2;
			v30.Anchored = true;
			v30.Parent = l_CurrentCacheParent_1;
			l_insert_1(l_Open_1, v30);
		end;
	end;
	local v31 = v24.Open[#v24.Open];
	v24.Open[#v24.Open] = nil;
	l_Table_0.insert(v24.InUse, v31);
	return v31;
end;
v1.ReturnPart = function(v32, v33) --[[ Line: 131 ]] --[[ Name: ReturnPart ]]
	assert(getmetatable(v32) == v1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("ReturnPart", "PartCache.new"));
	local v34 = l_Table_0.indexOf(v32.InUse, v33);
	if v34 ~= nil then
		l_Table_0.remove(v32.InUse, v34);
		l_Table_0.insert(v32.Open, v33);
		v33.CFrame = v2;
		v33.Anchored = true;
		return;
	else
		error("Attempted to return part \"" .. v33.Name .. "\" (" .. v33:GetFullName() .. ") to the cache, but it's not in-use! Did you call this on the wrong part?");
		return;
	end;
end;
v1.SetCacheParent = function(v35, v36) --[[ Line: 146 ]] --[[ Name: SetCacheParent ]]
	assert(getmetatable(v35) == v1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetCacheParent", "PartCache.new"));
	assert(v36:IsDescendantOf(workspace) or v36 == workspace, "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world.");
	v35.CurrentCacheParent = v36;
	for v37 = 1, #v35.Open do
		v35.Open[v37].Parent = v36;
	end;
	for v38 = 1, #v35.InUse do
		v35.InUse[v38].Parent = v36;
	end;
end;
v1.Expand = function(v39, v40) --[[ Line: 160 ]] --[[ Name: Expand ]]
	assert(getmetatable(v39) == v1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Expand", "PartCache.new"));
	if v40 == nil then
		v40 = v39.ExpansionSize;
	end;
	for _ = 1, v40 do
		local l_insert_2 = l_Table_0.insert;
		local l_Open_2 = v39.Open;
		local l_Template_1 = v39.Template;
		local l_CurrentCacheParent_2 = v39.CurrentCacheParent;
		local v46 = l_Template_1:Clone();
		v46.CFrame = v2;
		v46.Anchored = true;
		v46.Parent = l_CurrentCacheParent_2;
		l_insert_2(l_Open_2, v46);
	end;
end;
v1.Dispose = function(v47) --[[ Line: 172 ]] --[[ Name: Dispose ]]
	assert(getmetatable(v47) == v1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "PartCache.new"));
	for v48 = 1, #v47.Open do
		v47.Open[v48]:Destroy();
	end;
	for v49 = 1, #v47.InUse do
		v47.InUse[v49]:Destroy();
	end;
	v47.Template:Destroy();
	v47.Open = {};
	v47.InUse = {};
	v47.CurrentCacheParent = nil;
	v47.GetPart = nil;
	v47.ReturnPart = nil;
	v47.SetCacheParent = nil;
	v47.Expand = nil;
	v47.Dispose = nil;
end;
return v1;
