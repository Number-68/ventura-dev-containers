#!/bin/bash
set -euo pipefail
unset BUNDLE_GEMFILE 2>/dev/null || true

# go to parent directory where projects live
cd ..

# receive project name
echo "Enter project name: "
read PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty."
    exit 1
fi

echo "Creating Ruby on Rails + React.js project named: $PROJECT_NAME"

# create project directory
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

# initialize bundler for this project
bundle init

# install Rails *inside this project*
bundle add rails
# generate the Rails project in-place using project-local Rails
bundle exec rails new . --force

# install Vite
bundle add vite_rails
bundle exec vite install

# install React
npm install react react-dom

# create dev script
cat << 'EOF' > dev.sh
#!/bin/bash

bin/rails server &
bin/vite dev
EOF

chmod +x dev.sh
