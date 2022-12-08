rails-engine: Rails API project by Lucas Colwell

Directions after cloning

bundle install

rails db:{drop,create,migrate,seed}

rails db:schema:dump

rails s

Endpoints available by navigating to localhost in browser:

Get all Merchants

GET http://localhost:3000/api/v1/merchants

Get one Merchant

GET http://localhost:3000/api/v1/merchants/<merchant_id>

Get all Merchant Items

GET http://localhost:3000/api/v1/merchants/<merchant_id>/items

Get all Items

GET http://localhost:3000/api/v1/items

Get one Item

GET http://localhost:3000/api/v1/items/<item_id>

Create/Delete Item

POST/DELETE http://localhost:3000/api/v1/items

Update Item

PUT http://localhost:3000/api/v1/items/<item_id>
