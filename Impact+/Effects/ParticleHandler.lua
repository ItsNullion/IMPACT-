local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("RunService");
local _ = {};
local v4 = {};
local function v9(v5, v6, v7) --[[ Line: 9 ]] --[[ Name: ShiftValueWithRatio ]]
	if v6 == 0 then
		return v5;
	else
		local v8 = v5 * v7 + v6;
		if v8 < 0 then
			v8 = v8 + v7;
		end;
		return v8 % v7 / (v7 - 1);
	end;
end;
local function v13(v10, v11) --[[ Line: 19 ]] --[[ Name: ShiftValue ]]
	if v11 == 0 then
		return v10;
	else
		local v12 = v10 + v11;
		if v12 < 0 then
			v12 = v12 + 360;
		end;
		return v12 % 360 / 359;
	end;
end;
local function v25(v14, v15) --[[ Line: 27 ]] --[[ Name: HSVShift ]]
	local v16, v17, v18 = v14:ToHSV();
	local v19 = if v15.V2Shift then v9 else v13;
	local v20 = v15.Hue and v15.Hue > 9000000000 or v15.HueShift and v15.HueShift > 9000000000;
	local v21 = v15.Hue and v15.Hue == "nan" or v15.HueShift and v15.HueShift == "nan";
	local v22 = v15.Hue or v19(v16, v15.HueShift or 0, 360);
	local v23 = v15.Saturation or v19(v17, v15.SaturationShift or 0, 256);
	local v24 = v15.Value or v19(v18, v15.ValueShift or 0, 256);
	v22 = math.clamp(v22, 0, 1);
	v23 = math.clamp(v23, 0, 1);
	v24 = math.clamp(v24, 0, 1);
	return v20 and Color3.new(1, 1, 1) or v21 and Color3.new() or Color3.fromHSV(v22, v23, v24);
end;
local function v32(v26, v27) --[[ Line: 45 ]] --[[ Name: HueShift ]]
	local v28, v29, v30 = v26:ToHSV();
	local v31 = v28 + v27 / 360;
	if v31 > 1 then
		v31 = v31 - 1;
	end;
	return Color3.fromHSV(v31, v29, v30);
end;
local function _(v33) --[[ Line: 55 ]] --[[ Name: CCR ]]
	return v33 % 1;
end;
local function v39(v35) --[[ Line: 61 ]] --[[ Name: GenerateCode ]]
	local v36 = "";
	local v37 = type(v35) == "number" and v35 >= 5 and v35 or 5;
	for _ = 1, v37 do
		v36 = v36 .. string.char(math.random(65, 90));
	end;
	return v36;
end;
v4.HueShift = function(v40, v41) --[[ Line: 70 ]] --[[ Name: HueShift ]]
	local l_Color_0 = v40.Color;
	if typeof(l_Color_0) == "ColorSequence" then
		local v43 = {};
		for v44 = 1, #l_Color_0.Keypoints do
			local v45, v46, v47 = l_Color_0.Keypoints[v44].Value:ToHSV();
			local v48 = v45 + v41 / 360;
			if v48 > 1 then
				v48 = v48 - 1;
			end;
			local v49 = Color3.fromHSV(v48, v46, v47);
			table.insert(v43, ColorSequenceKeypoint.new(l_Color_0.Keypoints[v44].Time, v49));
		end;
		return ColorSequence.new(v43);
	elseif typeof(l_Color_0) == "Color3" then
		return v32(l_Color_0, v41);
	else
		return;
	end;
end;
v4.HueShiftParticles = function(v50, v51) --[[ Line: 85 ]] --[[ Name: HueShiftParticles ]]
	for _, v53 in ipairs(v50:GetDescendants()) do
		if not v53:GetAttribute("IgnoreShift") and (v53:IsA("ParticleEmitter") or v53:IsA("Trail")) then
			v53.Color = v4.HueShift(v53, v51);
		end;
	end;
end;
v4.HSVShift = function(v54, v55) --[[ Line: 92 ]] --[[ Name: HSVShift ]]
	if typeof(v54) == "ColorSequence" then
		local v56 = {};
		for v57 = 1, #v54.Keypoints do
			local l_Value_0 = v54.Keypoints[v57].Value;
			local v59 = v25(l_Value_0, v55);
			table.insert(v56, ColorSequenceKeypoint.new(v54.Keypoints[v57].Time, v59));
		end;
		return ColorSequence.new(v56);
	elseif typeof(v54) == "Color3" then
		return (v25(v54, v55));
	else
		return;
	end;
end;
v4.HSVShiftParticles = function(v60, v61) --[[ Line: 107 ]] --[[ Name: HSVShiftParticles ]]
	for _, v63 in ipairs(v60:GetDescendants()) do
		if not v63:GetAttribute("IgnoreShift") then
			if v63:IsA("ParticleEmitter") or v63:IsA("Trail") or v63:IsA("Beam") or v63:IsA("Light") or v63:IsA("Sparkles") or v63:IsA("Smoke") then
				v63.Color = v4.HSVShift(v63.Color, v61);
			elseif v63:IsA("Fire") then
				v63.Color = v4.HSVShift(v63.Color, v61);
				v63.SecondaryColor = v4.HSVShift(v63.SecondaryColor, v61);
			end;
		end;
	end;
end;
v4.HueShiftModel = function(v64, v65) --[[ Line: 119 ]] --[[ Name: HueShiftModel ]]
	for _, v67 in ipairs(v64:GetDescendants()) do
		if not v67:GetAttribute("IgnoreShift") and v67:IsA("BasePart") then
			local v68, v69, v70 = v67.Color:ToHSV();
			local v71 = v68 + v65 / 360;
			if v71 > 1 then
				v71 = v71 - 1;
			end;
			v67.Color = Color3.fromHSV(v71, v69, v70);
		end;
	end;
end;
v4.HSVShiftModel = function(v72, v73) --[[ Line: 128 ]] --[[ Name: HSVShiftModel ]]
	for _, v75 in ipairs(v72:GetDescendants()) do
		if not v75:GetAttribute("IgnoreShift") and v75:IsA("BasePart") then
			v75.Color = v4.HSVShift(v75.Color, v73);
		end;
	end;
end;
v4.ChangeProperties = function(v76, v77) --[[ Line: 137 ]] --[[ Name: ChangeProperties ]]
	for v78, v79 in pairs(v77) do
		v76[v78] = v79;
	end;
end;
v4.AttachTo = function(v80, v81) --[[ Line: 143 ]] --[[ Name: AttachTo ]]
	if type(v81) ~= "table" then
		return;
	elseif not v81.Part or not v81.Part:IsDescendantOf(workspace) then
		return;
	elseif v80:IsA("Model") and not v80.PrimaryPart then
		warn(v80, "needs a PrimaryPart");
		return;
	else
		local l_Part_0 = v81.Part;
		local v83 = v4.TranslateToCFrame(v81.Offset);
		if v80:IsA("Model") then
			v80 = v80.PrimaryPart;
		end;
		v80.Anchored = false;
		v80.CanCollide = false;
		v80.Massless = true;
		local v84 = Instance.new(v81.UseMotor6D and "Motor6D" or "Weld");
		v84.Part0 = v81.MakePartP0 and l_Part_0 or v80;
		v84.Part1 = v81.MakePartP0 and v80 or l_Part_0;
		v84.Parent = v81.MakePartParent and l_Part_0 or v80;
		if v83 then
			v84.C0 = v84.C0 * v83;
		end;
		if v81.Duration then
			task.delay(v81.Duration, v84.Destroy, v84);
		end;
		return v84;
	end;
end;
v4.AttachParticle = function(v85, v86, v87) --[[ Line: 174 ]] --[[ Name: AttachParticle ]]
	v87 = v87 or {};
	v87.Part = v86;
	v87.Offset = v87.C0;
	return v4.AttachTo(v85, v87);
end;
v4.MoveTo = function(v88, v89) --[[ Line: 181 ]] --[[ Name: MoveTo ]]
	if not v89 then
		return;
	elseif v88:IsA("Model") and not v88.PrimaryPart then
		warn(v88, "needs a PrimaryPart");
		return;
	elseif v88:IsA("Model") then
		v88:PivotTo(v89);
		return;
	else
		v88.CFrame = v89;
		return;
	end;
end;
v4.TranslateToCFrame = function(v90) --[[ Line: 191 ]] --[[ Name: TranslateToCFrame ]]
	if typeof(v90) == "CFrame" then
		return v90;
	elseif typeof(v90) == "Vector3" then
		return CFrame.new(v90);
	else
		if typeof(v90) == "Instance" then
			if v90:IsA("BasePart") then
				return v90.CFrame;
			elseif v90:IsA("Attachment") then
				return v90.WorldCFrame;
			elseif v90:IsA("Model") then
				local v91 = v90:FindFirstChild("Torso") or v90.PrimaryPart;
				if v91 then
					return v91.CFrame;
				else
					for _, v93 in ipairs(v90:GetDescendants()) do
						if v93:IsA("BasePart") then
							return v93.CFrame;
						end;
					end;
				end;
			end;
		end;
		return;
	end;
end;
v4.GenerateEmitInfo = function(v94) --[[ Line: 212 ]] --[[ Name: GenerateEmitInfo ]]
	local v95 = {};
	for _, v97 in ipairs(v94:GetDescendants()) do
		if v97:IsA("ParticleEmitter") then
			local v98 = v39(5);
			v97.Name = v98;
			v95[v98] = {
				State = "Emit", 
				EmitAmount = v97:GetAttribute("EmitCount") or 16, 
				EmitDelay = v97:GetAttribute("EmitDelay") or 0, 
				EmitDuration = v97:GetAttribute("EmitDuration") or 0
			};
		end;
	end;
	return v95;
end;
v4.Emit = function(v99, v100) --[[ Line: 230 ]] --[[ Name: Emit ]]
	for _, v102 in ipairs(v99:GetDescendants()) do
		if v102:IsA("ParticleEmitter") then
			local v103 = v100[v102.Name];
			if v103 then
				if v103.HueShift then
					v102.Color = v4.HueShift(v102, v103.HueShift);
				end;
				local v104 = v103.EmitDelay or v103.Delay;
				local v105 = v103.EmitAmount or v103.Emit;
				local v106 = v103.EmitDuration or v103.Duration;
				if v104 and v104 > 0 then
					task.delay(v104, function() --[[ Line: 240 ]]
						v102:Emit(v105);
						if v106 and v106 > 0 then
							v102.Enabled = true;
							task.delay(v106, function() --[[ Line: 244 ]]
								v102.Enabled = false;
							end);
						end;
					end);
				else
					v102:Emit(v105);
					v102.Enabled = true;
					task.delay(v106, function() --[[ Line: 252 ]]
						v102.Enabled = false;
					end);
				end;
			end;
		end;
	end;
end;
v4.EmitFromAttribute = function(v107) --[[ Line: 260 ]] --[[ Name: EmitFromAttribute ]]
	for _, v109 in v107:GetDescendants() do
		if v109:IsA("ParticleEmitter") and v109:GetAttribute("EmitCount") then
			if v109:GetAttribute("EmitDelay") then
				task.delay(v109:GetAttribute("EmitDelay"), function() --[[ Line: 265 ]]
					v109:Emit(v109:GetAttribute("EmitCount"));
				end);
			else
				v109:Emit(v109:GetAttribute("EmitCount"));
			end;
		end;
	end;
end;
v4.GetMaxLifetime = function(v110) --[[ Line: 274 ]] --[[ Name: GetMaxLifetime ]]
	if v110:GetAttribute("Lifetime") then
		return v110:GetAttribute("Lifetime");
	else
		local v111 = 0;
		for _, v113 in pairs(v110:GetDescendants()) do
			if v113:IsA("ParticleEmitter") then
				local v114 = v113:GetAttribute("EmitDuration") or 0;
				local v115 = v113:GetAttribute("EmitDelay") or 0;
				local v116 = (v113.Lifetime.Max + v114 + v115) / v113.TimeScale;
				if v113:GetAttribute("Lifetime") then
					v116 = math.max(v116, v113:GetAttribute("Lifetime"));
				end;
				if v111 < v116 and v116 < 1e999 then
					v111 = v116;
				end;
			end;
		end;
		return v111;
	end;
end;
v4.DestroyEmit = function(v117, v118) --[[ Line: 295 ]] --[[ Name: DestroyEmit ]]
	if not v117 then
		return;
	else
		local v119 = v118 or v4.GetMaxLifetime(v117);
		task.delay(v119, function() --[[ Line: 298 ]]
			local v120 = v118 or v4.GetMaxLifetime(v117);
			if v119 < v120 then
				task.delay(math.clamp(v120, v119, v119 * 5), v117.Destroy, v117);
				return;
			else
				v117:Destroy();
				return;
			end;
		end);
		return v119;
	end;
end;
v4._ScaleParticle = function(v121, v122) --[[ Line: 309 ]] --[[ Name: _ScaleParticle ]]
	local l_Size_0 = v121.Size;
	local l_Speed_0 = v121.Speed;
	if typeof(l_Size_0) == "NumberSequence" then
		local v125 = {};
		for v126 = 1, #l_Size_0.Keypoints do
			local v127 = l_Size_0.Keypoints[v126];
			local v128 = v127.Value * v122;
			local v129 = v127.Envelope * v122;
			local l_Time_0 = v127.Time;
			table.insert(v125, NumberSequenceKeypoint.new(l_Time_0, v128, v129));
		end;
		v121.Size = NumberSequence.new(v125);
	end;
	v121.Speed = NumberRange.new(l_Speed_0.Min * v122, l_Speed_0.Max * v122);
	v121.Acceleration = v121.Acceleration * v122;
end;
v4.ScaleParticle = function(v131, v132) --[[ Line: 337 ]] --[[ Name: ScaleParticle ]]
	for _, v134 in ipairs(v131:GetDescendants()) do
		if v134:IsA("ParticleEmitter") then
			v4._ScaleParticle(v134, v132);
		end;
	end;
	if v131:IsA("ParticleEmitter") then
		v4._ScaleParticle(v131, v132);
	end;
end;
v4.TweenScale = function(v135, v136, v137) --[[ Line: 347 ]] --[[ Name: TweenScale ]]
	local l_Size_1 = v135.Size;
	local l_Speed_1 = v135.Speed;
	task.spawn(function() --[[ Line: 351 ]]
		local v140 = 0;
		for v141 = 1, 60 * v137.Time do
			repeat
				v140 = v140 + task.wait();
			until v140 > 0.016666666666666666;
			v140 = v140 - 0.016666666666666666;
			if v135:IsDescendantOf(game) then
				local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v141 / (60 * v137.Time), v137.EasingStyle, v137.EasingDirection);
				local v143 = 1 + (v136 - 1) * l_l_TweenService_0_Value_0;
				local v144 = {};
				for v145 = 1, #l_Size_1.Keypoints do
					local v146 = l_Size_1.Keypoints[v145];
					v144[v145] = NumberSequenceKeypoint.new(v146.Time, v146.Value * v143, v146.Envelope * v143);
				end;
				v135.Size = NumberSequence.new(v144);
				v135.Speed = NumberRange.new(l_Speed_1.Min * v143, l_Speed_1.Max * v143);
			else
				break;
			end;
		end;
	end);
end;
v4.ScaleLifetime = function(v147, v148) --[[ Line: 383 ]] --[[ Name: ScaleLifetime ]]
	for _, v150 in ipairs(v147:GetDescendants()) do
		if v150:IsA("ParticleEmitter") then
			local v151 = v150.Lifetime.Min / v148;
			local v152 = v150.Lifetime.Max / v148;
			v150.Lifetime = NumberRange.new(v151, v152);
		end;
	end;
end;
v4.EnableParticle = function(v153, v154) --[[ Line: 392 ]] --[[ Name: EnableParticle ]]
	if not v153 then
		return;
	else
		for _, v156 in ipairs(v153:GetDescendants()) do
			if v156:IsA("ParticleEmitter") then
				v156.Enabled = v154;
			end;
		end;
		return v4.GetMaxLifetime(v153);
	end;
end;
v4.EnableParticleBeams = function(v157, v158) --[[ Line: 401 ]] --[[ Name: EnableParticleBeams ]]
	if not v157 then
		return;
	else
		for _, v160 in ipairs(v157:GetDescendants()) do
			if v160:IsA("Beam") then
				v160.Enabled = v158;
			end;
		end;
		return v4.GetMaxLifetime(v157);
	end;
end;
v4.EnableParticleTrails = function(v161, v162, v163) --[[ Line: 410 ]] --[[ Name: EnableParticleTrails ]]
	if not v161 then
		return;
	else
		for _, v165 in ipairs(v161:GetDescendants()) do
			if v165:IsA("Trail") and (typeof(v163) ~= "table" or not table.find(v163, v165.Name)) then
				v165.Enabled = v162;
			end;
		end;
		return v4.GetMaxLifetime(v161);
	end;
end;
v4.EnableAllParticles = function(v166, v167, v168) --[[ Line: 423 ]] --[[ Name: EnableAllParticles ]]
	if not v166 then
		return;
	else
		local l_next_0 = next;
		local l_v166_Descendants_0, v171 = v166:GetDescendants();
		for _, v173 in l_next_0, l_v166_Descendants_0, v171 do
			if (v173:IsA("ParticleEmitter") or v173:IsA("Trail") or v173:IsA("Beam") or v173:IsA("PointLight")) and (not v168 or v173.Name == v168) then
				v173.Enabled = v167;
			end;
		end;
		return v4.GetMaxLifetime(v166);
	end;
end;
v4.DestroyParticle = function(v174, v175) --[[ Line: 439 ]] --[[ Name: DestroyParticle ]]
	if not v174 then
		return;
	else
		local v176 = v175 or v4.GetMaxLifetime(v174);
		task.delay(v176, v174.Destroy, v174);
		return v176;
	end;
end;
v4.EnableVFX = function(v177, v178, v179) --[[ Line: 446 ]] --[[ Name: EnableVFX ]]
	if table.find(v179, v177.ClassName) then
		v177.Enabled = v178;
	end;
	for _, v181 in v177:GetDescendants() do
		if table.find(v179, v181.ClassName) then
			v181.Enabled = v178;
		end;
	end;
end;
v4.UpdateAttributeColors = function(v182, v183) --[[ Line: 457 ]] --[[ Name: UpdateAttributeColors ]]
	v183 = v183 or {};
	if not v182 then
		return;
	else
		for _, v185 in pairs(v182:GetDescendants()) do
			if v185:IsA("ParticleEmitter") then
				for v186, v187 in v183 do
					if typeof(v186) == "string" and v185:GetAttribute(v186) then
						local v188 = typeof(v187);
						if v188 == "Color3" then
							v185.Color = ColorSequence.new(v187);
						elseif v188 == "ColorSequence" then
							v185.Color = v187;
						end;
					end;
				end;
			end;
		end;
		return;
	end;
end;

v4.UpdateGroundColors = function(v190, v191) --[[ Line: 482 ]] --[[ Name: UpdateGroundColors ]]
	if not v191 then
		return;
	else
		v191 = v4.TranslateToCFrame(v191);
		local v192 = workspace:Raycast(v191.Position, Vector3.new(0, -10, 0, 0), v189);
		if v192 then
			local v193, v194, v195 = v192.Instance.Color:ToHSV();
			for _, v197 in v190:GetDescendants() do
				if v197:GetAttribute("UseGroundColor") then
					v197.Color = v4.HSVShift(v197.Color, {
						Hue = v193, 
						Saturation = v194, 
						Value = v195
					});
				end;
			end;
		end;
		return;
	end;
end;
v4.GetHSVShift = function(v198) --[[ Line: 501 ]] --[[ Name: GetHSVShift ]]
	if v198.Metadata.UnusualHueShift then
		return {
			HueShift = v198.Metadata.UnusualHueShift
		};
	else
		return v198.Stats.HSVShift;
	end;
end;
v4.EnableParticles = v4.EnableParticle;
v4.DestroyByMaxLifetime = v4.DestroyParticle;
v4.HSVShiftColor = v4.HSVShift;
return v4;
