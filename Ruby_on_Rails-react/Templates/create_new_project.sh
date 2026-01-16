


# self medicate if needed
set -euo pipefail
unset BUNDLE_GEMFILE 2>/dev/null || true
#this fixed the issue of not being able to create multiple projects in the same container




# make project folder in overall directory.
cd ..


# configure project specific bundler
bundle config set path 'vendor/bundle'

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


echo "DEBUG: Project name is '$PROJECT_NAME'"



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



# create a dev script inside project
cat << 'EOF' > dev.sh
#!/bin/bash

# Start Rails server
bin/rails server &

# Start Vite dev server
bin/vite dev
EOF

# give permissions
chmod +x dev.sh