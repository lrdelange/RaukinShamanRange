RaukinShamanRange = CreateFrame("Frame","RaukinShamanRange")

RaukinShamanRange:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

media = LibStub("LibSharedMedia-3.0")

RaukinShamanRange:RegisterEvent("ADDON_LOADED")
RaukinShamanRange:RegisterEvent("PLAYER_ENTER_COMBAT")
RaukinShamanRange:RegisterEvent("PLAYER_REGEN_ENABLED")
RaukinShamanRange:RegisterEvent("PARTY_MEMBERS_CHANGED")

function RaukinShamanRange.ADDON_LOADED(self,event,arg1)
	if arg1=="RaukinShamanRange" then

	local a,b = UnitClass("player")
		if b=="SHAMAN" then
			RaukinShamanRangeDB = RaukinShamanRangeDB or {}
			RaukinShamanRangeDB.Lock = RaukinShamanRangeDB.Lock or false
			RaukinShamanRangeDB.FrameScale = RaukinShamanRangeDB.FrameScale or 1
			RaukinShamanRangeDB.FontSize = RaukinShamanRangeDB.FontSize or 14
			RaukinShamanRangeDB.ShowWhen = RaukinShamanRangeDB.ShowWhen or "In Party"

			RaukinShamanRangeDB.point = RaukinShamanRangeDB.point or "CENTER"
			RaukinShamanRangeDB.posX = RaukinShamanRangeDB.posX or 0
			RaukinShamanRangeDB.posY = RaukinShamanRangeDB.posY or 0

			-------------------------------Create Frame------------------------------------------
			RaukinShamanRangeframe = CreateFrame("Frame",nil,UIParent)
			RaukinShamanRangeframe:SetFrameStrata("HIGH")
			RaukinShamanRangeframe:SetWidth(65*RaukinShamanRangeDB.FrameScale)
			RaukinShamanRangeframe:SetHeight(75*RaukinShamanRangeDB.FrameScale)
			

			BkColor = RaukinShamanRangeframe:CreateTexture(nil,"BACKGROUND")
			BkColor:SetAllPoints(RaukinShamanRangeframe)
			BkColor:SetTexture(0,0,0,1)
			BkColor:SetAlpha(0.5)
			RaukinShamanRangeframe.texture = BkColor

			RaukinShamanRangeframe.Name1 = RaukinShamanRangeframe:CreateFontString(nil,"ARTWORK") 
			RaukinShamanRangeframe.Name1:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
			RaukinShamanRangeframe.Name1:SetPoint("TOPLEFT",2,-2)
			RaukinShamanRangeframe.Name1:SetText("Raukin")
			RaukinShamanRangeframe.Name1:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
			RaukinShamanRangeframe.Name1:SetHeight(RaukinShamanRangeDB.FontSize)
			RaukinShamanRangeframe.Name1:SetJustifyH("LEFT");

			RaukinShamanRangeframe.Name2 = RaukinShamanRangeframe:CreateFontString(nil,"ARTWORK") 
			RaukinShamanRangeframe.Name2:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
			RaukinShamanRangeframe.Name2:SetPoint("TOPLEFT",2,-(2+(1*(75*RaukinShamanRangeDB.FrameScale-2*RaukinShamanRangeDB.FontSize))/3))
			RaukinShamanRangeframe.Name2:SetText("Shamglam")
			RaukinShamanRangeframe.Name2:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
			RaukinShamanRangeframe.Name2:SetHeight(RaukinShamanRangeDB.FontSize)
			RaukinShamanRangeframe.Name2:SetJustifyH("LEFT");

			RaukinShamanRangeframe.Name3 = RaukinShamanRangeframe:CreateFontString(nil,"ARTWORK") 
			RaukinShamanRangeframe.Name3:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
			RaukinShamanRangeframe.Name3:SetPoint("TOPLEFT",2,-(2+(2*(75*RaukinShamanRangeDB.FrameScale-2*RaukinShamanRangeDB.FontSize))/3))
			RaukinShamanRangeframe.Name3:SetText("Bwoop")
			RaukinShamanRangeframe.Name3:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
			RaukinShamanRangeframe.Name3:SetHeight(RaukinShamanRangeDB.FontSize)
			RaukinShamanRangeframe.Name3:SetJustifyH("LEFT");

			RaukinShamanRangeframe.Name4 = RaukinShamanRangeframe:CreateFontString(nil,"ARTWORK") 
			RaukinShamanRangeframe.Name4:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
			RaukinShamanRangeframe.Name4:SetPoint("TOPLEFT",2,-(2+(3*(75*RaukinShamanRangeDB.FrameScale-2*RaukinShamanRangeDB.FontSize))/3))
			RaukinShamanRangeframe.Name4:SetText("Crapmyself")
			RaukinShamanRangeframe.Name4:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
			RaukinShamanRangeframe.Name4:SetHeight(RaukinShamanRangeDB.FontSize)
			RaukinShamanRangeframe.Name4:SetJustifyH("LEFT");

			RaukinShamanRangeframe:SetPoint(RaukinShamanRangeDB.point,RaukinShamanRangeDB.posX,RaukinShamanRangeDB.posY)
			RaukinShamanRangeframe:RegisterForDrag("LeftButton")
			RaukinShamanRangeframe:SetScript("OnDragStart", RaukinShamanRangeframe.StartMoving)
			RaukinShamanRangeframe:SetScript("OnDragStop", 
				function() 
					RaukinShamanRangeframe:StopMovingOrSizing() 
					point, relativeTo, relativePoint, xOfs, yOfs = RaukinShamanRangeframe:GetPoint()
					RaukinShamanRangeDB.point = point
					RaukinShamanRangeDB.posX = xOfs 
					RaukinShamanRangeDB.posY = yOfs 
				end)
			
			LastNow = GetTime()
			RaukinShamanRange.UpdateFrame()
			RaukinShamanRange.MakeOptions()
			RaukinShamanRange:SetScript("OnUpdate", RaukinShamanRange.Onupdate)
		else
            		RaukinShamanRange:UnregisterEvent("ADDON_LOADED")
            		return
		end
	end
end

function RaukinShamanRange.PARTY_MEMBERS_CHANGED(self,event,arg1)
	if RaukinShamanRangeDB.ShowWhen==3 and GetNumPartyMembers() > 0 then
		RaukinShamanRangeframe:Show()
	elseif RaukinShamanRangeDB.ShowWhen==3 and GetNumPartyMembers() == 0 then
		RaukinShamanRangeframe:Hide()
	end
end

function RaukinShamanRange.PLAYER_ENTER_COMBAT(self,event,arg1)
	if RaukinShamanRangeDB.ShowWhen==2 and GetNumPartyMembers() > 0 then
		RaukinShamanRangeframe:Show()
	elseif RaukinShamanRangeDB.ShowWhen==2 and GetNumPartyMembers() == 0 then
		RaukinShamanRangeframe:Hide()
	end
end

function RaukinShamanRange.PLAYER_REGEN_ENABLED(self,event,arg1)
	if RaukinShamanRangeDB.ShowWhen==2 and GetNumPartyMembers() > 0 then
		RaukinShamanRangeframe:Show()
	elseif RaukinShamanRangeDB.ShowWhen==2 and GetNumPartyMembers() == 0 then
		RaukinShamanRangeframe:Hide()
	end
end

function RaukinShamanRange.HasTotemBuff(partyplayer)
	for i=1,40 do
		if (UnitBuff(partyplayer,i)=="Grace of Air" or UnitBuff(partyplayer,i)=="Wrath of Air Totem" or UnitBuff(partyplayer,i)=="Totem of Wrath" or UnitBuff(partyplayer,i)=="Mana Tide Totem") then
			return true
		end
	end
	return false
end

function RaukinShamanRange.Onupdate()
	local now = GetTime()
	if now>LastNow then
		LastNow = GetTime() + 0.5
	
		if RaukinShamanRangeDB.Lock then
			RaukinShamanRangeframe.Name1:SetText(UnitName("party1"))
			RaukinShamanRangeframe.Name2:SetText(UnitName("party2"))
			RaukinShamanRangeframe.Name3:SetText(UnitName("party3"))
			RaukinShamanRangeframe.Name4:SetText(UnitName("party4"))
		end

		if RaukinShamanRange.HasTotemBuff("party1") then
			RaukinShamanRangeframe.Name1:SetTextColor(0,1,0,1)
		else
			if IsItemInRange(21991, "party1")==1 then
				RaukinShamanRangeframe.Name1:SetTextColor(1,1,1,1)
			elseif IsItemInRange(21991, "party1")==0 then
				RaukinShamanRangeframe.Name1:SetTextColor(1,0,0,1)
			end
		end

		if RaukinShamanRange.HasTotemBuff("party2") then
			RaukinShamanRangeframe.Name1:SetTextColor(0,1,0,1)
		else
			if IsItemInRange(21991, "party2")==1 then
				RaukinShamanRangeframe.Name2:SetTextColor(1,1,1,1)
			elseif IsItemInRange(21991, "party2")==0 then
				RaukinShamanRangeframe.Name2:SetTextColor(1,0,0,1)
			end
		end

		if RaukinShamanRange.HasTotemBuff("party3") then
			RaukinShamanRangeframe.Name1:SetTextColor(0,1,0,1)
		else
			if IsItemInRange(21991, "party3")==1 then
				RaukinShamanRangeframe.Name3:SetTextColor(1,1,1,1)
			elseif IsItemInRange(21991, "party3")==0 then
				RaukinShamanRangeframe.Name3:SetTextColor(1,0,0,1)
			end
		end

		if RaukinShamanRange.HasTotemBuff("party4") then
			RaukinShamanRangeframe.Name1:SetTextColor(0,1,0,1)
		else
			if IsItemInRange(21991, "party4")==1 then
				RaukinShamanRangeframe.Name4:SetTextColor(1,1,1,1)
			elseif IsItemInRange(21991, "party4")==0 then
				RaukinShamanRangeframe.Name4:SetTextColor(1,0,0,1)
			end
		end
	end
end

function RaukinShamanRange.UpdateFrame()
	if RaukinShamanRangeDB.Lock then
		RaukinShamanRangeframe:SetMovable(false)
		RaukinShamanRangeframe:EnableMouse(false)
	else
		RaukinShamanRangeframe:SetMovable(true)
		RaukinShamanRangeframe:EnableMouse(true)		
	end

	RaukinShamanRangeframe:SetWidth(65*RaukinShamanRangeDB.FrameScale)
	RaukinShamanRangeframe:SetHeight(75*RaukinShamanRangeDB.FrameScale)

	RaukinShamanRangeframe.Name1:SetPoint("TOPLEFT",2,-2)
	RaukinShamanRangeframe.Name1:SetText("Raukin")
	RaukinShamanRangeframe.Name1:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
	RaukinShamanRangeframe.Name1:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
	RaukinShamanRangeframe.Name1:SetHeight(RaukinShamanRangeDB.FontSize)
	RaukinShamanRangeframe.Name1:SetJustifyH("LEFT")
	RaukinShamanRangeframe.Name1:SetTextColor(1,1,1,1)

	RaukinShamanRangeframe.Name2:SetPoint("TOPLEFT",2,-(2+(1*(75*RaukinShamanRangeDB.FrameScale-2*RaukinShamanRangeDB.FontSize))/3))
	RaukinShamanRangeframe.Name2:SetText("Shamglam")
	RaukinShamanRangeframe.Name2:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
	RaukinShamanRangeframe.Name2:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
	RaukinShamanRangeframe.Name2:SetHeight(RaukinShamanRangeDB.FontSize)
	RaukinShamanRangeframe.Name2:SetJustifyH("LEFT")
	RaukinShamanRangeframe.Name2:SetTextColor(1,1,1,1)

	RaukinShamanRangeframe.Name3:SetPoint("TOPLEFT",2,-(2+(2*(75*RaukinShamanRangeDB.FrameScale-2*RaukinShamanRangeDB.FontSize))/3))
	RaukinShamanRangeframe.Name3:SetText("Bwoop")
	RaukinShamanRangeframe.Name3:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
	RaukinShamanRangeframe.Name3:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
	RaukinShamanRangeframe.Name3:SetHeight(RaukinShamanRangeDB.FontSize)
	RaukinShamanRangeframe.Name3:SetJustifyH("LEFT")
	RaukinShamanRangeframe.Name3:SetTextColor(1,1,1,1)

	RaukinShamanRangeframe.Name4:SetPoint("TOPLEFT",2,-(2+(3*(75*RaukinShamanRangeDB.FrameScale-2*RaukinShamanRangeDB.FontSize))/3))
	RaukinShamanRangeframe.Name4:SetText("Crapmyself")
	RaukinShamanRangeframe.Name4:SetFont("Fonts\\ARIALN.ttf", RaukinShamanRangeDB.FontSize, "OUTLINE")
	RaukinShamanRangeframe.Name4:SetWidth(65*RaukinShamanRangeDB.FrameScale-4)
	RaukinShamanRangeframe.Name4:SetHeight(RaukinShamanRangeDB.FontSize)
	RaukinShamanRangeframe.Name4:SetJustifyH("LEFT")
	RaukinShamanRangeframe.Name4:SetTextColor(1,1,1,1)
	
	if RaukinShamanRangeDB.ShowWhen==2 and GetNumPartyMembers() > 0 then
		RaukinShamanRangeframe:Show()
	elseif RaukinShamanRangeDB.ShowWhen==2 and GetNumPartyMembers() == 0 then
		RaukinShamanRangeframe:Hide()
	end

	if RaukinShamanRangeDB.ShowWhen==3 and GetNumPartyMembers() > 0 then
		RaukinShamanRangeframe:Show()
	elseif RaukinShamanRangeDB.ShowWhen==3 and GetNumPartyMembers() == 0 then
		RaukinShamanRangeframe:Hide()
	end

	if (RaukinShamanRangeframe:IsShown() and RaukinShamanRangeDB.ShowWhen==4) then
		RaukinShamanRangeframe:Hide()		
	elseif (RaukinShamanRangeframe:IsShown()==nil and RaukinShamanRangeDB.ShowWhen==1) then
		RaukinShamanRangeframe:Show()
	end

end

function RaukinShamanRange.MakeOptions(self)

    local opt = {
		type = 'group',
        name = "RaukinShamanRange",
        args = {},
	}
    opt.args.general = {
        type = "group",
        name = "Addon options",
        order = 1,
        args = {
	     LockTog = {
                type = "group",
                name = "Frame Options",
                guiInline = true,
                order = 1,
                args = {
                    Toggle = {
                        name = "Lock Frame",
                        type = "toggle",
                        order = 1,
                        get = function(info) return RaukinShamanRangeDB.Lock end,
                        set = function(info, s) RaukinShamanRangeDB.Lock = s; RaukinShamanRange.UpdateFrame(); end,
                    },
		    SizeFrame = {
		        name = "Frame Scale",
                        type = "range",
                        order = 2,
                        get = function(info) return RaukinShamanRangeDB.FrameScale end,
                        set = function(info, s) RaukinShamanRangeDB.FrameScale = s; RaukinShamanRange.UpdateFrame(); end,
                        min = 0.5,
                        max = 3,
                        step = 0.1,
		    },
		    FontSize = {
                        name = "Font Size",
                        type = "range",
                        order = 3,
                        get = function(info) return RaukinShamanRangeDB.FontSize end,
                        set = function(info, s) RaukinShamanRangeDB.FontSize = s; RaukinShamanRange.UpdateFrame(); end,
                        min = 8,
                        max = 30,
                        step = 1,
		    },
		    ShowWhen = {
                        type = "select",
                        name = "Show",
                        desc = "Choose when to show",
                        values = {"Always", "In Combat", "In Party", "Never"},
                        order = 4,
                        get = function(info)
                            return RaukinShamanRangeDB.ShowWhen;
                        end,
                        set = function(info, s)
                            RaukinShamanRangeDB.ShowWhen = s; RaukinShamanRange.UpdateFrame();
                        end,
		    },
                },
            },  
        },
    }
    
    local Config = LibStub("AceConfigRegistry-3.0")
    local Dialog = LibStub("AceConfigDialog-3.0")
    
    Config:RegisterOptionsTable("RaukinShamanRange-Bliz", {name = "RaukinShamanRange",type = 'group',args = {} })
    Dialog:SetDefaultSize("RaukinShamanRange-Bliz", 600, 400)
    
    Config:RegisterOptionsTable("RaukinShamanRange-General", opt.args.general)
    Dialog:AddToBlizOptions("RaukinShamanRange-General", "RaukinShamanRange")
    

    SLASH_MBSLASH1 = "/rsr";
    SLASH_MBSLASH2 = "/RaukinShamanRange";
    SlashCmdList["MBSLASH"] = function() InterfaceOptionsFrame_OpenToFrame("RaukinShamanRange") end;
end