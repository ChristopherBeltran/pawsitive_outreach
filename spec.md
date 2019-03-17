# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
  *Implemented the User class with the following relationships(has_many :adoptions, has_many :pets, through: :adoptions), and implemented the Pet class with the following relationships(has_many :adoptions, has_many :users, through: :adoptions, has_many :pet_breeds, has_many :breeds, through: :pet_breeds), and the Breed class with the following relationships(has_many :pet_breeds,
  )*
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
  *Implemented the Adoption class to belong_to user and pet, and the PetBreed class to belong_to pet and breed*
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
  *Implemented the following has_many_through relationships (User - has_many :pets, through: :adoptions, Pet - has_many :users, through: :adoptions, has_many :breeds, through: :pet_breeds )*
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
  *Implemented the User having many pets through adoptions and the pet having many users through adoptions*
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
  *When making an adoption the user must input an adoption date*
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  *User class validations (phone number format, email presence, name presence, email uniqueness), Pet class validations(name presence, age presence, age range of 1-30 years), Adoption class validations(adoption date inclusion)*
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  *Pet class(self.from_breed method, which filters all objects in Pet class by a given breed, self.without_owner, which filters for all objects in Pet class who do not have a user associated with them, also a method in Admin::PetsController to order all objects in Pet class by name)*
- [x] Include signup (how e.g. Devise)
  *Includes a standard user sign up form (no admin sign up, admin accounts are created manually through rails console with the idea of them being administered)*
- [x] Include login (how e.g. Devise)
  *Includes a user login as well as a separate admin login*
- [x] Include logout (how e.g. Devise)
  *Logout option always available in nav bar*
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  *Omniauth login through Google*
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
  *Nested routes for admin/breeds and admin/pets index pages and user/pets index*
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
  *Nested pets/:id/adoption/new resource as well as admin/pets/new routes*
- [x] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
