# Recipe Book

Let's keep track of recipes. A recipe will have 1 or more ingredients, directions, and can be tagged.

## Setup Instructions

1. Clone the repo
2. `asdf install` to install correct Ruby
3. `bundle install` (or just `bundle`) to install gems
4. `rails db:setup`

To run the console - `bin/rails c`

To run the server - `bin/rails s`

To run migrations - `bin/rails db:migrate`

To reset the database - `bin/rails db:reset`

## Guard

You can run Guard, which runs tests upon every file-save.

```sh
bin/guard
```

Exit by typing "exit"

## GraphQL

All of these are `POST localhost:3000/graphql`

Get a recipe:

```
query { recipe(id: 1) {
	name
	id
}}
```

```
query { recipe(id: 1) {
	name
	id,
  author {name id}
  category {name id}
}}
```

Get ALL recipes:

```
query { recipes {
	name
	id,
  author {name id}
  category {name id}
}}
```

Or use some search/filter:

```
query { recipes(nameLike: "salad", durationUnder: 90, durationOver: 15) {
	name
	id,
  author {name id}
  category {name id}
}}
```

To delete authors (and do other stateful things), go to the "auth" tab in
Insomnia or whatever other HTTP client you're using and select "Basic" auth.

Then provide `author-3` (or whatever ID) for the username, and "password" for
the password.

This should correctly trigger the `current_author` `before_action` on graphql
endpoints.

Then in the graphql mutations and resolvers, we can access
`context[:current_author]` and have our Author object.
