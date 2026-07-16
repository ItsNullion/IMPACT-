local PartCache = loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/KOKUSENNN/refs/heads/main/PartCache.lua"))()
local l_clock_0 = os.clock;
local l_Workspace_0 = game:GetService("Workspace");
local l_RunService_0 = game:GetService("RunService");
local l__BlackFlash_0 = l_Workspace_0.CurrentCamera:FindFirstChild("_BlackFlash");
if not l__BlackFlash_0 then
	l__BlackFlash_0 = Instance.new("Model");
	l__BlackFlash_0.Name = "_BlackFlash";
	local l_Highlight_0 = Instance.new("Highlight");
	l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
	l_Highlight_0.FillColor = Color3.new(0, 0, 0);
	l_Highlight_0.FillTransparency = 0;
	l_Highlight_0.OutlineColor = Color3.fromRGB(255, 0, 0);
	l_Highlight_0.OutlineTransparency = 0;
	l_Highlight_0:SetAttribute("OriginalColor", l_Highlight_0.OutlineColor);
	l_Highlight_0.Parent = l__BlackFlash_0;
	l__BlackFlash_0.Parent = l_Workspace_0.CurrentCamera;
end;
local l_Part_0 = Instance.new("Part");
local v6 = 0;
local v7 = 0;
l_Part_0.TopSurface = v6;
l_Part_0.BottomSurface = v7;
v6 = true;
v7 = false;
l_Part_0.Anchored = v6;
l_Part_0.CanCollide = v7;
v6 = true;
v7 = false;
l_Part_0.Locked = v6;
l_Part_0.CastShadow = v7;
l_Part_0.Shape = "Cylinder";
l_Part_0.Name = "BoltPart";
l_Part_0.Material = Enum.Material.Neon;
l_Part_0.Color = Color3.new(1, 1, 1);
l_Part_0.Transparency = 1;
v7 = PartCache.new(l_Part_0, 360);
v7:SetCacheParent(l__BlackFlash_0);
local function v13(v8, v9, v10, v11, v12) --[[ Line: 48 ]] --[[ Name: CubicBezier ]]
	return v9 * (1 - v8) ^ 3 + v10 * 3 * v8 * (1 - v8) ^ 2 + v11 * 3 * (1 - v8) * v8 ^ 2 + v12 * v8 ^ 3;
end;
local function v21(v14, v15, v16, v17, v18, v19, v20) --[[ Line: 55 ]] --[[ Name: DiscretePulse ]]
	return (math.clamp(v17 / (2 * v18) - math.abs((v14 - v15 * v16 + 0.5 * v17) / v18), v19, v20));
end;
local function v23(v22) --[[ Line: 59 ]] --[[ Name: ExtrudeCenter ]]
	return (math.exp(-5000 * (v22 - 0.5) ^ 10));
end;
local function _(v24, v25, v26, v27, v28) --[[ Line: 63 ]] --[[ Name: NoiseBetween ]]
	return v27 + (v28 - v27) * (math.noise(v24, v25, v26) + 0.5);
end;
local v30 = CFrame.lookAt(Vector3.new(), (Vector3.new(1, 0, 0, 0))):inverse();
local v31 = {};
local v32 = {
	__type = "LightningBolt"
};
v32.__index = v32;
v32._LightningCache = v7;
v32.new = function(v33, v34, v35) --[[ Line: 85 ]] --[[ Name: new ]]
	local v36 = setmetatable({}, v32);
	v35 = v35 or 30;
	v36.Enabled = true;
	v36.Attachment0 = v33;
	v36.Attachment1 = v34;
	local v37 = 0;
	local v38 = 0;
	v36.CurveSize0 = v37;
	v36.CurveSize1 = v38;
	v37 = 0;
	v38 = 2.4;
	v36.MinRadius = v37;
	v36.MaxRadius = v38;
	v36.Frequency = 1;
	v36.AnimationSpeed = 7;
	v36.Thickness = 1;
	v37 = 0.2;
	v38 = 1;
	v36.MinThicknessMultiplier = v37;
	v36.MaxThicknessMultiplier = v38;
	v37 = 0;
	v38 = 1;
	v36.MinTransparency = v37;
	v36.MaxTransparency = v38;
	v36.PulseSpeed = 2;
	v36.PulseLength = 1000000;
	v36.FadeLength = 0.2;
	v36.ContractFrom = 0.5;
	v36.Color = Color3.new(1, 1, 1);
	v36.ColorOffsetSpeed = 3;
	v36.SpaceCurveFunction = v13;
	v36.OpacityProfileFunction = v21;
	v36.RadialProfileFunction = v23;
	v36._Parts = {};
	for v39 = 1, v35 do
		v36._Parts[v39] = v7:GetPart();
	end;
	v36._PartsHidden = false;
	v36._DisabledTransparency = 1;
	v36._StartT = l_clock_0();
	v36._RanNum = math.random() * 100;
	v36._RefIndex = #v31 + 1;
	v31[v36._RefIndex] = v36;
	return v36;
end;
v32.Destroy = function(v40) --[[ Line: 170 ]] --[[ Name: Destroy ]]
	v31[v40._RefIndex] = nil;
	if game:GetService("RunService"):IsRunning() then
		for v41 = 1, #v40._Parts do
			v7:ReturnPart(v40._Parts[v41]);
		end;
	end;
	setmetatable(v40, nil);
end;
v32.DestroyDissipate = function(v42, v43, v44) --[[ Line: 185 ]] --[[ Name: DestroyDissipate ]]
	v43 = v43 or 0.2;
	v44 = v44 or 0.5;
	local v45 = l_clock_0();
	local l_MinTransparency_0 = v42.MinTransparency;
	local l_ContractFrom_0 = v42.ContractFrom;
	local v48 = v42.ContractFrom + 1 / (#v42._Parts * v42.FadeLength);
	local l_MaxRadius_0 = v42.MaxRadius;
	local l_MinThicknessMultiplier_0 = v42.MinThicknessMultiplier;
	local v51 = nil;
	v51 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 195 ]]
		local v52 = l_clock_0() - v45;
		v42.MinThicknessMultiplier = l_MinThicknessMultiplier_0 + (-2 - l_MinThicknessMultiplier_0) * v52 / v43;
		if v52 < v43 * 0.4 then
			local v53 = v52 / (v43 * 0.4);
			v42.MinTransparency = l_MinTransparency_0 + (l_ContractFrom_0 - l_MinTransparency_0) * v53;
			return;
		elseif v52 < v43 then
			local v54 = (v52 - v43 * 0.4) / (v43 * 0.6);
			v42.MinTransparency = l_ContractFrom_0 + (v48 - l_ContractFrom_0) * v54;
			v42.MaxRadius = l_MaxRadius_0 * (1 + v44 * v54);
			v42.MinRadius = v42.MinRadius + (v42.MaxRadius - v42.MinRadius) * v54;
			return;
		else
			if l_clock_0() - v42._StartT < (v42.PulseLength + 1) / v42.PulseSpeed then
				v42:Destroy();
			end;
			v51:Disconnect();
			v51 = nil;
			return;
		end;
	end);
end;
v32._UpdateGeometry = function(v55, v56, v57, v58, v59, v60, v61) --[[ Line: 223 ]] --[[ Name: _UpdateGeometry ]]
	local v62 = 1 - v55.MaxTransparency;
	local v63 = 1 - v55.MinTransparency;
	local v64 = v55.OpacityProfileFunction(v57, v58, v55.PulseSpeed, v55.PulseLength, v55.FadeLength, v62, v63);
	local v65 = v55.Thickness * v59 * v64;
	v64 = v65 > 0 and v64 or 0;
	local v66 = 1 - v55.ContractFrom;
	local v67 = #v55._Parts;
	if v66 < v64 then
		v56.Size = Vector3.new((v61 - v60).Magnitude, v65, v65);
		v56.CFrame = CFrame.lookAt((v60 + v61) * 0.5, v61) * v30;
		v56.Transparency = 1 - v64;
		return;
	elseif v66 - 1 / (v67 * v55.FadeLength) < v64 then
		local v68 = (1 - (v64 - (v66 - 1 / (v67 * v55.FadeLength))) * v67 * v55.FadeLength) * (v57 < v58 * v55.PulseSpeed - 0.5 * v55.PulseLength and 1 or -1);
		v56.Size = Vector3.new((1 - math.abs(v68)) * (v61 - v60).Magnitude, v65, v65);
		v56.CFrame = CFrame.lookAt(v60 + (v61 - v60) * (math.max(0, v68) + 0.5 * (1 - math.abs(v68))), v61) * v30;
		v56.Transparency = 1 - v64;
		return;
	else
		v56.Transparency = 1;
		return;
	end;
end;
v32._UpdateColor = function(v69, v70, v71, v72) --[[ Line: 269 ]] --[[ Name: _UpdateColor ]]
	if typeof(v69.Color) == "Color3" then
		v70.Color = v69.Color;
		return;
	else
		local v73 = (v69._RanNum + v71 - v72 * v69.ColorOffsetSpeed) % 1;
		local l_Keypoints_0 = v69.Color.Keypoints;
		for v75 = 1, #l_Keypoints_0 - 1 do
			if l_Keypoints_0[v75].Time < v73 and v73 < l_Keypoints_0[v75 + 1].Time then
				v70.Color = l_Keypoints_0[v75].Value:lerp(l_Keypoints_0[v75 + 1].Value, (v73 - l_Keypoints_0[v75].Time) / (l_Keypoints_0[v75 + 1].Time - l_Keypoints_0[v75].Time));
				return;
			end;
		end;
		return;
	end;
end;
v32._Disable = function(v76) --[[ Line: 287 ]] --[[ Name: _Disable ]]
	v76.Enabled = false;
	for _, v78 in ipairs(v76._Parts) do
		v78.Transparency = v76._DisabledTransparency;
	end;
end;
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 294 ]]
	debug.profilebegin("LightningBolt");
	for _, v80 in pairs(v31) do
		if v80.Enabled == true then
			v80._PartsHidden = false;
			local l_MinRadius_0 = v80.MinRadius;
			local l_MaxRadius_1 = v80.MaxRadius;
			local l__Parts_0 = v80._Parts;
			local v84 = #l__Parts_0;
			local l__RanNum_0 = v80._RanNum;
			local l_AnimationSpeed_0 = v80.AnimationSpeed;
			local l_Frequency_0 = v80.Frequency;
			local l_MinThicknessMultiplier_1 = v80.MinThicknessMultiplier;
			local l_MaxThicknessMultiplier_0 = v80.MaxThicknessMultiplier;
			local v90 = l_clock_0() - v80._StartT;
			local l_SpaceCurveFunction_0 = v80.SpaceCurveFunction;
			local l_RadialProfileFunction_0 = v80.RadialProfileFunction;
			local v93 = (v80.PulseLength + 1) / v80.PulseSpeed;
			local l_Attachment0_0 = v80.Attachment0;
			local l_Attachment1_0 = v80.Attachment1;
			local l_CurveSize0_0 = v80.CurveSize0;
			local l_CurveSize1_0 = v80.CurveSize1;
			local l_WorldPosition_0 = l_Attachment0_0.WorldPosition;
			local v99 = l_Attachment0_0.WorldPosition + l_Attachment0_0.WorldAxis * l_CurveSize0_0;
			local v100 = l_Attachment1_0.WorldPosition - l_Attachment1_0.WorldAxis * l_CurveSize1_0;
			local l_WorldPosition_1 = l_Attachment1_0.WorldPosition;
			local v102 = l_SpaceCurveFunction_0(0, l_WorldPosition_0, v99, v100, l_WorldPosition_1);
			local l_v102_0 = v102;
			local l_v102_1 = v102;
			if v90 < v93 then
				for v105 = 1, v84 do
					local v106 = l__Parts_0[v105];
					local v107 = v105 / v84;
					local v108 = l_AnimationSpeed_0 * -v90 + l_Frequency_0 * 10 * v107 - 0.2 + l__RanNum_0 * 4;
					local v109 = 5 * (l_AnimationSpeed_0 * 0.01 * -v90 / 10 + l_Frequency_0 * v107) + l__RanNum_0 * 4;
					local v110 = 5 * v108;
					local v111 = 1 * v109;
					local v112 = 0 + 0.6283185307179586 * (math.noise(v110, 1.5, v111) + 0.5);
					v111 = 0.5 * v108;
					local v113 = 0.1 * v109;
					local v114 = v112 + (0 + 5.654866776461628 * (math.noise(v111, 1.5, v113) + 0.5));
					v112 = (l_MinRadius_0 + (l_MaxRadius_1 - l_MinRadius_0) * (math.noise(3.4, v109, v108) + 0.5)) * l_RadialProfileFunction_0(v107);
					v110 = l_MinThicknessMultiplier_1 + (l_MaxThicknessMultiplier_0 - l_MinThicknessMultiplier_1) * (math.noise(2.3, v109, v108) + 0.5);
					v111 = l_SpaceCurveFunction_0(v107, l_WorldPosition_0, v99, v100, l_WorldPosition_1);
					v113 = v105 ~= v84 and (CFrame.new(l_v102_1, v111) * CFrame.Angles(0, 0, v114) * CFrame.Angles(math.acos((math.clamp(6.123233995736766E-17 + 0.9999999999999999 * (math.noise(v109, v108, 2.7) + 0.5), -1, 1))), 0, 0) * CFrame.new(0, 0, -v112)).Position or v111;
					v80:_UpdateGeometry(v106, v107, v90, v110, l_v102_0, v113);
					v80:_UpdateColor(v106, v107, v90);
					l_v102_0 = v113;
					l_v102_1 = v111;
				end;
			else
				v80:Destroy();
			end;
		elseif v80._PartsHidden == false then
			v80._PartsHidden = true;
			v80:_Disable();
		end;
	end;
	debug.profileend();
end);
return v32;
