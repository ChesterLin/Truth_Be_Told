-- Generated from template

require('timers')

if SummonerSkills == nil then
	SummonerSkills = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonGame = SummonerSkills()
	GameRules.AddonGame:InitGameMode()
end

function SummonerSkills:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
end


-- Evaluate the state of the game
function SummonerSkills:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
        CustomGameEventManager:Send_ServerToAllClients("display_timer", {msg="Remaining", duration=10, mode=0, endfade=false, position=0, warning=5, paused=false, sound=true} )
                
        for i=0,9 do
            local player = PlayerResource:GetPlayer(i)
            if player then
                if PlayerResource:GetSelectedHeroID(i) == -1 then
                    player:MakeRandomHeroSelection()
                end
            end
            
            print ("Assign player: ", i)
            
            local hero = PlayerResource:GetSelectedHeroEntity(i)
            if hero then
                hero:AddAbility( "summoner_spell_flash" )
                local newAbility = hero:FindAbilityByName( "summoner_spell_flash" )
                if newAbility then
                    newAbility:SetHidden(true)
                    newAbility:SetLevel(1)
                    print ("ABILITY COUNT ", hero:GetAbilityCount())
                else
                    print ("FAIL TO SET ABILITY ", i)
                end
                
                hero:AddAbility( "summoner_spell_exhaust" )
                local newAbility = hero:FindAbilityByName( "summoner_spell_exhaust" )
                if newAbility then
                    newAbility:SetHidden(true)
                    newAbility:SetLevel(1)
                end
                
            else
                print ("FAIL TO FIND HERO ", i)
            end
        end
        
        return nil
	end
    
	return 0.5
end