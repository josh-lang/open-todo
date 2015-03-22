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
