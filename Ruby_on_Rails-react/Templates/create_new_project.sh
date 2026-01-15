# make project folder in overall directory.
cd ..

# receive project name

echo "Enter project name: " 
read PROJECT_NAME

# checking for correct input todo: make something more robust than this later.
#       we'll use these as templates for other project wizards
if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty." 
    exit 1
fi

echo "Creating Ruby on Rails + React.js Project named: $PROJECT_NAME"


# create project directory with project name
rails new "$PROJECT_NAME"

# move inside folder. 
cd "$PROJECT_NAME"



# Adding project dependencies. 
bundle add vite_rails

# Run vite intsaller
bundle exec vite install

# install react with npm
npm install react react-dom
