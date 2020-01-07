# Sinatra Template
This is a Sinatra template modeled on the rails directory structure.
I have tried to keep it as simple as possible using only Sinatra, and kept out any recipes, external libraries, extensions etc.
to make it as easy to use and understand as possible.

The template is setup for DataMapper, erb, sass, (and rspec in the future).
But if you want to use another orm, renderer etc. the template is highly customizable, and the code for shifting to another orm etc. is propably already here (just commented out).



## How to use
Use this repository as a template.
Then run
```bash
bundle
```
and to start the server, run
```bash
rackup
```
and go to [localhost:9292/things](localhost:9292/things).

You probably should edit the following when you use the template:
- .gitignore (remove .lock from the list of ignored files)
- LICENSE
- Gemfile (to use the ORM you want etc.)
- images/favicon.ico (to use the favicon of your choosing)
- app/models/thing.rb (Change the name of the file and the class inside to whatever you want. Or just delete it)
- app/controllers/thing.rb (Change the name of the file and the class inside to match the model you just changed. Also change all the code inside to match the name of the model.)
- app/thing (change the folder to match the name of the model)
- config.ru (change __things__ in `map('/things') { run ThingController }` to the name of the model (in plural), and change the require statements in the top to use the gems you want)
- README.md
- The name of the directory.


### irb session
To access an irb session, you should first
```bash
gem install racksh
```
and then to access a session, run
```bash
racksh
```

## Contribute
If you want to contribute, you are very welcome. I have tried to keep out the use of any external libraries, recipes, extensions etc. so if you do want to make some changes, I would appreciate if you followed this "philosophy".
Further down, I have made a to-do list, which are features I would like implemented, but which I haven't had time to do yet. Otherwise you are free to do any of the following
- Fix any mistakes.
- Documentation.
- Add other orms, scripting languages etc. to gemfile, to easily setup custom Sinatra environment
    - This should be done in the way it is already done, i.e. by putting code for other orms etc. in comments.
- Clean up the code
- Anything else that you find that the template is missing

## To-Do / Feature requests
- Sass
- Logs (Unified between model and everything else)
- Tests
- Move favicon.ico from public/images to public
- Set port to 4567?

## FAQ
Q: Why is the page looking weird/dull/unstyled/...

A: Because of the reset.css file in public/stylesheets that is linked to in the layout.
The reset.css stylesheet resets all default styles in the browser, so your styling becomes more consistent.
This particular reset.css is from [meyerweb.com](https://meyerweb.com/eric/tools/css/reset/).
