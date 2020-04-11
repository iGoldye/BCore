var hideHud = false

var hideHealth = true
var hideStamina = true
var hideOxygen = true
var healthAmount = 100
var staminaAmount = 100
var oxygenAmount = 100

var currentTime = "Time: 00:00"

var hideSeats = true
let seats = []
var currentSeat = 0;
var redSeat = "-webkit-radial-gradient(center, 6px 6px, rgba(155,0,0,0.9), rgba(255,0,0,0.9))";
var blueSeat = "-webkit-radial-gradient(center, 6px 6px, rgba(0,160,255,0.9), rgba(0,100,255,0.9))";
var greenSeat = "-webkit-radial-gradient(center, 6px 6px, rgba(0,100,0,0.9), rgba(0,60,0,0.9))";

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
		seats = event.data.seats;
		currentSeat = event.data.seat + 2;
		hideSeats = event.data.hide;
		UpdateSeats()
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
function UpdateSeats() {
	ResetSeats()
	if (hideSeats) {
		$('.seats').hide();
	} else {
		$('.seats').show();

		if (seats.length >= 1) {
			document.getElementById('seat1').style.display = "inline-block";
			if (seats[0] == true) {
				document.getElementById('seat1').style.background = redSeat;
			} else {
				document.getElementById('seat1').style.background = greenSeat;
			}
		}
		if (seats.length >= 2) {
			document.getElementById('seat2').style.display = "inline-block";
			if (seats[1] == true) {
				document.getElementById('seat2').style.background = redSeat;
			} else {
				document.getElementById('seat2').style.background = greenSeat;
			}
		}
		if (seats.length >= 3) {
			document.getElementById('seat3').style.display = "inline-block";
			if (seats[2] == true) {
				document.getElementById('seat3').style.background = redSeat;
			} else {
				document.getElementById('seat3').style.background = greenSeat;
			}
		}
		if (seats.length >= 4) {
			document.getElementById('seat4').style.display = "inline-block";
			if (seats[3] == true) {
				document.getElementById('seat4').style.background = redSeat;
			} else {
				document.getElementById('seat4').style.background = greenSeat;
			}
		}
		if (seats.length >= 5) {
			document.getElementById('seat5').style.display = "inline-block";
			if (seats[4] == true) {
				document.getElementById('seat5').style.background = redSeat;
			} else {
				document.getElementById('seat5').style.background = greenSeat;
			}
		}
		if (seats.length >= 6) {
			document.getElementById('seat6').style.display = "inline-block";
			if (seats[5] == true) {
				document.getElementById('seat6').style.background = redSeat;
			} else {
				document.getElementById('seat6').style.background = greenSeat;
			}
		}
		if (seats.length >= 7) {
			document.getElementById('seat7').style.display = "inline-block";
			if (seats[6] == true) {
				document.getElementById('seat7').style.background = redSeat;
			} else {
				document.getElementById('seat7').style.background = greenSeat;
			}
		}
		if (seats.length >= 8) {
			document.getElementById('seat8').style.display = "inline-block";
			if (seats[7] == true) {
				document.getElementById('seat8').style.background = redSeat;
			} else {
				document.getElementById('seat8').style.background = greenSeat;
			}
		}
		if (seats.length >= 9) {
			document.getElementById('seat9').style.display = "inline-block";
			if (seats[8] == true) {
				document.getElementById('seat9').style.background = redSeat;
			} else {
				document.getElementById('seat9').style.background = greenSeat;
			}
		}
		if (seats.length >= 10) {
			document.getElementById('seat10').style.display = "inline-block";
			if (seats[9] == true) {
				document.getElementById('seat10').style.background = redSeat;
			} else {
				document.getElementById('seat10').style.background = greenSeat;
			}
		}
		if (seats.length >= 11) {
			document.getElementById('seat11').style.display = "inline-block";
			if (seats[10] == true) {
				document.getElementById('seat11').style.background = redSeat;
			} else {
				document.getElementById('seat11').style.background = greenSeat;
			}
		}
		if (seats.length >= 12) {
			document.getElementById('seat12').style.display = "inline-block";
			if (seats[11] == true) {
				document.getElementById('seat12').style.background = redSeat;
			} else {
				document.getElementById('seat12').style.background = greenSeat;
			}
		}
		if (seats.length >= 13) {
			document.getElementById('seat13').style.display = "inline-block";
			if (seats[12] == true) {
				document.getElementById('seat13').style.background = redSeat;
			} else {
				document.getElementById('seat13').style.background = greenSeat;
			}
		}
		if (seats.length >= 14) {
			document.getElementById('seat14').style.display = "inline-block";
			if (seats[13] == true) {
				document.getElementById('seat14').style.background = redSeat;
			} else {
				document.getElementById('seat14').style.background = greenSeat;
			}
		}
		if (seats.length >= 15) {
			document.getElementById('seat15').style.display = "inline-block";
			if (seats[14] == true) {
				document.getElementById('seat15').style.background = redSeat;
			} else {
				document.getElementById('seat15').style.background = greenSeat;
			}
		}
		if (seats.length >= 16) {
			document.getElementById('seat16').style.display = "inline-block";
			if (seats[15] == true) {
				document.getElementById('seat16').style.background = redSeat;
			} else {
				document.getElementById('seat16').style.background = greenSeat;
			}
		}
		if (seats.length >= 17) {
			document.getElementById('seat17').style.display = "inline-block";
			if (seats[16] == true) {
				document.getElementById('seat17').style.background = redSeat;
			} else {
				document.getElementById('seat17').style.background = greenSeat;
			}
		}
		if (seats.length >= 18) {
			document.getElementById('seat18').style.display = "inline-block";
			if (seats[17] == true) {
				document.getElementById('seat18').style.background = redSeat;
			} else {
				document.getElementById('seat18').style.background = greenSeat;
			}
		}
		if (seats.length >= 19) {
			document.getElementById('seat19').style.display = "inline-block";
			if (seats[18] == true) {
				document.getElementById('seat19').style.background = redSeat;
			} else {
				document.getElementById('seat19').style.background = greenSeat;
			}
		}
		if (seats.length == 20) {
			document.getElementById('seat20').style.display = "inline-block";
			if (seats[19] == true) {
				document.getElementById('seat20').style.background = redSeat;
			} else {
				document.getElementById('seat20').style.background = greenSeat;
			}
		}
	
		document.getElementById('seat'+currentSeat).style.background = blueSeat;
	}
}

function ResetSeats() {
	document.getElementById('seat1').style.display = "none";
	document.getElementById('seat2').style.display = "none";
	document.getElementById('seat3').style.display = "none";
	document.getElementById('seat4').style.display = "none";
	document.getElementById('seat5').style.display = "none";
	document.getElementById('seat6').style.display = "none";
	document.getElementById('seat7').style.display = "none";
	document.getElementById('seat8').style.display = "none";
	document.getElementById('seat9').style.display = "none";
	document.getElementById('seat10').style.display = "none";
	document.getElementById('seat11').style.display = "none";
	document.getElementById('seat12').style.display = "none";
	document.getElementById('seat13').style.display = "none";
	document.getElementById('seat14').style.display = "none";
	document.getElementById('seat15').style.display = "none";
	document.getElementById('seat16').style.display = "none";
	document.getElementById('seat17').style.display = "none";
	document.getElementById('seat18').style.display = "none";
	document.getElementById('seat19').style.display = "none";
	document.getElementById('seat20').style.display = "none";
}