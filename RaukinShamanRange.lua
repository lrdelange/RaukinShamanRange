RaukinShamanRange = CreateFrame("Frame","RaukinShamanRange")

RaukinShamanRange:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

media = LibStub("LibSharedMedia-3.0")

RaukinShamanRange:RegisterEvent("ADDON_LOADED")

function RaukinShamanRange.ADDON_LOADED(self,event,arg1)
	if arg1=="RaukinShamanRange" then

	local a,b = UnitClass("player")
		if b=="SHAMAN" then
			RaukinShamanRangeDB = RaukinShamanRangeDB or {}
			RaukinShamanRangeDB.Moveable = RaukinShamanRangeDB.Moveable or false
			RaukinShamanRangeDB.FrameScale = RaukinShamanRangeDB.FrameScale or 1
			RaukinShamanRangeDB.FontSize = RaukinShamanRangeDB.FontSize or 14
			RaukinShamanRangeDB.ShowWhen = RaukinShamanRangeDB.ShowWhen or "In Party"

			-------------------------------Create Frame------------------------------------------
			
			

			RaukinShamanRange.MakeOptions()
			RaukinShamanRange:SetScript("OnUpdate", RaukinShamanRange.Onupdate)
		else
            		RaukinShamanRange:UnregisterEvent("ADDON_LOADED")
            		return
		end
	end
end

function RaukinShamanRange.Onupdate()

end

function RaukinShamanRange.UpdateFrame()

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
                        get = function(info) return RaukinShamanRangeDB.Moveable end,
                        set = function(info, s) RaukinShamanRangeDB.Moveable = s; RaukinShamanRange.UpdateFrame(); end,
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