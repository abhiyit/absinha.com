#!/bin/bash

# Create project directory and enter it
mkdir my-eleventy-project && cd my-eleventy-project

# Initialize a new npm project
npm init -y

# Install Eleventy
npm install --save-dev @11ty/eleventy

# Install Tailwind CSS and its dependencies
npm install -D tailwindcss@latest postcss@latest autoprefixer@latest

# Initialize Tailwind CSS
npx tailwindcss init

# Create necessary directories
mkdir -p src/admin src/styles

# Create Eleventy config file
echo "module.exports = function(eleventyConfig) {
  return {
    dir: {
      input: 'src',
      output: '_site'
    }
  };
};" > .eleventy.js

# Create PostCSS config file
echo "module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
  ]
};" > postcss.config.js

# Create the Tailwind CSS file
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > src/styles/styles.css

# Create your first Eleventy page
echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
  <link rel=\"stylesheet\" href=\"/styles/styles.css\">
  <title>Document</title>
</head>
<body>
  <h1>Hello, Eleventy with TailwindCSS!</h1>
</body>
</html>" > src/index.html

# Create Netlify CMS admin configuration
mkdir -p src/admin && echo "<!DOCTYPE html>
<html>
<head>
  <title>Content Manager</title>
</head>
<body>
  <script src=\"https://identity.netlify.com/v1/netlify-identity-widget.js\"></script>
  <script src=\"https://cdn.netlify.com/cms/latest/netlify-cms.js\"></script>
</body>
</html>" > src/admin/index.html

# Create Netlify CMS config file
echo "backend:
  name: git-gateway
  branch: main

media_folder: \"src/images\"
public_folder: \"/images\"

collections:
  - name: \"blog\"
    label: \"Blog\"
    folder: \"src/posts\"
    create: true
    slug: \"{{year}}-{{month}}-{{day}}-{{slug}}\"
    fields:
      - {label: \"Title\", name: \"title\", widget: \"string\"}
      - {label: \"Body\", name: \"body\", widget: \"markdown\"}" > src/admin/config.yml

# Add a build script to package.json
npm set-script build "eleventy"
npm set-script start "eleventy --serve"

# Initialize Git repository and commit
git init
git add .
git commit -m "Initial setup with Eleventy, Tailwind CSS, and Netlify CMS"

echo "Setup complete! Run 'npm start' to serve your site locally."

