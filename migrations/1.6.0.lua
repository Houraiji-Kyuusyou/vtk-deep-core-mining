-- Apply unlocks and bonuses if already researched (case of loading an existing savegame)
for i, force in pairs(game.forces) do 
	force.reset_recipes()
	force.reset_technology_effects()
end