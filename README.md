# Todolix
## What is it?
Simple synchronized todolist implementation to explore Elixir as a choice in server-side technology. Additionally, I've used React for the frontend to see how it differs from traditional client-side MVC technology. Everyone who visits the page will receive events that indicate new todos have been added or todos have been removed, thereby keeping them in sync. 

## Installation
To start todolix you must:

1. Install dependencies with `mix deps.get`
2. Install JSX with `npm install -g jsx` (may require administrative privileges)
2. run `make` to compile the JSX files.
3. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser. You must have a websockets-enabled browser to interact with the app.

