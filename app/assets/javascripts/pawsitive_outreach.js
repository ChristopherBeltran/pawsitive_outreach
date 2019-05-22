//classes
class Breed {
    constructor(name, petId, breedId) {
        this.name = name;
        this.petId = petId;
        this.breedId = breedId;
    };
};

class User {
    constructor(id, name) {
        this.id = id;
        this.name = name;
    ;}
};

class Pet {
    constructor(id, name, age) {
        this.id = id;
        this.name = name;
        this.age = age;
    };
}


//API calls

function adminPetsIndex() {
    $.getJSON("/admin/pets.json", function(data) {
        console.log(data);
    });
};

