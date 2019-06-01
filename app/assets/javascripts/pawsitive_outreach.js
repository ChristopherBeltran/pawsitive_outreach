//classes
class Adoption {
    constructor(obj) {
        this.id = obj.id;
        this.adoption_date = obj.adoption_date;
        this.user_id = obj.user_id;
        this.pet_id = obj.pet_id;
    };
};


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
        const breedObj = this;
        for(const p of this.pets) {
            $.getJSON(`/admin/pets/${p["id"]}.json`, function(data) {
            let pet = data;
            let newPet = new Pet(pet);
                if(newPet.breeds.length === 1){
                    var br = "Y";
                  
                } else {
                    for(var i = 0; i < newPet.breeds.length; i++){
                        if(newPet.breeds[i].name !== breedObj.name){
                            var br = `N(Mixed with ${newPet.breeds[i].name})`;
                        };
                    }
                
                };
            const owned = newPet.ownedStatus();
            const petHTML = `
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

//class User {
//    constructor(obj) {
//        this.id = obj.id;
//        this.name = obj.name;
//    ;}
//};

class Pet {
    constructor(obj) {
        this.id = obj.id;
        this.name = obj.name;
        this.age = obj.age;
        this.breeds = obj.breeds;
        this.users = obj.users;
        this.adoptions = obj.adoptions;
    };

    ownedStatus() {
        if (this.users.length > 0){
            return "Y"
            } else {
                return `N - <a href='/admin/pets/${this.id}/edit'>Edit Pet</a>`;
            };
    };

    breedFormatter() {
        if (this.breeds.length > 1) {
            const br = this.breeds.map(breed => breed.name)
            return br.join(", ");
            } else {
                return this.breeds[0].name;
            };
    };

    prototypePostHTML() {
        const pBreeds = this.breedFormatter();
        const ownedStatus = this.ownedStatus();
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
            const pBreeds = this.breedFormatter();
            return (`
            <tr>
                <td>${this.name}</td>
                <td>${this.age}</td>
                <td>${pBreeds}</td>
                <td><a href='/pets/${this.id}/adoptions/new'>Adopt?</a></td>
            </tr>
        `);

    };

    myPetsIndexHTML() {
    const pBreeds = this.breedFormatter();
    return (`
    <tr>
        <td>${this.name}</td>
        <td>${this.age}</td>
        <td>${pBreeds}</td>
        <td>${this.adoptions[0].adoption_date}</td>
    </tr>
    `);
    }
};


//API calls

//admin/pets page
const adminPetsIndex = () => (
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
        for(const p of pets){
            let newPet = new Pet(p);
            let petHTML = newPet.prototypePostHTML();
            $("tbody").append(petHTML);
            }; 
    })
)

//admin/pets/new page

const addNewPet = () => (
    $('#new_pet').submit(function(event) {
        //prevent form from submitting the default way
        event.preventDefault();
        const values = $(this).serialize();

        const pet = $.post('/admin/pets', values);
        pet.done(function(data) {
            $('#new_pet')[0].reset();
            $('#pet_form')[0].style.display = "none";
            const newPet = new Pet(data);
            const newPetHTML = `<h2>${newPet.name} Successfully created!</h2>
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
)

//admin/breeds page

const adminBreedsIndex = () => (
    $.getJSON("/admin/breeds.json", function(data) {
        const breeds = data;
        const table = `<table style="width:100%">
        <tr>
            <th>Breed</th>
            <th># of Pets</th>
        </tr>`;
        $("#admin-breeds-table").html(table);
        for(const br of breeds){
            let newBreed = new Breed(br);
            let breedHTML = newBreed.prototypeBreedIndexHTML();
            $("tbody").append(breedHTML);
            }; 
    })
)

//admin/breeds/show page
const adminBreedsShow = val => (
    $.getJSON(`/admin/breeds/${val}.json`, function (data) {
        const saveData = data;
        localStorage.setItem('breed', JSON.stringify(saveData));
    })
)

function displayBreed() {
    const breed = JSON.parse(localStorage.getItem('breed'));
    const newBreed = new Breed(breed);
    const header = `<h1>${newBreed.name}'s</h1>`
    $("#breed-header").append(header);
    const breedTable = `<table style="width:100%">
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

const petsIndex = () => (
    $.getJSON("/pets.json", function(data) {
        const pets = data;
        const table = `<table style="width:100%">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Breed</th>
        </tr>`;
        $("#pets_table").html(table);
        for(const p of pets){
            let newPet = new Pet(p);
            let petHTML = newPet.nonAdminPetIndexHTML();
            $("tbody").append(petHTML);
        }
    })
);

//mypets page (users pets)

function myPetsIndex() {
    const userId = document.querySelector('#mypets-index-header').dataset.userId

    $.getJSON(`/users/${userId}/pets.json`, function(data) {
        const pets = data;
        const table = `<table style="width:100%">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Breed</th>
            <th>Adoption Date</th>
        </tr>`;
        $('#mypets_table').html(table);
        for(const p of pets){
            let newPet = new Pet(p);
        let petHTML = newPet.myPetsIndexHTML();
        $("tbody").append(petHTML);
        }
    })
}

const newAdoption = () => (
    $('#new_adoption').submit(function(event) {
        //prevent form from submitting the default way
        event.preventDefault();
        const petId = this["adoption[pet_id]"].value
        const values = $(this).serialize();
        const adoption = $.post(`/pets/${petId}/adoptions`, values)

        adoption.done(function(data) {
            $('#adoption-form').html("")
            const newAdoption = new Adoption(data);
            const petId = newAdoption.pet_id;
            const userId = newAdoption.user_id;
            $.getJSON(`/pets/${petId}.json`, function(data){
                let pet = data;
                let newPet = new Pet(data);
                let newPetHTML = `
                <h2>Congratulations, ${newPet.name} is all yours!</h2>
                <br>
                <h3>Would you like to change the name?</h3>
                <a href='/pets/${newPet.id}/edit'>Edit ${newPet.name}</a>
                <br>
                <p>Or return to</p><a href='/users/${userId}/pets'>My Pets</a>

                `
                $('#post-adoption').append(newPetHTML);
            })
        })
    })
)