//classes
class Breed {
    constructor(name, petId, breedId) {
        this.name = name;
        this.petId = petId;
        this.breedId = breedId;
    };
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
    prototypePostHTML () {
        if (this.breeds.length > 1) {
            let br = []
            for(var i = 0; i < this.breeds.length; i++){
                br.push(this.breeds[i].name);
            };
            var pBreeds = br.join(", ");
            } else {
                var pBreeds = this.breeds[0].name;
            };
        if (this.users.length > 0){
            var ownedStatus = "Y"
            } else {
                var ownedStatus = "N"
            };
        return (`
            <tr>
                <td>${this.name}</td>
                <td>${this.age}</td>
                <td>${pBreeds}</td>
                <td>${ownedStatus}</td>
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