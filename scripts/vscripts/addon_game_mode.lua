-- Generated from template

require('timers')

if SummonerSkills == nil then
	SummonerSkills = class({})
end

function Precache( context )
    PrecacheUnitByNameSync("npc_dota_hero_clinkz", context)
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
                hero:AddAbility( "clinkz_wind_walk" )
                local newAbility = hero:FindAbilityByName( "clinkz_wind_walk" )
                if newAbility then
                    newAbility:SetHidden(false)
                    newAbility:SetLevel(1)
                    newAbility:CastAbility()
                    print ("ABILITY COUNT ", hero:GetAbilityCount())
                else
                    print ("FAIL TO SET ABILITY ", i)
                end
            else
                print ("FAIL TO FIND HERO ", i)
            end
        end
        
        return nil
	end
    
	return 0.5
end