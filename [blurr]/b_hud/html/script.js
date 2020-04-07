var hideHud = false

var hideHealth = true
var hideStamina = true
var hideOxygen = true
var healthAmount = 100
var staminaAmount = 100
var oxygenAmount = 100

var currentTime = "Time: 00:00"

// Hud
window.addEventListener('message', (event) => {
	if (event.data.action == 'hideHud') {
		hideHud = event.data.hide;
		UpdateHud()
	} else if (event.data.action == 'updateTime') {
		document.getElementById('timeText').innerHTML = event.data.time;
	} else if (event.data.action == 'updateStats') {
		healthAmount = event.data.health;
		staminaAmount = event.data.stamina;
		oxygenAmount = event.data.oxygen;
		hideHealth = event.data.hideHealth;
		hideStamina = event.data.hideStamina;
		hideOxygen = event.data.hideOxygen;
		UpdateStats()
	} else if (event.data.action == 'updateSeats') {
		
	}
});

function UpdateHud() {
	if (hideHud == true) {
		$('.overlay').hide();
	} else {
		$('.overlay').show();
	}
}

// Player Stats HUD
function UpdateStats() {
	if (hideHealth == true) {
		$('.healthbar').hide();
	} else {
		$('.healthbar').show();
	}

	if (hideStamina == true) {
		$('.staminabar').hide();
	} else {
		$('.staminabar').show();
	}

	if (hideOxygen == true) {
		$('.oxygenbar').hide();
	} else {
		$('.oxygenbar').show();
	}

	document.getElementById('health').style.width = healthAmount + "%";
	document.getElementById('stamina').style.width = staminaAmount + "%";
	document.getElementById('oxygen').style.width = oxygenAmount + "%";
}

// Vehicle Seats