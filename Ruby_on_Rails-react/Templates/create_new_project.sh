

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



# create project directory with project name
rails new "$PROJECT_NAME" --javascript=esbuild


# move inside folder. 
cd "$PROJECT_NAME"



# install react from npm
npm install react react-dom


# making the react entrypoint
cat << 'EOF' > app/javascript/application.jsx
import React from "react"
import { createRoot } from "react-dom/client"

function App() {
    return <h1>Hello from React + ESBuild + Rails 8</h1>
}

const root = document.getElementById("app")
if (root) {
    createRoot(root).render(<App />)
}
EOF



# replacing default mount point into rails layout 
cat << 'EOF' > app/javascript/application.js
import "./application.jsx"
EOF



#inject mount point into rails layout
sed -i '/<body>/a \
    <div id="app"></div>' \
    app/views/layouts/application.html.erb




# remove old javascript include if presnet

# Remove old javascript_include_tag if present
sed -i '/javascript_include_tag/d' app/views/layouts/application.html.erb


# Add ESBuild tag
sed -i '/<head>/a \
    <%= javascript_include_tag "application", defer: true %>' \
    app/views/layouts/application.html.erb




# Create dev script
cat << 'EOF' > dev.sh
#!/bin/bash

# Start ESBuild watcher
bin/rails javascript:build --watch &

# Start Rails server
bin/rails server
EOF

chmod +x dev.sh

echo "Project $PROJECT_NAME created successfully!"
echo "Run ./dev.sh to start Rails + ESBuild"

