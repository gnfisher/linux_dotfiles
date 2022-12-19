if [[ "$CODESPACES" = "true" ]]; then
  export PATH=$PATH:/workspaces/github/bin:/workspaces/github/node_modules/.bin/
  export PATH=node_modules/.bin:/usr/local/share/npm/bin:$PATH # Node/NPM
  export PATH=bin:$PATH
fi
