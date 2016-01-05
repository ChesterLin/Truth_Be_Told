--[[Based on Antimage Blink from SpellLibrary
    Original Author: Amused/D3luxe
    Date: 12/25/2015]]
    
function Flash(keys)
    local point = keys.target_points[1]
    local caster = keys.caster
    local casterPos = caster:GetAbsOrigin()
    local difference = point - casterPos
    local ability = keys.ability
    local range = ability:GetLevelSpecialValueFor("range", (ability:GetLevel() - 1))

    if difference:Length2D() > range then
        point = casterPos + (point - casterPos):Normalized() * range
    end

    FindClearSpaceForUnit(caster, point, false)
    ProjectileManager:ProjectileDodge(caster)
    
    local blinkIndex = ParticleManager:CreateParticle("particles/summoner/summoner_spell_flash_end.vpcf", PATTACH_ABSORIGIN, caster)
    
    Timers:CreateTimer({
        endTime = 1, 
        callback = function()
            ParticleManager:DestroyParticle( blinkIndex, false )
            return nil
        end
    })
end
