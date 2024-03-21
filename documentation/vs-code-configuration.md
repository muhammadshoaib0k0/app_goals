# VS code configuration

## Useful extensions

### Convenience:  
- [ansible-vault-inline](https://marketplace.visualstudio.com/items?itemName=wolfmah.ansible-vault-inline): inline encrypt/decrypt for ansible vault
- [Atom Keymap](https://marketplace.visualstudio.com/items?itemName=ms-vscode.atom-keybindings): Ports popular Atom keyboard shortcuts
- [Auto Brackets](https://marketplace.visualstudio.com/items?itemName=aliariff.auto-add-brackets)
- [Beautify](https://marketplace.visualstudio.com/items?itemName=michelemelluso.code-beautifier): Beautify css, sass and less code
- [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments): improve your code commenting
- [Emacs Keymap](https://marketplace.visualstudio.com/items?itemName=hiro-sun.vscode-emacs): Port popular Emacs keybindings to vs code
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens): git blame and stuff directly in VS code
- [Live Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare): real-time collaborative development
- [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense): Autocompletes filenames
- [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv): highlight CSV and TSV files
- [Rainbow Indent](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow): makes indentation easier to read
- [sort lines](https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines): sort lines of text
- [XML Tools](https://marketplace.visualstudio.com/items?itemName=DotJoshJohnson.xml): XML formatting, XQuery and XPath tools

### Linter:  
- [GitLab CI Validator](https://marketplace.visualstudio.com/items?itemName=cstuder.gitlab-ci-validator)
- [Rubocop](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop)
- [Sass Lint](https://marketplace.visualstudio.com/items?itemName=glen-84.sass-lint)
- [Slim Lint](https://marketplace.visualstudio.com/items?itemName=aliariff.slim-lint)

### Languages & Tools:  
- [Better Jinja](https://marketplace.visualstudio.com/items?itemName=samuelcolvin.jinjahtml)
- [CSV](https://marketplace.visualstudio.com/items?itemName=Syler.sass-indented)
- [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
- [GPG](https://marketplace.visualstudio.com/items?itemName=jvalecillos.gpg)
- [Jenkinsfile Support](https://marketplace.visualstudio.com/items?itemName=secanis.jenkinsfile-support)
- [NGINX configuration language support](https://marketplace.visualstudio.com/items?itemName=ahmadalli.vscode-nginx-conf)
- [Quokka.js  (JS scratchpad)](https://marketplace.visualstudio.com/items?itemName=WallabyJs.quokka-vscode)
- [Ruby Language Colorization](https://marketplace.visualstudio.com/items?itemName=groksrc.ruby)
- [Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)
- [Sass](https://marketplace.visualstudio.com/items?itemName=Syler.sass-indented)
- [Slim](https://marketplace.visualstudio.com/items?itemName=aliariff.slim-lint)
- [VSCode Ruby](https://marketplace.visualstudio.com/items?itemName=wingrunr21.vscode-ruby)
- [vscode-elixir](https://marketplace.visualstudio.com/items?itemName=mjmcloug.vscode-elixir)
- [Vue](https://marketplace.visualstudio.com/items?itemName=octref.vetur)
- [XML](https://marketplace.visualstudio.com/items?itemName=DotJoshJohnson.xml)
- [vscode-run-rspec-file](https://marketplace.visualstudio.com/items?itemName=Thadeu.vscode-run-rspec-file) -> Run and easily access spec files

### Theming:
- [Andromeda (dark)](https://marketplace.visualstudio.com/items?itemName=EliverLara.andromeda)
- [Celestial Theme (dark++)](https://marketplace.visualstudio.com/items?itemName=apvarun.celestial)
- [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
- [One Dark Vivid Theme (Atom)](https://marketplace.visualstudio.com/items?itemName=fivepointseven.vscode-theme-onedark-vivid)

### Configuration: 
- "Go to definition" for Ruby:
    1. Install the [Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby) package
    2. Set `Ruby: Intellisense` to `rubyLocat` in the package settings
    3. restart VS Code / VS Codium 
    4. You can now right click definitions and select  "Go to Definition" or "Peek" or use CMD+click
- "Newline at the end of each file":
    1. **Code -> Preferences -> Settings**
    2. Search for "insert newline"
    3. Tick the box
- bracket colorization:
    1. Press <kbd>CMD</kbd> + <kbd>SHIFT</kbd> + <kbd>P</kbd> and enter "settings json" and open `Preferences: Open Settings (JSON)`
    2. In the `settings.json`, add `"editor.guides.bracketPairs": "active"`
    3. Hit save
- "Open VS-Code" for iTerm2:
    1. Press <kbd>CMD</kbd> + <kbd>SHIFT</kbd> + <kbd>P</kbd> and enter "shell" and open `Shellbefehl: Befehl "code" in "PATH" installieren`
    2. Hit `ok` in Pop-up Menu
    3. Now `code .` or `EDITOR=code --wait ...` works
