//check for any items you may have come across
var item = grid_meeting_getInstance(gx,gy,gridObject_item),
	tile = grid_meeting_getInstance(gx,gy,gridObject_tile);
	
if item != noone and ds_list_size(inventory) < inventorySlots {
	var obj = item.object_index;
	
	//store item's relevant info
	ds_list_add(inventory,obj)
	itemMap_scripts[? obj] = item.itemActionScript
	itemMap_sprites[? obj] = item.sprite_index
	
	//remove item from world
	instance_destroy(item)
	
	if deciderScript == decider_player {
		audio_play_sound(snd_pickup, 0, false)
	}
}

with tile {
	script_execute(steppedOnScript,other.id)
}


gridCharacter_applyStatuses()

//hp regeneration(only for players)
if deciderScript = decider_player{
	var hpRate = 0.05;

	hpRate *= !tookDamage * !gridObject_hasStatus(statuses.poison)

	hp = min(hp+maxHP*hpRate, maxHP)
}

tookDamage = false
myTurn = false