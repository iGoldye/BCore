$('.inv_overlay').hide();
var inventory_open = false;

$('.craft_overlay').hide();
var craft_open = false;

$('.trade_overlay').hide();
var trade_open = false;

$('.vehicle_overlay').hide();
var vehicle_open = false;

let inventory = []

let drinks = []
let food = []
let usables = []
let meds = []
let melee = []
let handgun = []
let primary = []

// Inventory
var selectedSlot = "nothing"
var selectedItemName = "nothing"
var selectedItemId = -1
var selectedItemUse = -1
var selectedItemCount = -1

var selectedMelee = 0
var selectedHandgun = 0
var selectedPrimary = 0
var selectedDrink = 0
var selectedFood = 0
var selectedMed = 0
var selectedUsable = 0

var fPressed = 0
var pressed = false

// Crafting


// Trading

// Vehicle

window.addEventListener('message', (event) => {
  if (event.data.action == 'open_inventory') {
    inventory = event.data.items
    drinks = []
    food = []
    usables = []
    meds = []
    melee = []
    handgun = []
    primary = []

    if (inventory != undefined) {
      inventory.forEach(function(item) {
        if (item.use == 1) {
          // Drinks
          drinks.push(item)
    
        } else if (item.use == 2) {
          // Food
          food.push(item)
    
        } else if (item.use == 3 || item.use == 8) {
          // Usable
          usables.push(item)
    
        } else if (item.use == 4) {
          // Medical Supplies
          meds.push(item)
  
        } else if (item.use == 5) {
          // Melee Weapon
          melee.push(item)
  
        } else if (item.use == 6) {
          // Handgun
          handgun.push(item)
  
        } else if (item.use == 7) {
          // Primary Weapon
          primary.push(item)
  
        } else {
          console.log("Unknown item")
        }
      })
      SetupInventory()
    }
  } else if (event.data.action == 'open_crafting') {
    inventory = event.data.items
    if (inventory != undefined) {
      SetupCrafting()
    }
  }
});

function SetupInventory() {
  selectedSlot = "nothing"
  selectedItemName = "nothing"
  selectedItemId = -1
  selectedItemUse = -1
  selectedItemCount = -1

  selectedMelee = 0
  selectedHandgun = 0
  selectedPrimary = 0
  selectedDrink = 0
  selectedFood = 0
  selectedMed = 0
  selectedUsable = 0

  UpdateInventory();
  $('.inv_overlay').show();
  inventory_open = true
}

function UpdateInventory() {
  if (melee[selectedMelee] != undefined) {
    document.getElementById('MeleeImage').src = melee[selectedMelee].image;
    document.getElementById('MeleeName').innerHTML = melee[selectedMelee].n;
  } else {
    document.getElementById('MeleeImage').src = "img/placeholderw.png";
    document.getElementById('MeleeName').innerHTML = "Melee";
  }

  if (handgun[selectedHandgun] != undefined) {
    document.getElementById('HandgunImage').src = handgun[selectedHandgun].image;
    document.getElementById('HandgunName').innerHTML = handgun[selectedHandgun].n;
    document.getElementById('HandgunCount').innerHTML = handgun[selectedHandgun].count;
  } else {
    document.getElementById('HandgunImage').src = "img/placeholderw.png";
    document.getElementById('HandgunName').innerHTML = "Handgun";
    document.getElementById('HandgunCount').innerHTML = 0;
  }

  if (primary[selectedPrimary] != undefined) {
    document.getElementById('PrimaryImage').src = primary[selectedPrimary].image;
    document.getElementById('PrimaryName').innerHTML = primary[selectedPrimary].n;
    document.getElementById('PrimaryCount').innerHTML = primary[selectedPrimary].count;
  } else {
    document.getElementById('PrimaryImage').src = "img/placeholderw.png";
    document.getElementById('PrimaryName').innerHTML = "Primary";
    document.getElementById('PrimaryCount').innerHTML = 0;
  }


  if (meds[selectedMed] != undefined) {
    document.getElementById('MedsImage').src = meds[selectedMed].image;
    document.getElementById('MedsName').innerHTML = meds[selectedMed].n;
    document.getElementById('MedsCount').innerHTML = meds[selectedMed].count;
  } else {
    document.getElementById('MedsImage').src = "img/placeholderi.png";
    document.getElementById('MedsName').innerHTML = "Meds";
    document.getElementById('MedsCount').innerHTML = 0;
  }

  if (usables[selectedUsable] != undefined) {
    document.getElementById('UsablesImage').src = usables[selectedUsable].image;
    document.getElementById('UsablesName').innerHTML = usables[selectedUsable].n;
    document.getElementById('UsablesCount').innerHTML = usables[selectedUsable].count;
  } else {
    document.getElementById('UsablesImage').src = "img/placeholderi.png";
    document.getElementById('UsablesName').innerHTML = "Items";
    document.getElementById('UsablesCount').innerHTML = 0;
  }

  if (food[selectedFood] != undefined) {
    document.getElementById('FoodImage').src = food[selectedFood].image;
    document.getElementById('FoodName').innerHTML = food[selectedFood].n;
    document.getElementById('FoodCount').innerHTML = food[selectedFood].count;
  } else {
    document.getElementById('FoodImage').src = "img/placeholderi.png";
    document.getElementById('FoodName').innerHTML = "Food";
    document.getElementById('FoodCount').innerHTML = 0;
  }

  if (drinks[selectedDrink] != undefined) {
    document.getElementById('DrinksImage').src = drinks[selectedDrink].image;
    document.getElementById('DrinksName').innerHTML = drinks[selectedDrink].n;
    document.getElementById('DrinksCount').innerHTML = drinks[selectedDrink].count;
  } else {
    document.getElementById('DrinksImage').src = "img/placeholderi.png";
    document.getElementById('DrinksName').innerHTML = "Drinks";
    document.getElementById('DrinksCount').innerHTML = 0;
  }
}

window.addEventListener("keydown", function(event){
  if (event.which == 9 || event.which == 27 || event.which == 71) {
    if (inventory_open == true) {
      $('.inv_overlay').hide();
      inventory_open = false;
      $.post('http://b_inventory/closeInventory');
    } else if (craft_open == true) {
      $('.craft_overlay').hide();
      craft_open = false;
      $.post('http://b_inventory/closeCrafting');
    }
  } else if (event.which == 70 && pressed == false) {
    if (selectedSlot != "nothing") {
      pressed = true
      fPressed = event.timeStamp
      document.getElementById(selectedSlot).style.background = "rgba(255, 0, 0, 0.6)";
    }
  }
});

document.getElementById("melee").addEventListener("wheel", function(event) {
  if (event.deltaY < 0) {
    selectedMelee = selectedMelee + 1
  } else if (event.deltaY > 0) {
    selectedMelee = selectedMelee - 1
  }
  
  if (selectedMelee >= melee.length) {
    selectedMelee = 0
  } else if (selectedMelee < 0) {
    selectedMelee = melee.length - 1
  }

  UpdateInventory();
});

document.getElementById("handgun").addEventListener("wheel", function(event) {
  if (event.deltaY < 0) {
    selectedHandgun = selectedHandgun + 1
  } else if (event.deltaY > 0) {
    selectedHandgun = selectedHandgun - 1
  }
  
  if (selectedHandgun >= handgun.length) {
    selectedHandgun = 0
  } else if (selectedHandgun < 0) {
    selectedHandgun = handgun.length - 1
  }

  UpdateInventory();
});

document.getElementById("primary").addEventListener("wheel", function(event) {
  if (event.deltaY < 0) {
    selectedPrimary = selectedPrimary + 1
  } else if (event.deltaY > 0) {
    selectedPrimary = selectedPrimary - 1
  }
  
  if (selectedPrimary >= primary.length) {
    selectedPrimary = 0
  } else if (selectedPrimary < 0) {
    selectedPrimary = primary.length - 1
  }

  UpdateInventory();
});

document.getElementById("meds").addEventListener("wheel", function(event) {
  if (event.deltaY < 0) {
    selectedMed = selectedMed + 1
  } else if (event.deltaY > 0) {
    selectedMed = selectedMed - 1
  }
  
  if (selectedMed >= meds.length) {
    selectedMed = 0
  } else if (selectedMed < 0) {
    selectedMed = meds.length - 1
  }

  UpdateInventory();
});

document.getElementById("usables").addEventListener("wheel", function(event) {
  if (event.deltaY < 0) {
    selectedUsable = selectedUsable + 1
  } else if (event.deltaY > 0) {
    selectedUsable = selectedUsable - 1
  }
  
  if (selectedUsable >= usables.length) {
    selectedUsable = 0
  } else if (selectedUsable < 0) {
    selectedUsable = usables.length - 1
  }

  UpdateInventory();
});

document.getElementById("food").addEventListener("wheel", function(event) {
  if (event.deltaY < 0) {
    selectedFood = selectedFood + 1
  } else if (event.deltaY > 0) {
    selectedFood = selectedFood - 1
  }
  
  if (selectedFood >= food.length) {
    selectedFood = 0
  } else if (selectedFood < 0) {
    selectedFood = food.length - 1
  }

  UpdateInventory();
});

document.getElementById("drinks").addEventListener("wheel", function(event) {
  if (event.deltaY < 0) {
    selectedDrink = selectedDrink + 1
  } else if (event.deltaY > 0) {
    selectedDrink = selectedDrink - 1
  }
  
  if (selectedDrink >= drinks.length) {
    selectedDrink = 0
  } else if (selectedDrink < 0) {
    selectedDrink = drinks.length - 1
  }

  UpdateInventory();
});

window.addEventListener('mousemove', function(e){
  e = e || window.event;
  var target = e.target || e.srcElement;

  if (inventory_open == true) {
    if (pressed == false) {
      if (target.id == "inventory_overlay" || target.id == "crafting_overlay" || target.id == "trading_overlay" || target.id == "vehicleinv_overlay" || target.id == "weapons_row" || target.id == "items_row") {
        document.getElementById("holster").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("melee").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("handgun").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("primary").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("meds").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("usables").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("food").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("drinks").style.background = "rgba(0, 0, 0, 0.2)";
        selectedSlot = "nothing"
      } else {
        document.getElementById("holster").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("melee").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("handgun").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("primary").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("meds").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("usables").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("food").style.background = "rgba(0, 0, 0, 0.2)";
        document.getElementById("drinks").style.background = "rgba(0, 0, 0, 0.2)";
        selectedSlot = target.id
        document.getElementById(target.id).style.background = "rgba(0, 0, 0, 0.4)";
      }
    }
  } else if (craft_open == true) {
    CraftMouseMove()
  }
});

window.addEventListener('click', function(e) {
    e = e || window.event;
    var target = e.target || e.srcElement;
    var type = target.id;

    if (inventory_open == true) {
      if (type == "melee") {
        selectedItemUse = 5
        selectedItemId = melee[selectedMelee].id
        selectedItemName = melee[selectedMelee].n
        selectedItemCount = melee[selectedMelee].count
      } else if (type == "handgun") {
        selectedItemUse = 6
        selectedItemId = handgun[selectedHandgun].id
        selectedItemName = handgun[selectedHandgun].n
        selectedItemCount = handgun[selectedHandgun].count
      } else if (type == "primary") {
        selectedItemUse = 7
        selectedItemId = primary[selectedPrimary].id
        selectedItemName = primary[selectedPrimary].n
        selectedItemCount = primary[selectedPrimary].count
      } else if (type == "meds") {
        selectedItemUse = 4
        selectedItemId = meds[selectedMed].id
        selectedItemName = meds[selectedMed].n
        selectedItemCount = meds[selectedMed].count
      } else if (type == "usables") {
        selectedItemUse = usables[selectedUsable].use
        selectedItemId = usables[selectedUsable].id
        selectedItemName = usables[selectedUsable].n
        selectedItemCount = usables[selectedUsable].count
      } else if (type == "food") {
        selectedItemUse = 2
        selectedItemId = food[selectedFood].id
        selectedItemName = food[selectedFood].n
        selectedItemCount = food[selectedFood].count
      } else if (type == "drinks") {
        selectedItemUse = 1
        selectedItemId = drinks[selectedDrink].id
        selectedItemName = drinks[selectedDrink].n
        selectedItemCount = drinks[selectedDrink].count
      } else if (type == "holster") {
        selectedItemUse = 0
        selectedItemId = 0
        selectedItemName = "Holster"
        selectedItemCount = 0
      } else  {
        selectedItemId = -1
        selectedItemUse = -1
        selectedItemName = "Empty"
        selectedItemCount = -1
      }
  
      if (selectedItemId >= 0){
        $('.inv_overlay').hide();
        inventory_open = false;
        $.post('http://b_inventory/onUseItem', JSON.stringify({ itemName: selectedItemName, itemId: selectedItemId, itemUse: selectedItemUse, itemCount: selectedItemCount }));
      }
    } else if (craft_open == true) {
      CraftMouseClick()
    }

}, false);

window.addEventListener("keyup", function(event){
  if (inventory_open == true) {
    if (event.which == 70 && pressed == true) {
      var duration = (event.timeStamp - fPressed) / 1000
      if (duration > 1) {
        if (selectedSlot == "melee") {
          selectedItemUse = 5
          selectedItemId = melee[selectedMelee].id
          selectedItemName = melee[selectedMelee].n
          selectedItemCount = melee[selectedMelee].count
        } else if (selectedSlot == "handgun") {
          selectedItemUse = 6
          selectedItemId = handgun[selectedHandgun].id
          selectedItemName = handgun[selectedHandgun].n
          selectedItemCount = handgun[selectedHandgun].count
        } else if (selectedSlot == "primary") {
          selectedItemUse = 7
          selectedItemId = primary[selectedPrimary].id
          selectedItemName = primary[selectedPrimary].n
          selectedItemCount = primary[selectedPrimary].count
        } else if (selectedSlot == "meds") {
          selectedItemUse = 4
          selectedItemId = meds[selectedMed].id
          selectedItemName = meds[selectedMed].n
          selectedItemCount = meds[selectedMed].count
        } else if (selectedSlot == "usables") {
          selectedItemUse = usables[selectedUsable].use
          selectedItemId = usables[selectedUsable].id
          selectedItemName = usables[selectedUsable].n
          selectedItemCount = usables[selectedUsable].count
        } else if (selectedSlot == "food") {
          selectedItemUse = 2
          selectedItemId = food[selectedFood].id
          selectedItemName = food[selectedFood].n
          selectedItemCount = food[selectedFood].count
        } else if (selectedSlot == "drinks") {
          selectedItemUse = 1
          selectedItemId = drinks[selectedDrink].id
          selectedItemName = drinks[selectedDrink].n
          selectedItemCount = drinks[selectedDrink].count
        } else  {
          selectedItemId = -1
          selectedItemUse = -1
          selectedItemName = "Empty"
          selectedItemCount = -1
        }
    
        if (selectedItemId >= 0){
          $.post('http://b_inventory/onDropItem', JSON.stringify({ itemName: selectedItemName, itemId: selectedItemId, itemUse: selectedItemUse, itemCount: selectedItemCount }));
        }
      }
        
      document.getElementById("holster").style.background = "rgba(0, 0, 0, 0.2)";
      document.getElementById("melee").style.background = "rgba(0, 0, 0, 0.2)";
      document.getElementById("handgun").style.background = "rgba(0, 0, 0, 0.2)";
      document.getElementById("primary").style.background = "rgba(0, 0, 0, 0.2)";
      document.getElementById("meds").style.background = "rgba(0, 0, 0, 0.2)";
      document.getElementById("usables").style.background = "rgba(0, 0, 0, 0.2)";
      document.getElementById("food").style.background = "rgba(0, 0, 0, 0.2)";
      document.getElementById("drinks").style.background = "rgba(0, 0, 0, 0.2)";
  
      fPressed = 0
      pressed = false
    }
  }
});

function SetupCrafting() {
  $('.craft_overlay').show();
  craft_open = true;
}

function CraftMouseMove() {

}

function CraftMouseClick() {

}