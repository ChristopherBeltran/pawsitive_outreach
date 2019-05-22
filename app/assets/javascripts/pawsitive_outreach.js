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
    //Pet.prototype.postHTML = function () {
    //    if (this.breeds.length > 1) {
    //        let pBreeds = this.breeds.map(breed)
    //    }
    //    return (`
    //        <tr>
    //            <td>${this.name}</td>
    //            <td>${this.age}</td>
    //            <td>${this.breeds}</td>
    //        </tr>
    //    `)
    //}
};


//API calls

function adminPetsIndex() {
    $.getJSON("/admin/pets.json", function(data) {
        let pets = data;
        debugger;
        let table = `<table style="width:100%">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Breed</th>
            <th>Owned?</th>
        </tr>`;


    })}