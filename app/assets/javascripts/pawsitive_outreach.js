//classes
class Breed {
    constructor(name, petId, breedId) {
        this.name = name;
        this.petId = petId;
        this.breedId = breedId;
    };

      BreedCreator = {
        createBreed: function () {
          let newBreed = {};
          Breed.apply(newBreed, arguments);
          this.allBreeds.push(newBreed); 
          return newBreed;
        },
      
        allBreeds: [],
      
        forEachBreed: function (action) {
          for (let i = 0; i < this.allBreeds.length; i++){
            action.call(this.allBreeds[i]);
          }
        } 
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
    };

    PetCreator = {
        createPet: function () {
          let newPet = {};
          Pet.apply(newPet, arguments);
          this.allPets.push(newPet); 
          return newPet;
        },
      
        allPets: [],
      
        forEachPet: function (action) {
          for (let i = 0; i < this.allPets.length; i++){
            action.call(this.allPets[i]);
          }
        } 
      };
};

//API calls

function adminPetsIndex() {
    $.getJSON("/admin/pets.json", function(data) {
        let pets = data;
        pets.map( p => 
            PetCreator.createPet(p.id, p.name, p.age))
    });
};

