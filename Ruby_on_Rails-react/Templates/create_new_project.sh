

# self medicate if needed
set -euo pipefail
unset BUNDLE_GEMFILE 2>/dev/null || true

# make project folder in overall directory.
cd ..


# configure project specific bundler
# bundle config set path 'vendor/bundle'

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
rails new "$PROJECT_NAME" --javascript=esbuild

# move inside folder. 
cd "$PROJECT_NAME"



# Adding project dependencies
bundle add vite_rails
bundle install

mkdir -p config

# manually making vite.json cause it's broke for some reason. :)
cat << 'EOF' > config/vite.json
{
  "all": {
    "sourceCodeDir": "app/frontend",
    "watchAdditionalPaths": []
  },
  "development": {
    "autoBuild": true
  },
  "test": {
    "autoBuild": true
  },
  "production": {
    "autoBuild": true
  }
}
EOF


# create front end entrypoint :)
mkdir -p app/frontend
cat << 'EOF' > app/frontend/application.jsx
import React from "react"
import { createRoot } from "react-dom/client"

const App = () => <h1>Rails + Vite + React</h1>

const root = document.getElementById("app")
if (root) createRoot(root).render(<App />)
EOF

# wire rails layous :)
sed -i '/javascript_include_tag/d' app/views/layouts/application.html.erb

# inject vite helping
sed -i '/<head>/a \
    <%= vite_client_tag %>\n    <%= vite_javascript_tag "application" %>' \
    app/views/layouts/application.html.erb

# add mount point
sed -i '/<body>/a \
    <div id="app"></div>' \
    app/views/layouts/application.html.erb



# install react with npm
npm install react react-dom vite



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


#installing vite packages?
bundle exec vite install


#disable jsbundlind
rm -rf app/javascript
rm -rf app/assets/builds

