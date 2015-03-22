# README

####To create a new user:

```bash
$ curl -X POST -F "user[username]=username" -F "user[password]=password" -F "user[password_confirmation]=password" http://localhost:3000/api/signup
```

####To authenticate yourself:

```bash
$ curl -u username:password
```

####To create a new list:

Note: permissions _must_ be set to 'private', 'viewable', or 'open'

```bash
$ curl -u username:password -X POST -F "list[name]=name" -F "list[permissions]=permissions" http://localhost:3000/api/lists
```

####To create a new item:

```bash
$ curl -u username:password -X POST -F "item[description]=name" http://localhost:3000/api/lists/:list_id/items
```

####To mark an item as completed:

```bash
$ curl -u username:password -X DELETE http://localhost:3000/api/items/:id
```

####Routes:

```
            Prefix Verb   URI Pattern                         Controller#Action
          api_root GET    /api(.:format)                      api/users#index
        api_signup POST   /api/signup(.:format)               api/users#create
api_update_account PUT    /api/update-account(.:format)       api/users#update
api_cancel_account DELETE /api/cancel-account(.:format)       api/users#destroy
         api_users GET    /api/users(.:format)                api/users#index
          api_user GET    /api/users/:id(.:format)            api/users#show
    api_list_items POST   /api/lists/:list_id/items(.:format) api/items#create
         api_lists GET    /api/lists(.:format)                api/lists#index
                   POST   /api/lists(.:format)                api/lists#create
          api_list GET    /api/lists/:id(.:format)            api/lists#show
                   PATCH  /api/lists/:id(.:format)            api/lists#update
                   PUT    /api/lists/:id(.:format)            api/lists#update
                   DELETE /api/lists/:id(.:format)            api/lists#destroy
          api_item DELETE /api/items/:id(.:format)            api/items#destroy
```
