--HUGE THANKS TO CHRIS LAD. (orignal uploader.)
--Silent#7114 you're not a dev, you're a skid without the capabilties to credit people < Also telling people to kys ins't great.
--Thanks andy for helping me figure out a loop to then get this to where its at now.
--Thanks jesus for not only coming in and not only debugging but becoming a second helping hands on this project <3
--Thanks lance I took your autoload mb
--Thanks ren + murten for the player throttler. i love you all



util.keep_running()
util.require_natives(1651208000)

---VVVV all of this was stolen off of lance.

-- disable idiot proof if you are an idiot or actually know what you are doing and start MB on its own
local idiot_proof = true

-- change this if you know what you are doing and maybe speak a different language 
local your_fucking_language = "en"
local main_mb_path = "Stand>Lua Scripts>MusinessBanager"
local relative_lang_path = ">Language"
local relative_special_cargo_path = ">Special Cargo"
local max_crate_sourcing_amount_path = ">Special Cargo>Max Crate Sourcing Amount"
local minimize_delivery_time_path = ">Special Cargo>Minimize Delivery Time"
local find_safer_ways = ">Find safer ways to make money"

local settings_bullshit = {
    noidlekick = "on",
    noidlecam = "on",
    monitorcargo = "on",
    maxsellcargo = "on",
    nobuycdcargo = "on",
    nosellcdcargo = "on",
    autocompletespecialbuy = "on",
    autocompletespecialsell = "on"
}

function does_path_exist(path)
    success, error_msg = pcall(menu.ref_by_path, path)
    return success
end

local mb_dir = filesystem.scripts_dir() .. '\\MusinessBanager.lua'
if not filesystem.exists(mb_dir) and not SCRIPT_SILENT_START then
    util.toast("Install Musiness Banager before using this.")
    util.stop_script()
end

function wait_until_path_is_available(path, message)
    while true do
        if not does_path_exist(path) and not SCRIPT_SILENT_START then util.toast(message) else break end
        util.yield()
    end
end

-- credits to https://stackoverflow.com/questions/10989788/format-integer-in-lua
function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

if idiot_proof and not does_path_exist(main_mb_path .. find_safer_ways) then
    menu.trigger_commands("luamusinessbanager")
    wait_until_path_is_available(main_mb_path .. relative_lang_path, "Waiting for MB to initialize...")
    menu.trigger_commands("mblang " .. your_fucking_language)
    wait_until_path_is_available(main_mb_path .. relative_special_cargo_path, "Waiting for MB to load your language. If you see a warning, accept it.")
    util.toast("Initialization done.")
else
    if not SCRIPT_SILENT_START then 
        util.toast("MB is already loaded. Nice!")
    end
end



MenuA =  menu.action
MenuL = menu.list
MenuR = menu.my_root()


--root list
menu.divider(menu.my_root(), "Special Crate related")
MoneyRoot = MenuL(MenuR, "Money Making", {}, "")
GenRoot = MenuL(MenuR, "General Features", {}, "random stuff i threw in here.")
TpRoot = MenuL(MenuR, "Teleports")
LogRoot = menu.list(menu.my_root(), "Change Log", {}, "Change log + Version. ")
CreditRoot = MenuL(MenuR, "Credits", {}, "People who helped/supported.")

--root list end

--load text
local YOURUSERNAME = "kool kid"
util.toast("Loaded ilanas skidded script !\nYou're a "..YOURUSERNAME.."")
--end load text

-----------------------------------------------------------------------------------------------------------------------------------------

--Begin Change+Ver Log
menu.readonly(LogRoot, "Implementing new features")
menu.readonly(LogRoot, "added sell delays")
menu.readonly(LogRoot, "stabalised sell loop slightly")
menu.divider(LogRoot, "Script Version")
menu.readonly(LogRoot, "version 0.0.4")
--end change+ver log

--Begin credits
menu.action(CreditRoot, "you", {""}, "", function(on_click)
	util.toast("Thank you, yes you. for using my shitty skidded script")
end)

menu.action(CreditRoot, "chris", {""}, "", function(on_click)
	util.toast("Thank you ChrisLad#9487 for uploading the script originally")
end)

menu.action(CreditRoot, "Icy+Vsus", {""}, "", function(on_click)
	util.toast("Huge thanks to vsus/ren and IcyPhoneix for making MB in the first place.")
end)

menu.action(CreditRoot, "Andy", {""}, "", function(on_click)
    util.toast("Big thanks to Anwy for the help aswell as teaching me certain things.")
end) 

menu.action(CreditRoot, "Jesus", {""}, "", function(on_click)
    util.toast("Thank you Jesus_is_cap for helping with coding + debugging!")
end)

menu.action(CreditRoot, "Ren", {""}, "", function(on_click)
    util.toast("Thank you Ren for the motivation to work on this. <3")
end)

menu.action(CreditRoot, "someoneIdfk", {""}, "", function(on_click)
    util.toast("Thank you SomeoneIdfk for helping/tips overall.")
end)

--End Credits

-----------------------------------------------------------------------------------------------------------------------------------------

--Start tp Section
menu.divider(TpRoot, "FPS TPs to stop transError")
menu.action(TpRoot, "TP | Hanger", {"tphanger"}, "", function(on_click)
	local me = PLAYER.PLAYER_PED_ID()
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(me, -930.89166, -2947.7917, 25.594482, 0, 0, 0)
end)

menu.action(TpRoot, "TP | Gods Thumb", {"tpgodthumb"}, "", function(on_click)
	local me = PLAYER.PLAYER_PED_ID()
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(me, -986.18774, 6253.837, 2.682039, 0, 0, 0)
end)

menu.action(TpRoot, "TP | Cable Cart", {"tpcable"}, "", function(on_click)
	local me = PLAYER.PLAYER_PED_ID()
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(me, 413.31113, 5572.6914, 779.84125, 0, 0, 0)
end)

menu.action(TpRoot, "TP | Avi's hut", {"tpavihut"}, "", function(on_click)
	local me = PLAYER.PLAYER_PED_ID()
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(me, -2169.1309, 5195.2827, 16.880398, 0, 0, 0)
end)
--End tp Section

-----------------------------------------------------------------------------------------------------------------------------------------------

--Start Jerry Script Skidded Code
local Int_PTR = memory.alloc_int()

    local function getMPX()
        return 'MP'.. util.get_char_slot() ..'_'
    end

    local function STAT_GET_INT(Stat)
        STATS.STAT_GET_INT(util.joaat(getMPX() .. Stat), Int_PTR, -1)
        return memory.read_int(Int_PTR)
    end

--End Jerry Script Skidded Code

-----------------------------------------------------------------------------------------------------------------------------------------------

--Start MB cargo Help 

function Cleanser()
	local ct = 0
	for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
		entities.delete_by_handle(ent)
		ct = ct + 1
	end
	for k,ent in pairs(entities.get_all_peds_as_handles()) do
		if not is_ped_player(ent) then
			entities.delete_by_handle(ent)
		end
		ct = ct + 1
	end
	for k,ent in pairs(entities.get_all_objects_as_handles()) do
		entities.delete_by_handle(ent)
		ct = ct + 1
	end
end
	

function resupply()
    STATS._SET_PACKED_STAT_BOOL(32359 + 0, true,  util.get_char_slot())
    memory.write_int(memory.script_global(2689235 + 1 + (players.user() * 453) + 318 + 6), -1)
end

function sell()
    menu.trigger_commands("sellacrate")
    util.yield(speed)
end

function TELEPORT(X, Y, Z)
	local Handle = PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) or players.user_ped()
	ENTITY.SET_ENTITY_COORDS(Handle, X, Y, Z)
end

function SET_HEADING(Heading)
	ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
end

function tpfps()
	TELEPORT(11201.99147, 12563.64814, 2665.666)
	SET_HEADING(270)
end

menu.toggle_loop(MoneyRoot, "Remove transaction pending", {"Transaction pending"}, "Use if Transaction pending is fucking with you", function(on_click)
    menu.trigger_commands("removetransactionpending")
end)

    menu.slider(MoneyRoot, "Sell Speed", {"mbcspeed"}, "Modify Sell Speed (in miliseconds)",900,4650, tonumber(0), 25, function(speed_value)
    util.yield()
    speed = speed_value
end)

CrateSellLoop = menu.toggle_loop(MoneyRoot, "Crate Sell Loop", {"sourceloop"}, "Make sure to set a loop speed before enabling this", function(on_click)
	if util.is_session_started() and not util.is_session_transition_active() then
	tpfps()
	Cleanser()
	sell()
	end
    if STAT_GET_INT("CONTOTALFORWHOUSE0",12) <= 5 then
    util.yield(0)
    resupply()
end
end)

menu.toggle_loop(MoneyRoot, "No RP", {"NoRP"}, "", function(on_click)
    util.draw_debug_text("RP Disabled")
    memory.write_float(memory.script_global(262145 + 1), 0)
end, function()
    memory.write_float(memory.script_global(262145 + 1), 1)
end)

menu.action(MoneyRoot, "Source Crates", {"sourcecrate"}, "Will source crates for Warehouse in slot 0", function()
    if util.is_session_started() and not util.is_session_transition_active() then
        STATS._SET_PACKED_STAT_BOOL(32359 + 0, true, util.get_char_slot())
        memory.write_int(memory.script_global(2689235 + 1 + (players.user() * 453) + 318 + 6), -1)
    end
end)

--End MB cargo  help

-----------------------------------------------------------------------------------------------------------------------------------------------

--Unstuck shit
local temoin = 0
util.create_tick_handler(function()
    while menu.get_value(CrateSellLoop) do
        local n = STAT_GET_INT("CONTOTALFORWHOUSE0",12)
        util.yield(speed)
        if n == STAT_GET_INT("CONTOTALFORWHOUSE0",12) then
            temoin = temoin + 1
            if temoin >= 3 then
                menu.trigger_commands("sourcecrate")
                temoin = 0
            end
        else
            temoin = 0
        end
    end
end)

local temoin = 0
util.create_tick_handler(function()
    while menu.get_value(CrateSellLoop) do
        local n = STAT_GET_INT("CONTOTALFORWHOUSE0",12)
        util.yield(speed)
        if n == STAT_GET_INT("CONTOTALFORWHOUSE0",12) then
            temoin = temoin + 1
            if temoin >= 5 then
                menu.trigger_commands("go solo")
                temoin = 0
            end
        else
            temoin = 0
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------------

--Start GenStuff
---Cleanse Start
	 menu.action(GenRoot, "Cleanser", {"pclean"}, "Uses stand API to delete EVERY entity it finds (This may or may not break certain stuff, be careful when using it)", function(on_click)
	local ct = 0
	for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
		entities.delete_by_handle(ent)
		ct = ct + 1
	end
	for k,ent in pairs(entities.get_all_peds_as_handles()) do
		if not is_ped_player(ent) then
			entities.delete_by_handle(ent)
		end
		ct = ct + 1
	end
	for k,ent in pairs(entities.get_all_objects_as_handles()) do
		entities.delete_by_handle(ent)
		ct = ct + 1
	end
	util.toast("ilana's cleaner is complete! " .. ct .. " entities removed :}")
end)
function is_ped_player(ped)
    if PED.GET_PED_TYPE(ped) >= 4 then
        return false
    else
        return true
    end
end
---Cleanse End


--Custom Alert
local function custom_alert(l1) -- set your own R* alert
    poptime = os.time()
    while true do
        if PAD.IS_CONTROL_JUST_RELEASED(18, 18) then
            if os.time() - poptime > 0.1 then
                break
            end
        end
        native_invoker.begin_call()
        native_invoker.push_arg_string("ALERT")
        native_invoker.push_arg_string("JL_INVITE_ND")
        native_invoker.push_arg_int(2)
        native_invoker.push_arg_string("")
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(-1)
        native_invoker.push_arg_int(-1)
        native_invoker.push_arg_string(l1)
        native_invoker.push_arg_int(0)
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(0)
        native_invoker.end_call("701919482C74B5AB")
        util.yield()
    end
end

menu.action(GenRoot, "Custom Alert", {"ralert"}, "", function(on_click) menu.show_command_box("ralert ") end, function(text)
    custom_alert(text)
end)
--Custom Alert end

--Player slots start
menu.slider(GenRoot, "max players", {"maxplayers"}, "set the max players for the lobby\nonly works when host\ncredit to Ren#5219 for discovering this + murten for being amazing", 1, 32, 32, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(0, value)
        notification.notify("free slots",NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(0))
    end
end)
menu.slider(GenRoot, "max spectators", {"maxSpectators"}, "set the max spectators for the lobby\nonly works when host\ncredit to Ren#5219 for discovering this + murten for being amazing", 0, 2, 2, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(4, value)
        notification.notify("free slots",NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(4))
    end
end)
--Player slots end
