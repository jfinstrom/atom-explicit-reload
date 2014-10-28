module.exports =
  activate: ->
    console.log("Initialize explicit-reload");
    atom.workspace.onDidOpen ->
      console.log("explicit-reload : Prevent buffer reloading");
      atom.workspace.getActiveEditor().buffer.fileSubscriptions.dispose()
    atom.workspaceView.command "explicit-reload:reload", => @reload()
  reload: ->
    console.log("explicit-reload : Reloading buffer");
    atom.workspace.getActiveEditor().buffer.file.readSync(true);
    atom.workspace.getActiveEditor().buffer.load();
 