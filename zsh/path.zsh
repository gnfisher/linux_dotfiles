if [[ "$CODESPACES" = "true" ]]; then
  export PATH=/workspaces/github/vendor/node:/workspaces/github/bin:/workspaces/github/node_modules/.bin:$PATH
fi
