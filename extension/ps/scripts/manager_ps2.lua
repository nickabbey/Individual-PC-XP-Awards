-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

--
-- XP DISTRIBUTION
--


function awardXP(nXP) 
	-- Determine members of party
	local aParty = {};
	for _,v in pairs(DB.getChildren("partysheet.partyinformation")) do
		local sClass, sRecord = DB.getValue(v, "link");
		if sClass == "charsheet" and sRecord then
			local nodePC = DB.findNode(sRecord);
			console(nodePC);
--- NEW: sets local receiveXP to the value of the checkbox named "receivexp" on the PC's charsheet_main 
			local nodePCReceivesXP = DB.getValue("charsheet.receivesxp", 1);
--- NEW: adds condition that nodePCReceivesXP be true
			console(nodePCReceivesXP);
			if nodePC and nodePCReceivesXP then
				local sName = DB.getValue(v, "name", "");
				table.insert(aParty, { name = sName, node = nodePC } );
			end
		end
	end

	-- Determine split
	local nAverageSplit;
	if nXP >= #aParty then
		nAverageSplit = math.floor((nXP / #aParty) + 0.5);
	else
		nAverageSplit = 0;
	end
	local nFinalSplit = math.max((nXP - ((#aParty - 1) * nAverageSplit)), 0);
	
	-- Award XP
	for _,v in ipairs(aParty) do
		local nAmount;
		if k == #aParty then
			nAmount = nFinalSplit;
		else
			nAmount = nAverageSplit;
		end
		
		if nAmount > 0 then
			local nNewAmount = DB.getValue(v.node, "exp", 0) + nAmount;
			DB.setValue(v.node, "exp", "number", nNewAmount);
		end

		v.given = nAmount;
	end
	
	-- Output results
	local msg = {font = "msgfont"};
	msg.icon = "xp";
	for _,v in ipairs(aParty) do
		msg.text = "[" .. v.given .. " XP] -> " .. v.name;
		Comm.deliverChatMessage(msg);
	end

	msg.icon = "portrait_gm_token";
	msg.text = Interface.getString("ps_message_xpaward") .. " (" .. nXP .. ")";
	Comm.deliverChatMessage(msg);
end
