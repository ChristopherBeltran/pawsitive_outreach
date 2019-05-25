//classes
class Breed {
    constructor(obj) {
        this.id = obj.id;
        this.name = obj.name;
        this.pets = obj.pets;
    };

    prototypeBreedIndexHTML() {
        return (`
            <tr>
                <td>${this.name}</td>
                <td>${this.pets.length}</td>
                <td><a href='/admin/breeds/${this.id}' onclick='adminBreedsShow(${this.id})'>View Pets</a></td>
            </tr>
        `);
    }

    prototypeBreedShowHTML() {
        let pets = [];

        for(var i = 0; i < this.pets.length; i++) {
            $.getJSON(`/admin/pets/${this.pets[i]["id"]}.json`, function(data) {
            let pet = data;
            var newPet = new Pet(pet);
                if(newPet.breeds.length === 1){
                    var br = "Y";
                } else {
                    newPet.breeds.forEach(function (breed) {
                        if (breed.name != this.name) {
                            var br = `N(Mixed with ${breed.name})`;
                        }
                    })
                };
            let owned = newPet.ownedStatus();
            var petHTML = `
            <tr>
            <input id="${newPet.id}" type="hidden">
                <td>${newPet.name}</td>
                <td>${newPet.age}</td>
                <td>${br}</td>
                <td>${owned}</td>
            </tr>`
            $("tbody").append(petHTML);
        });
        }
    }

};

class User {
    constructor(obj) {
        this.id = obj.id;
        this.name = obj.name;
    ;}
};

class Pet {
    constructor(obj) {
        this.id = obj.id;
        this.name = obj.name;
        this.age = obj.age;
        this.breeds = obj.breeds;
        this.users = obj.users;
    };

    ownedStatus() {
        if (this.users.length > 0){
            return "Y"
            } else {
                return `N - <a href='/admin/pets/${this.id}/edit'>Edit Pet</a>`;
            };
    };

    prototypePostHTML() {
        if (this.breeds.length > 1) {
            let br = []
            for(var i = 0; i < this.breeds.length; i++){
                br.push(this.breeds[i].name);
            };
            var pBreeds = br.join(", ");
            } else {
                var pBreeds = this.breeds[0].name;
            };
        var ownedStatus = this.ownedStatus();
        return (`
            <tr>
                <td>${this.name}</td>
                <td>${this.age}</td>
                <td>${pBreeds}</td>
                <td>${ownedStatus}</td>
            </tr>
        `);
    };

    nonAdminPetIndexHTML() {
        if (this.breeds.length > 1) {
            let br = []
            for(var i = 0; i < this.breeds.length; i++){
                br.push(this.breeds[i].name);
            };
            var pBreeds = br.join(", ");
            } else {
                var pBreeds = this.breeds[0].name;
            };
            return (`
            <tr>
                <td>${this.name}</td>
                <td>${this.age}</td>
                <td>${pBreeds}</td>
                <td><a href='/pets/${this.id}/adoptions/new'>Adopt?</a></td>
            </tr>
        `);

    };
};


//API calls

//admin/pets page

function adminPetsIndex() {
    $.getJSON("/admin/pets.json", function(data) {
        let pets = data;
        let table = `<table style="width:100%">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Breed</th>
            <th>Owned?</th>
        </tr>`;
        $("#admin_pets_table").html(table);
        for(var i =0; i < pets.length; i++ ){
            let newPet = new Pet(pets[i]);
            let petHTML = newPet.prototypePostHTML();
            $("tbody").append(petHTML);
            }; 
    })
}

//admin/pets/new page

function addNewPet() {
    $('#new_pet').submit(function(event) {
        //prevent form from submitting the default way
        event.preventDefault();
        var values = $(this).serialize();

        var pet = $.post('/admin/pets', values);
        pet.done(function(data) {
            $('#new_pet')[0].reset();
            $('#pet_form')[0].style.display = "none";
            let newPet = new Pet(data);;
            var newPetHTML = `<h2>${newPet.name} Successfully created!</h2>
                <br>
                <p>Age: ${newPet.age}</p>
                <br>
                <p>Breed(s): ${newPet.breeds[0].name}</p>
                <br>
                <input type="button" id="create_next_pet" value="Create Another Pet">
                <br>
                <br>
                <a href="/admin/pets" class="button" id="pets_index_button">Return To Pets Page</a>
                `;
            $('#created_pet').append(newPetHTML);
            $('#create_next_pet').on('click', function () {
                $('#created_pet').empty()
                $('#pet_form')[0].style.display = "block"
                $('#new_pet_button').prop('disabled', false);
            })
        })
    })
};

//admin/breeds page

function adminBreedsIndex() {
    $.getJSON("/admin/breeds.json", function(data) {
        let breeds = data;
        let table = `<table style="width:100%">
        <tr>
            <th>Breed</th>
            <th># of Pets</th>
        </tr>`;
        $("#admin-breeds-table").html(table);
        for(var i =0; i < breeds.length; i++ ){
            let newBreed = new Breed(breeds[i]);
            let breedHTML = newBreed.prototypeBreedIndexHTML();
            $("tbody").append(breedHTML);
            }; 
    })
}

//admin/breeds/show page
function adminBreedsShow(val) {
    $.getJSON(`/admin/breeds/${val}.json`, function (data) {
        var saveData = data;
        localStorage.setItem('breed', JSON.stringify(saveData));
    });
}

function displayBreed() {
    let breed = JSON.parse(localStorage.getItem('breed'));
    let newBreed = new Breed(breed);
    let header = `<h1>${newBreed.name}'s</h1>`
    $("#breed-header").append(header);
    let breedTable = `<table style="width:100%">
        <tr>
        <th>Name</th>
        <th>Age</th>
        <th>Full-Bred</th>
        <th>Owned?</th>
        </tr>`; 
    $("#breed-table").append(breedTable);

    newBreed.prototypeBreedShowHTML();
    };

    //pets index page non-admin

function petsIndex() {
    $.getJSON("/pets.json", function(data) {
        let pets = data;
        let table = `<table style="width:100%">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Breed</th>
        </tr>`;
        $("#pets_table").html(table);
        for(var i =0; i < pets.length; i++ ){
            let newPet = new Pet(pets[i]);
            let petHTML = newPet.nonAdminPetIndexHTML();
            $("tbody").append(petHTML);
        }
    })
}

function myPetsIndex() {
    $.getJSON("/pets.json", function(data) {
        let pets = data;
        let table = `<table style="width:100%">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Breed</th>
        </tr>`;
})
}


//<% if @user_pets && @user_pets.count < 1 %>
//<h3> No pets yet! </h3>
//<p> Head over to <%= link_to "View Available Pets", pets_path%>, to adopt a new furry friend! </p>

//<% elsif @user_pets %>
//<h1><%=current_user.display_name%> Pets</h1>
//<%= render "layouts/pets_table" %>



//<% else %>
//<h1>Available Pets </h1>
//<%= render "layouts/pets_table" %>
//<br>
//<% end %></br>