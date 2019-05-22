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
            debugger;
            } else {
                var pBreeds = this.breeds[0].name;
            };
        return (`
            <tr>
                <td>${this.name}</td>
                <td>${this.age}</td>
                <td>${pBreeds}</td>
            </tr>
        `);
    };
};


//API calls

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
            $("#admin_pets_table").append(petHTML);
            }; 
    })
    }