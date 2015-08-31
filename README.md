## Pokedex on MagLev
A Responsive Pokedex built using only Webrick and ActiveSupport
(no rails or active record)

view it live [here](https://pokedex-sans-rails.herokuapp.com/pokemon)

### Features

#### Asset image, script, and stylesheet support
- A controller for each type of asset and corresponding regexps to support get requests
within your project directory.
- Images routes will recognize and respond to .jpg, .jpeg, and .png files
- ScriptsController recognizes js files in the src of script tags and runs the appropriate files
- StyleSheets controller does the same for linked stylesheets

#### Base controller class 
- wraps views in a customizable header partial to keep them DRY  