local ItemsHelper = {}

ItemsHelper.MenuPath = {"Utility", "Items Helper"}
ItemsHelper.MEnabled = Menu.AddOptionBool(ItemsHelper.MenuPath, "Enabled", false)
ItemsHelper.MBlink = Menu.AddOptionBool(ItemsHelper.MenuPath, "Max Blink Range", false)
ItemsHelper.LocalHero = nil

function ItemsHelper.ResetVars()
	ItemsHelper.LocalHero = nil
end

function Extend(p1, p2, p3)
	return p1 + ((p2 - p1):Normalized():Scaled(p3))
end

function ItemsHelper.CheckBlink(p1, p2, p3, p4)
	if p4 == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION and p1 ~= nil and p1 ~= 0 and Entity.IsEntity(p1) and Ability.GetName(p1) == 'item_blink' then	
		local k1 = Entity.GetAbsOrigin(p3)
		k3 = p2:Distance(k1):Length()
		if k3 < 1200 then return false end
		Ability.CastAbilityPosition(p1, Extend(k1, p2, 1199))
		return true
	end
end

function ItemsHelper.OnPrepareUnitOrders(p1)
	if Menu.IsEnabled(ItemsHelper.MEnabled) == false or ItemsHelper.LocalHero == nil or p1 == nil then return end

	if Menu.IsEnabled(ItemsHelper.MBlink) and ItemsHelper.CheckBlink(p1.ability, p1.position, p1.npc, p1.order) then
		return false
	end

	return true
end

function ItemsHelper.OnUpdate(p1)
	ItemsHelper.LocalHero = Heroes.GetLocal()
	if ItemsHelper.LocalHero == nil then return end
	
end

function ItemsHelper.OnGameStart()
	ItemsHelper.ResetVars()
end

function ItemsHelper.OnGameEnd()
	ItemsHelper.ResetVars()
end

return ItemsHelper